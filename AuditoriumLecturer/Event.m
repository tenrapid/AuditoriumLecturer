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

- (void)awakeFromFetch
{
	[self addObserver:self forKeyPath:@"modified" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)awakeFromInsert
{
	[self addObserver:self forKeyPath:@"modified" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)willTurnIntoFault
{
	[self removeObserver:self forKeyPath:@"modified"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"modified"]) {
		BOOL modified = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
		NSLog(@"%d", modified);
		if (modified) {
			self.title = [NSString stringWithFormat:@"%@ *", self.title];
		}
		else {
			self.title = [self.title substringToIndex:self.title.length - 3];
		}
	}
}

- (void)recordModification
{
	if (!self.modified.boolValue) {
		self.version = [NSNumber numberWithInteger:self.version.integerValue + 1];
		self.modified = [NSNumber numberWithBool:YES];
	}
}

@end
