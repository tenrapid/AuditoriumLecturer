//
//  Auditorium.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Auditorium.h"
#import "AuditoriumEvent.h"
#import "Slideshow.h"
#import "Question.h"

@implementation Auditorium

@synthesize loggedIn;
@synthesize loggedInUser;

@synthesize events;
@synthesize questions;

- (id)init
{
	self = [super init];
    if (self) {
		self.questions = [NSMutableArray array];

		self.events = [NSMutableArray array];
		[events addObject:[[AuditoriumEvent alloc] initWithIdentifier:@"1" title:@"Rechnernetze – 2. Vorlesung – 24.05.2013"]];
		[events addObject:[[AuditoriumEvent alloc] initWithIdentifier:@"2" title:@"Rechnernetze – 3. Vorlesung – 31.05.2013"]];
	}
    return self;
}

- (void)awakeFromNib
{
	NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
	
	Question *question;
	
	question = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:context];
	question.slideIdentifier = [NSNumber numberWithInteger:1];
	question.text = @"Hier könnte Ihre 1. Frage stehen!";
	
	question = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:context];
	question.slideIdentifier = [NSNumber numberWithInteger:1];
	question.text = @"Hier könnte Ihre 2. Frage stehen!";

	question = [NSEntityDescription insertNewObjectForEntityForName:@"Question" inManagedObjectContext:context];
	question.slideIdentifier = [NSNumber numberWithInteger:2];
	question.text = @"Hier könnte Ihre 3. Frage stehen!";

	[[[question managedObjectContext] undoManager] performSelector:@selector(removeAllActions) withObject:nil afterDelay:0.0];
	return;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password delegate:(id)delegate
{
	[self performSelector:@selector(didLogin:) withObject:delegate afterDelay:0.1];
	self.loggedInUser = username;
}

- (void)logoutWithDelegate:(id)delegate
{
	[self performSelector:@selector(didLogout:) withObject:delegate afterDelay:1];
	self.loggedInUser = nil;
}

- (void)didLogin:(id)delegate
{
	[delegate performSelector:@selector(didLogin) withObject:nil];
	self.loggedIn = YES;
}

- (void)didFailLogin:(id)delegate
{
	[delegate performSelector:@selector(didFailWithError:context:) withObject:@"Benutzername/Passwort falsch" withObject:@"login"];
	self.loggedIn = NO;
}

- (void)didLogout:(id)delegate
{
	[delegate performSelector:@selector(didLogout) withObject:nil];
	self.loggedIn = NO;
}

- (void)sendSlide:(Slide *)slide
{
	NSArray *keys = [NSArray arrayWithObjects:@"number", @"identifier", @"title", @"body", @"notes", nil];
	NSDictionary *currentSlide = [slide dictionaryWithValuesForKeys:keys];
	NSLog(@"%@", currentSlide);
}

- (void)getEventsWithDelegate:(id)delegate
{
	[self performSelector:@selector(didGetEvents:) withObject:delegate afterDelay:0.1];
}

- (void)didGetEvents:(id)delegate
{
	[delegate performSelector:@selector(didGetEvents:) withObject:self.events];
}

- (void)fetchQuestionsForEvent:(AuditoriumEvent *)event
{
}

@end
