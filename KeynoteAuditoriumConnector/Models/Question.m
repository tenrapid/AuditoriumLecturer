//
//  Question.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 16.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Question.h"


@implementation Question

@dynamic text;
@dynamic slideIdentifier;
@dynamic order;

- (void)setSlideIdentifier:(NSNumber *)slideIdentifier
{
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:self.entity];
	
	if (self.slideIdentifier.integerValue != 0) {
		[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(slideIdentifier = %@) AND (order > %@)", self.slideIdentifier, self.order]];
		NSArray *questions = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
		for (Question *question in questions) {
			question.order = [NSNumber numberWithInteger:question.order.integerValue - 1];
		}
	}

	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"slideIdentifier = %@", slideIdentifier]];
	[fetchRequest setIncludesPropertyValues:NO];
	[fetchRequest setIncludesSubentities:NO];
	NSInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
	self.order = [NSNumber numberWithInteger:count];

	[self willChangeValueForKey:@"slideIdentifier"];
	[self setPrimitiveValue:slideIdentifier forKey:@"slideIdentifier"];
	[self didChangeValueForKey:@"slideIdentifier"];
	
	[fetchRequest release];
}

@end
