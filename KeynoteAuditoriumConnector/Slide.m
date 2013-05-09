//
//  Slide.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 05.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Slide.h"

@implementation Slide

@synthesize number;
@synthesize identifier;
@synthesize title;
@synthesize body;
@synthesize notes;

- (id)initWithNumber:(NSInteger)slideNumber identifier:(NSInteger)slideIdentifier title:(NSString *)slideTitle body:(NSString *)slideBody notes:(NSString *)slideNotes
{
	self = [super init];
    if (self) {
		number = slideNumber;
		identifier = slideIdentifier;
		title = slideTitle;
		body = slideBody;
		notes = slideNotes;
    }
    return self;
}

@end


