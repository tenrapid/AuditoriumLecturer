//
//  LoggedInUser.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 30.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "LoggedInUser.h"

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
