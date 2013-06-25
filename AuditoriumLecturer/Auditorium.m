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
		[notificationCenter addObserver:self selector:@selector(disableSave:) name:QuestionEditSheetWillOpenNotification object:nil];
		[notificationCenter addObserver:self selector:@selector(enableSave:) name:QuestionEditSheetDidCloseNotification object:nil];
		[notificationCenter addObserver:self selector:@selector(contextDidSave:) name:NSManagedObjectContextDidSaveNotification object:context];

		[self addObserver:self forKeyPath:@"event" options:NSKeyValueObservingOptionNew context:nil];

		[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(save:) userInfo:nil repeats:YES];
	}
    return self;
}

- (void)contextDidSave:(NSNotification *)notification
{
	return;
	if (self.isPostEnabled) {
		NSLog(@"inserted: %@", [notification.userInfo objectForKey:@"inserted"]);
		NSLog(@"updated: %@", [notification.userInfo objectForKey:@"updated"]);
		NSLog(@"deleted: %@", [notification.userInfo objectForKey:@"deleted"]);
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"event"]) {
		if (self.event) {
//			[self performSelector:@selector(createTestQuestions) withObject:nil afterDelay:simulatedNetworkDelay];
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

	self.saveEnabled = NO;

	[context processPendingChanges];
	[context.undoManager disableUndoRegistration];
	
	Event *event1 = [Auditorium objectForEntityName:@"Event"];
	event1.title = @"Rechnernetze – 2. Vorlesung – 24.06.2013";
	event1.date	= [NSDate dateWithString:@"2013-06-24 10:00:00 +0000"];

	Event *event2 = [Auditorium objectForEntityName:@"Event"];
	event2.title = @"Rechnernetze – 3. Vorlesung – 31.06.2013";
	event2.date	= [NSDate dateWithString:@"2013-06-31 10:00:00 +0000"];

	event2 = [Auditorium objectForEntityName:@"Event"];
	event2.title = @"Veranstaltung wählen…";
	event2.date	= [NSDate dateWithString:@"0000-00-00 00:00:00 +0000"];

	[context processPendingChanges];
	[context.undoManager enableUndoRegistration];

	self.postEnabled = NO;
	error = nil;
	[context save:&error];
	if (error) {
		NSLog(@"%@", error);
	}
	self.postEnabled = YES;
	self.saveEnabled = YES;
}

- (void)createTestQuestions
{
	self.saveEnabled = NO;

	[context processPendingChanges];
	[context.undoManager disableUndoRegistration];
	
	Question *question;
	Answer *answer;
	
	question = [Auditorium objectForEntityName:@"Question"];
	question.event = self.event;
	question.slideIdentifier = [NSNumber numberWithInteger:1];
	question.text = @"Warum sind Modelle des selbstgesteuerten bzw. selbstregulierten Lernens für computergestützte Lehr-Lernszenarien von Bedeutung?";
	question.type = QuestionSingleChoiceType;

	answer = [Auditorium objectForEntityName:@"Answer"];
	answer.correct = [NSNumber numberWithBool:YES];
	answer.text = @"Das Konzept legt Anforderungen offen, bei denen der Lerner durch den Computer unterstützt werden kann.";
	answer.feedback = @"Der Computer eignet sich um dem Lerner adaptiv Unterstützung zu geben.";
	answer.order = [NSNumber numberWithInteger:0];
	[question addAnswersObject:answer];
	answer = [Auditorium objectForEntityName:@"Answer"];
	answer.correct = [NSNumber numberWithBool:NO];
	answer.text = @"Das Konzept legt Anforderungen offen, bei denen der Computer durch den Lerner unterstützt werden kann.";
	answer.feedback = @"Es geht primär um die Unterstützung des Lerners, nicht um die Unterstützung eines selbstreguliert lernenden Computers.";
	answer.order = [NSNumber numberWithInteger:1];
	[question addAnswersObject:answer];
	answer = [Auditorium objectForEntityName:@"Answer"];
	answer.correct = [NSNumber numberWithBool:NO];
	answer.text = @"Das Konzept trifft Aussagen über Lehr-Lernprozesse beim computergestützten Lernen.";
	answer.feedback = @"Das computergestützte Lernen wird nicht direkt thematisiert, es ist lediglich eine von vielen Anwendungssituationen, da Lernen am Computer zu einem großen Teil selbstgesteuert ist.";
	answer.order = [NSNumber numberWithInteger:2];
	[question addAnswersObject:answer];
	answer = [Auditorium objectForEntityName:@"Answer"];
	answer.correct = [NSNumber numberWithBool:NO];
	answer.text = @"Das Konzept trifft Aussagen über volitionale Prozesse beim computergestützten Lernen.";
	answer.feedback = @"Volitionale Prozesse werden thematisiert, allerdings nicht explizit in Bezug auf das computergestützte Lernen.";
	answer.order = [NSNumber numberWithInteger:3];
	[question addAnswersObject:answer];

	[context processPendingChanges];
	[context.undoManager enableUndoRegistration];
	
	self.postEnabled = NO;
	NSError *error = nil;
	[context save:&error];
	if (error) {
		NSLog(@"%@", error);
	}
	self.postEnabled = YES;
	self.saveEnabled = YES;
}

- (void)save:(NSTimer*)timer
{
	NSError *error = nil;
	if (context.hasChanges && self.isSaveEnabled) {
		[context save:&error];
		if (error) {
			NSLog(@"%@", error);
		}
	}
}

- (void)disableSave:(NSNotification *)notification
{
	self.saveEnabled = NO;
}

- (void)enableSave:(NSNotification *)notification
{
	self.saveEnabled = YES;
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

- (void)sendSlide:(Slide *)slide
{
	NSArray *keys = [NSArray arrayWithObjects:@"number", @"identifier", @"title", @"body", @"notes", nil];
	NSDictionary *currentSlide = [slide dictionaryWithValuesForKeys:keys];
	NSLog(@"%@", currentSlide);
}

@end
