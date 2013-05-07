//
//  AuditoriumEvent.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 05.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AuditoriumEvent.h"


@implementation AuditoriumEvent

@synthesize identifier;
@synthesize title;

- (id)initWithIdentifier:(NSString *)eventIdentifier title:(NSString *)eventTitle
{
	self = [super init];
    if (self) {
		identifier = eventIdentifier;
		title = eventTitle;
    }
    return self;
}

- (void)dealloc
{
	[identifier release];
	[title release];
	[super dealloc];
}

@end
