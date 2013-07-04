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
#import "LoggedInUser.h"
#import "QuestionEditSheetController.h"
#import "SyncInfoSheetController.h"
#import "ResolveSyncConflictSheetController.h"

typedef enum SyncState {
	NoSyncSyncState = 0,
	SyncEventsSyncState = 1,
	SyncQuestionsSyncState = 2,
	FinishSyncSyncState = 3
} SyncState;

@interface Auditorium ()
{
	NSMutableArray *eventsToPull;
	NSMutableArray *eventsToPush;
	NSMutableArray *eventsInConflict;
	NSMutableArray *eventsSyncing;
}

@property (assign) NSManagedObjectContext *context;
@property (retain) AuditoriumNetworkManager *networkManager;
@property (assign) SyncState syncState;
@property (retain) id loginDelegate;
@property (retain) id logoutDelegate;
@property (retain) SyncInfoSheetController *syncInfoSheetController;
@property (retain) ResolveSyncConflictSheetController *resolveSyncConflictSheetController;

@end

@implementation Auditorium

@synthesize loggedIn;
@synthesize loggedInUser;
@synthesize syncing;
@synthesize event = _event;

@synthesize context;
@synthesize networkManager;
@synthesize syncState;
@synthesize loginDelegate;
@synthesize logoutDelegate;
@synthesize syncInfoSheetController;
@synthesize resolveSyncConflictSheetController;

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

		eventsToPull = [[NSMutableArray alloc] init];
		eventsToPush = [[NSMutableArray alloc] init];
		eventsSyncing = [[NSMutableArray alloc] init];
		eventsInConflict = [[NSMutableArray alloc] init];
	}
    return self;
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
	
	Event *event = [Auditorium objectForEntityName:@"Event"];
	event.title = @"Testvorlesung – 19.07.2013";
	event.date	= [NSDate dateWithString:@"2013-07-19 10:00:00 +0000"];

	[context processPendingChanges];
	[context.undoManager enableUndoRegistration];
}

#pragma mark Login/Logout

- (void)loginWithEmail:(NSString *)email password:(NSString *)password delegate:(id)delegate
{
	self.loginDelegate = delegate;
	[self.networkManager loginWithEmail:email password:password];
}

- (void)cancelLogin
{
	[self.networkManager cancelLogin];
}

- (void)didLogin:(LoggedInUser *)user
{
	[self performSelector:@selector(createTestEvents) withObject:nil afterDelay:0];
	self.loggedInUser = user;
	self.loggedIn = YES;

	[self.loginDelegate performSelector:@selector(didLogin) withObject:nil];
	self.loginDelegate = nil;

	[self sync];
}

- (void)didFailLogin:(NSString *)error
{
	self.loggedIn = NO;

	[self.loginDelegate performSelector:@selector(didFailLogin:) withObject:error];
	self.loginDelegate = nil;
}

- (void)logoutWithDelegate:(id)delegate
{
	self.logoutDelegate = delegate;
	[self.networkManager logout:self.loggedInUser];
}

- (void)didLogout
{
	self.loggedInUser = nil;
	self.loggedIn = NO;

	[self.logoutDelegate performSelector:@selector(didLogout) withObject:nil];
	self.logoutDelegate = nil;
}

#pragma mark Sync

- (void)sync
{
	if (self.syncState != NoSyncSyncState) {
		return;
	}
	[self updateSyncState];
}

- (void)updateSyncState
{
	switch (self.syncState) {
		case NoSyncSyncState:
			self.syncState = SyncEventsSyncState;
			self.syncing = YES;
			self.syncInfoSheetController = [[[SyncInfoSheetController alloc] init] autorelease];
			[self.syncInfoSheetController setMessage:@"Lade Veranstaltungen…"];
			[self.networkManager eventsForUser:self.loggedInUser];
			break;
			
		case SyncEventsSyncState:
			self.syncState = SyncQuestionsSyncState;
			[self syncQuestions];
			break;
			
		case SyncQuestionsSyncState:
			if (eventsSyncing.count && !eventsInConflict.count) {
				if (!self.syncInfoSheetController) {
					self.syncInfoSheetController = [[[SyncInfoSheetController alloc] init] autorelease];
				}
				[self.syncInfoSheetController setMessage:@"Synchronisiere Nachrichten…"];
			}
			else if (eventsInConflict.count) {
				if (!self.resolveSyncConflictSheetController) {
					if (self.syncInfoSheetController) {
						self.syncInfoSheetController = nil;
					}
					[self performSelector:@selector(resolveSyncConflict) withObject:nil afterDelay:0];
				}
			}
			else if (!eventsSyncing.count && !eventsInConflict.count) {
				self.syncState = FinishSyncSyncState;
				[self updateSyncState];
			}
			break;
			
		case FinishSyncSyncState:
			if (self.syncInfoSheetController) {
				self.syncInfoSheetController = nil;
			}
			self.syncState = NoSyncSyncState;
			self.syncing = NO;
			break;
	}
}

