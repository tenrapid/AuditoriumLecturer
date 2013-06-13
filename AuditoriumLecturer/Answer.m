//
//  Answer.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 19.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Answer.h"
#import "AuditoriumObject.h"


@implementation Answer

@dynamic question;
@dynamic text;
@dynamic order;
@dynamic correct;

- (void)setQuestion:(Question *)question
{
	if (question) {
		if (self.order.integerValue != 0) {
			NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(question = %@) AND (order >= %@)", question, self.order];
			NSArray *answers = [self fetchWithPredicate:predicate];
			for (Answer *answer in answers) {
				[answer willChangeValueForKey:@"order"];
				[answer setPrimitiveValue:[NSNumber numberWithInteger:answer.order.integerValue + 1] forKey:@"order"];
				[answer didChangeValueForKey:@"order"];
			}
		}
		else {
			NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(question = %@)", question];
			NSInteger count = [self countWithPredicate:predicate];
			[self willChangeValueForKey:@"order"];
			[self setPrimitiveValue:[NSNumber numberWithInteger:count] forKey:@"order"];
			[self didChangeValueForKey:@"order"];
		}
	}
	else {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(question = %@) AND (order > %@)", self.question, self.order];
		NSArray *answers = [self fetchWithPredicate:predicate];
		for (Answer *answer in answers) {
			[answer willChangeValueForKey:@"order"];
			[answer setPrimitiveValue:[NSNumber numberWithInteger:answer.order.integerValue - 1] forKey:@"order"];
			[answer didChangeValueForKey:@"order"];
		}
	}

	[self willChangeValueForKey:@"question"];
	[self setPrimitiveValue:question forKey:@"question"];
	[self didChangeValueForKey:@"question"];
}

- (void)setOrder:(NSNumber *)order
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(question = %@) AND (order >= %@) AND (SELF != %@)", self.question, order, self];
	NSArray *answers = [self fetchWithPredicate:predicate];
	for (Answer *answer in answers) {
		[answer willChangeValueForKey:@"order"];
		[answer setPrimitiveValue:[NSNumber numberWithInteger:answer.order.integerValue + 1] forKey:@"order"];
		[answer didChangeValueForKey:@"order"];
	}
	
	[self willChangeValueForKey:@"order"];
	[self setPrimitiveValue:order forKey:@"order"];
	[self didChangeValueForKey:@"order"];
}

@end
