//
//  Event.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 20.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Event.h"
#import "Question.h"


@implementation Event

@dynamic title;
@dynamic date;
@dynamic version;
@dynamic modified;
@dynamic auditoriumId;
@dynamic questions;

- (void)recordModification
{
	if (!self.modified.boolValue) {
		self.version = [NSNumber numberWithInteger:self.version.integerValue + 1];
		self.modified = [NSNumber numberWithBool:YES];
	}
}

@end