- (void)cancelSync
{
	if (self.syncState == SyncEventsSyncState) {
		[self.networkManager cancelEventsForUser];
	}
	else if (self.syncState == SyncQuestionsSyncState) {
		for (Event *event in eventsSyncing) {
			[self.networkManager cancelPullPushQuestionsForEvent:event];
		}
	}
	[eventsToPull removeAllObjects];
	[eventsToPush removeAllObjects];
	[eventsInConflict removeAllObjects];
	[eventsSyncing removeAllObjects];
	self.syncState = FinishSyncSyncState;
	[self updateSyncState];
}

- (void)didEventsForUser:(NSArray *)serverEvents
{
	[context processPendingChanges];
	[context.undoManager disableUndoRegistration];

	NSError *error = nil;

	// fetch local events…
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:context]];
	NSArray *localEventsArray = [context executeFetchRequest:fetchRequest error:&error];

	// …and build auditoriumId-to-localEvent map
	NSMutableDictionary *localEvents = [NSMutableDictionary dictionary];
	for (Event *event in localEventsArray) {
		[localEvents setObject:event forKey:event.auditoriumId];
	}
	
	NSMutableArray *localEventsAuditoriumIds = [[localEvents allKeys] mutableCopy];
	NSArray *keysToUpdate = @[@"auditoriumId", @"title", @"date"];
	
	for (NSDictionary *serverEvent in serverEvents) {
		NSNumber *auditoriumId = [serverEvent objectForKey:@"auditoriumId"];
		Event *localEvent;
		if ([localEventsAuditoriumIds containsObject:auditoriumId]) {
			// get existing local event…
			localEvent = [localEvents objectForKey:auditoriumId];
			[localEventsAuditoriumIds removeObject:auditoriumId];
		}
		else {
			// …or create a new one
			localEvent = [Auditorium objectForEntityName:@"Event"];
			[localEvents setObject:localEvent forKey:auditoriumId];
		}
		// update local event with data from server
		for (NSString *key in keysToUpdate) {
			[localEvent setValue:[serverEvent valueForKey:key] forKey:key];
		}
	}

	// local events that are not on the server will be deleted
	NSPredicate *localEventsToDeletePredicate = [NSPredicate predicateWithFormat:@"auditoriumId IN %@", localEventsAuditoriumIds];
	NSArray *localEventsToDelete = [[localEvents allValues] filteredArrayUsingPredicate:localEventsToDeletePredicate];
	for (Event *localEventToDelete in localEventsToDelete) {
		if ([localEventToDelete isEqualTo:self.event]) {
			self.event = nil;
		}
		[context deleteObject:localEventToDelete];
		[localEvents removeObjectForKey:localEventToDelete.auditoriumId];
	}
	
	[context processPendingChanges];
	[context.undoManager enableUndoRegistration];
	
	for (NSDictionary *serverEvent in serverEvents) {
		Event *localEvent = [localEvents objectForKey:[serverEvent objectForKey:@"auditoriumId"]];
		NSInteger localVersion = localEvent.version.integerValue;
		NSInteger serverVersion = ((NSNumber *)[serverEvent objectForKey:@"version"]).integerValue;
		if (localVersion == serverVersion) {
			if (localEvent.modified.boolValue) {
				[eventsInConflict addObject:localEvent];
			}
		}
		else {
			if (localVersion > serverVersion) {
				[eventsToPush addObject:localEvent];
			}
			else {
				[eventsToPull addObject:localEvent];
			}
		}
	}

	[self updateSyncState];
}

- (void)didFailEventsForUser:(NSString *)error
{
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert addButtonWithTitle:@"OK"];
	[alert setMessageText:error];
	[alert setAlertStyle:NSWarningAlertStyle];
	[alert runModal];
	self.syncState = FinishSyncSyncState;
	[self updateSyncState];
}

