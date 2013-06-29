//
//  Auditorium.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Auditorium.h"
#import "AuditoriumNetworkManager.h"
#import "AuditoriumObject.h"
#import "Event.h"
#import "Question.h"
#import "Answer.h"
#import "QuestionEditSheetController.h"

#define simulatedNetworkDelay 0


@implementation LoggedInUser

@synthesize userName;
@synthesize firstName;
@synthesize lastName;
@synthesize email;
@synthesize authToken;

- (void)dealloc
{
	[self.userName release];
	[self.firstName release];
	[self.lastName release];
	[self.email release];
	[self.authToken release];
	[super dealloc];
}

@end


@interface Auditorium ()

@property (assign) NSManagedObjectContext *context;
@property (retain) AuditoriumNetworkManager *networkManager;
@property (getter = isSaveEnabled) BOOL saveEnabled;
@property (getter = isPostEnabled) BOOL postEnabled;
@property (retain) id loginDelegate;
@property (retain) id logoutDelegate;

@end

@implementation Auditorium

@synthesize loggedIn;
@synthesize loggedInUser;
@synthesize saveEnabled;
@synthesize postEnabled;
@synthesize context;
@synthesize networkManager;

@synthesize event;


#pragma mark  Class Methods

+ (Auditorium *)sharedInstance
{
	static Auditorium *sharedInstance;
	@synchronized(self)
	{
		if (!sharedInstance) {
			sharedInstance = [[Auditorium alloc] init];
		}
		return sharedInstance;
	}
}

+ (id)objectForEntityName:(NSString *)entityName
{
	NSManagedObjectContext *context = [self sharedInstance].context;
	NSUndoManager *undoManager = context.undoManager;

	AuditoriumObject *object = nil;
	
	if ([undoManager isUndoRegistrationEnabled]) {
		// in this branch undo registration is disabled to preserve uuids after undoing the creation of an object
		[context processPendingChanges];
		[undoManager disableUndoRegistration];
		object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
		object.uuid = [self UUIDString];
		[context processPendingChanges];
		[undoManager enableUndoRegistration];
		[undoManager registerUndoWithTarget:context selector:@selector(deleteObject:) object:object];
	}
	else {
		// undo registration is already disabled if objects from parsed json are inserted into the context
		object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
		object.uuid = [self UUIDString];
	}
	
	return object;
}

+ (NSString*)UUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [(NSString *)string autorelease];
}


#pragma mark  Instance Methods

- (id)init
{
	self = [super init];
    if (self) {
		context = [[NSApp delegate] managedObjectContext];
		networkManager = [[AuditoriumNetworkManager alloc] init];
		networkManager.delegate = self;

		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(contextDidSave:) name:NSManagedObjectContextDidSaveNotification object:context];

		[self addObserver:self forKeyPath:@"event" options:NSKeyValueObservingOptionNew context:nil];
	}
    return self;
}

- (void)contextDidSave:(NSNotification *)notification
{
	return;
	NSLog(@"inserted: %@", [notification.userInfo objectForKey:@"inserted"]);
	NSLog(@"updated: %@", [notification.userInfo objectForKey:@"updated"]);
	NSLog(@"deleted: %@", [notification.userInfo objectForKey:@"deleted"]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"event"]) {
		if (self.event) {
		}
	}
}

- (void)createTestEvents
{
	NSError *error = nil;

	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:context]];
	if ([context countForFetchRequest:fetchRequest error:&error]) {
		return;
	}

	[context processPendingChanges];
	[context.undoManager disableUndoRegistration];
	
	Event *event1 = [Auditorium objectForEntityName:@"Event"];
	event1.title = @"Testvorlesung – 19.07.2013";
	event1.date	= [NSDate dateWithString:@"2013-07-19 10:00:00 +0000"];

	[context processPendingChanges];
	[context.undoManager enableUndoRegistration];
}

#pragma mark Login/Logout

- (void)loginWithEmail:(NSString *)email password:(NSString *)password delegate:(id)delegate
{
	self.loginDelegate = delegate;
	[self.networkManager loginWithEmail:email password:password];
}

- (void)logoutWithDelegate:(id)delegate
{
	self.logoutDelegate = delegate;
	[self.networkManager logout:self.loggedInUser];
}

- (void)didLogin:(LoggedInUser *)user
{
	[self performSelector:@selector(createTestEvents) withObject:nil afterDelay:simulatedNetworkDelay];
	self.loggedInUser = user;
	self.loggedIn = YES;
	[self.networkManager eventsForUser:self.loggedInUser];

	[self.loginDelegate performSelector:@selector(didLogin) withObject:nil];
	self.loginDelegate = nil;

}

- (void)didFailLogin:(NSString *)error
{
	self.loggedIn = NO;
	
	[self.loginDelegate performSelector:@selector(didFailLogin:) withObject:error];
	self.loginDelegate = nil;
}

- (void)didLogout
{
	self.loggedInUser = nil;
	self.loggedIn = NO;

	[self.logoutDelegate performSelector:@selector(didLogout) withObject:nil];
	self.logoutDelegate = nil;
}

#pragma mark Events

- (void)didEventsForUser:(NSArray *)serverEvents
{
	[context processPendingChanges];
	[context.undoManager disableUndoRegistration];

	NSError *error = nil;

	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:context]];
	NSArray *localEvents = [context executeFetchRequest:fetchRequest error:&error];
	
	NSMutableArray *localEventsAuditoriumIds = [[localEvents valueForKeyPath:@"auditoriumId"] mutableCopy];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"auditoriumId = $AUDITORIUM_ID"];

	for (NSDictionary *serverEvent in serverEvents) {
		Event *localEvent;
		NSNumber *auditoriumId = [serverEvent objectForKey:@"auditoriumId"];
		if ([localEventsAuditoriumIds containsObject:auditoriumId]) {
			NSDictionary *variables = @{@"AUDITORIUM_ID": auditoriumId};
			localEvent = [localEvents filteredArrayUsingPredicate:[predicate predicateWithSubstitutionVariables:variables]][0];
			[localEventsAuditoriumIds removeObject:auditoriumId];
		}
		else {
			localEvent = [Auditorium objectForEntityName:@"Event"];
		}
		[localEvent setValuesForKeysWithDictionary:serverEvent];
	}

	NSArray *localEventsToDelete = [localEvents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"auditoriumId IN %@", localEventsAuditoriumIds]];
	for (Event *localEventToDelete in localEventsToDelete) {
		if ([localEventToDelete isEqualTo:self.event]) {
			self.event = nil;
		}
		[context deleteObject:localEventToDelete];
	}
	
	[context processPendingChanges];
	[context.undoManager enableUndoRegistration];
}

#pragma mark Sending current slide to server

- (void)sendSlide:(Slide *)slide
{
	NSArray *keys = [NSArray arrayWithObjects:@"number", @"identifier", @"title", @"body", @"notes", nil];
	NSDictionary *currentSlide = [slide dictionaryWithValuesForKeys:keys];
	NSLog(@"%@", currentSlide);
}

@end
