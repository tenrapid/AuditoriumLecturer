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


@implementation Auditorium

@synthesize loggedIn;
@synthesize loggedInUser;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password delegate:(id)delegate
{
	[self performSelector:@selector(didLogin:) withObject:delegate afterDelay:1];
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
	NSDictionary *currentSlide = [slide dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"number", @"title", @"body", @"notes", nil] ];
	NSLog(@"%@", currentSlide);
}

- (void)getEventsWithDelegate:(id)delegate
{
	[self performSelector:@selector(didGetEvents:) withObject:delegate afterDelay:1];
}

- (void)didGetEvents:(id)delegate
{
	NSMutableArray *events = [NSMutableArray arrayWithCapacity:3];
	[events addObject:[[AuditoriumEvent alloc] initWithIdentifier:@"1" title:@"Rechnernetze – 2. Vorlesung – 24.05.2013"]];
	[events addObject:[[AuditoriumEvent alloc] initWithIdentifier:@"2" title:@"Rechnernetze – 3. Vorlesung – 31.05.2013"]];
	[delegate performSelector:@selector(didGetEvents:) withObject:events];
}

@end