- (void)syncQuestions
{
	NSLog(@"pull %@\npush %@\nconflict %@", eventsToPull, eventsToPush, eventsInConflict);
	
	for (Event *eventToPull in eventsToPull) {
		[eventsSyncing addObject:eventToPull];
		[networkManager pullQuestionsForEvent:eventToPull user:self.loggedInUser];
	}
	[eventsToPull removeAllObjects];
	
	for (Event *eventToPush in eventsToPush) {
		[eventsSyncing addObject:eventToPush];
		[networkManager pushQuestionsForEvent:eventToPush user:self.loggedInUser];
	}
	[eventsToPush removeAllObjects];
	
	[self updateSyncState];
}

- (void)didPullQuestionsForEvent:(Event *)event version:(NSInteger)version questions:(NSArray *)_questions
{
//	NSLog(@"%@\n%@", event, questions);
	
	[context processPendingChanges];
	[context.undoManager disableUndoRegistration];
	
	event.version = [NSNumber numberWithInteger:version];
	event.modified = [NSNumber numberWithBool:NO];

	NSSet *questionsToDelete = [event.questions copy];
	[event removeQuestions:questionsToDelete];
	for (Question *questionToDelete in questionsToDelete) {
		[context deleteObject:questionToDelete];
	}

	NSMutableSet *questions = [NSMutableSet set];
	for (NSDictionary *_question in _questions) {
		Question *question = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:context];
		for (NSString *key in @[@"uuid", @"type", @"text", @"slideIdentifier"]) {
			if ([_question objectForKey:key] != [NSNull null]) {
				[question setPrimitiveValue:[_question objectForKey:key] forKey:key];
			}
		}
		NSMutableSet *answers = [NSMutableSet set];
		for (NSDictionary *_answer in [_question objectForKey:@"answers"]) {
			Answer *answer = [NSEntityDescription insertNewObjectForEntityForName:@"Answer" inManagedObjectContext:context];
			for (NSString *key in @[@"uuid", @"text", @"feedback", @"correct"]) {
				if ([_answer objectForKey:key] != [NSNull null]) {
					[answer setPrimitiveValue:[_answer objectForKey:key] forKey:key];
				}
			}
			[answers addObject:answer];
		}
		[question addAnswers:answers];
		[questions addObject:question];
	}
	[event addQuestions:questions];

	[context processPendingChanges];
	[context.undoManager enableUndoRegistration];
	
	[eventsSyncing removeObject:event];
	[self updateSyncState];
}

- (void)didPushQuestionsForEvent:(Event *)event
{
	[context processPendingChanges];
	[context.undoManager disableUndoRegistration];
	
	event.modified = [NSNumber numberWithBool:NO];

	[context processPendingChanges];
	[context.undoManager enableUndoRegistration];
	
	[eventsSyncing removeObject:event];
	[self updateSyncState];
}

- (void)didFailPullPushQuestionsForEvent:(Event *)event error:(NSString *)error
{
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert addButtonWithTitle:@"OK"];
	[alert setMessageText:error];
	[alert setAlertStyle:NSWarningAlertStyle];
	[alert runModal];
	[eventsSyncing removeObject:event];
	[self updateSyncState];
}

- (void)resolveSyncConflict
{
	Event *eventInConflict  = eventsInConflict.lastObject;
	self.resolveSyncConflictSheetController = [[[ResolveSyncConflictSheetController alloc] initWithEvent:eventInConflict] autorelease];
}

- (void)didResolveSyncConflict:(Event *)event resolve:(ResolveThroughPushOrPull)resolve
{
	self.resolveSyncConflictSheetController = nil;
	[eventsInConflict removeObject:event];
	if (resolve == ResolveThroughPull) {
		[eventsToPull addObject:event];
	}
	else if (resolve == ResolveThroughPush) {
		[eventsToPush addObject:event];
	}
	[self syncQuestions];
}

#pragma mark Sending current slide to server

- (void)sendSlide:(Slide *)slide
{
	NSArray *keys = [NSArray arrayWithObjects:@"number", @"identifier", @"title", @"body", @"notes", nil];
	NSDictionary *currentSlide = [slide dictionaryWithValuesForKeys:keys];
	NSLog(@"%@", currentSlide);
}

@end
