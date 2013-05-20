//
//  Auditorium.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Auditorium.h"
#import "AuditoriumObject.h"
#import "AuditoriumEvent.h"
#import "Event.h"
#import "Question.h"
#import "SlideQuestionsView.h"

@implementation Auditorium

@synthesize loggedIn;
@synthesize loggedInUser;
@synthesize saveEnabled;
@synthesize postEnabled;
@synthesize context;

@synthesize event;

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
	AuditoriumObject *object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self sharedInstance].context];
	object.uuid = [self UUIDString];
	return object;
}

+ (NSString*)UUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [(NSString *)string autorelease];
}

- (id)init
{
	self = [super init];
    if (self) {
		context = [[NSApp delegate] managedObjectContext];

		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(disableSave:) name:QuestionEditSheetWillOpenNotification object:nil];
		[notificationCenter addObserver:self selector:@selector(enableSave:) name:QuestionEditSheetDidCloseNotification object:nil];
		[notificationCenter addObserver:self selector:@selector(contextDidSave:) name:NSManagedObjectContextDidSaveNotification object:context];

		[self addObserver:self forKeyPath:@"event" options:NSKeyValueObservingOptionNew context:nil];

		[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(save:) userInfo:nil repeats:YES];
	}
    return self;
}

- (void)contextDidSave:(NSNotification *)notification
{
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
			[self performSelector:@selector(createTestQuestions) withObject:nil afterDelay:1];
		}
	}
}

- (void)createTestEvents
{
	self.saveEnabled = NO;

	Event *event1 = [Auditorium objectForEntityName:@"Event"];
	event1.title = @"Rechnernetze – 2. Vorlesung – 24.06.2013";
	event1.date	= [NSDate dateWithString:@"2013-06-24 10:00:00 +0000"];

	Event *event2 = [Auditorium objectForEntityName:@"Event"];
	event2.title = @"Rechnernetze – 3. Vorlesung – 31.06.2013";
	event2.date	= [NSDate dateWithString:@"2013-06-31 10:00:00 +0000"];

	event2 = [Auditorium objectForEntityName:@"Event"];
	event2.title = @"Veranstaltung wählen…";
	event2.date	= [NSDate dateWithString:@"0000-00-00 00:00:00 +0000"];

	self.postEnabled = NO;
	NSError *error = nil;
	[context save:&error];
	if (error) {
		NSLog(@"%@", error);
	}
	self.postEnabled = YES;
	self.saveEnabled = YES;
	[context.undoManager performSelector:@selector(removeAllActions) withObject:nil afterDelay:0.0];
}

- (void)createTestQuestions
{
	self.saveEnabled = NO;

	Question *question;

	question = [Auditorium objectForEntityName:@"Question"];
	question.event = self.event;
	question.slideNumber = [NSNumber numberWithInteger:1];
	question.text = @"Hier könnte Ihre 1. Frage stehen!";

	question = [Auditorium objectForEntityName:@"Question"];
	question.event = self.event;
	question.slideNumber = [NSNumber numberWithInteger:1];
	question.text = @"Hier könnte Ihre 2. Frage stehen!";

	question = [Auditorium objectForEntityName:@"Question"];
	question.event = self.event;
	question.slideNumber = [NSNumber numberWithInteger:2];
	question.text = @"Hier könnte Ihre 3. Frage stehen!";

	self.postEnabled = NO;
	NSError *error = nil;
	[context save:&error];
	if (error) {
		NSLog(@"%@", error);
	}
	self.postEnabled = YES;
	self.saveEnabled = YES;
	[context.undoManager performSelector:@selector(removeAllActions) withObject:nil afterDelay:0.0];
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

- (void)loginWithUsername:(NSString *)username password:(NSString *)password delegate:(id)delegate
{
	self.loggedInUser = username;
	[self performSelector:@selector(didLogin:) withObject:delegate afterDelay:0.1];
}

- (void)logoutWithDelegate:(id)delegate
{
	self.event = nil;
	[self performSelector:@selector(didLogout:) withObject:delegate afterDelay:1];
}

- (void)didLogin:(id)delegate
{
	[self performSelector:@selector(createTestEvents) withObject:nil afterDelay:1];
	self.loggedIn = YES;
	[delegate performSelector:@selector(didLogin) withObject:nil];
}

- (void)didFailLogin:(id)delegate
{
	self.loggedIn = NO;
	[delegate performSelector:@selector(didFailWithError:context:) withObject:@"Benutzername/Passwort falsch" withObject:@"login"];
}

- (void)didLogout:(id)delegate
{
	self.loggedInUser = nil;
	self.loggedIn = NO;

	self.saveEnabled = NO;
	self.postEnabled = NO;
	for (NSManagedObject *object in [context registeredObjects]) {
		[context deleteObject:object];
	}
	NSError *error = nil;
	[context save:&error];
	if (error) {
		NSLog(@"%@", error);
	}
	self.postEnabled = YES;
	self.saveEnabled = YES;

	[delegate performSelector:@selector(didLogout) withObject:nil];
}

- (void)sendSlide:(Slide *)slide
{
	NSArray *keys = [NSArray arrayWithObjects:@"number", @"identifier", @"title", @"body", @"notes", nil];
	NSDictionary *currentSlide = [slide dictionaryWithValuesForKeys:keys];
	NSLog(@"%@", currentSlide);
}

@end
