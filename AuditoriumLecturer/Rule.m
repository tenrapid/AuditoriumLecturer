//
//  Rule.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 04.07.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Rule.h"
#import "Answer.h"
#import "Question.h"


@implementation Rule

@dynamic question;
@dynamic answer;
@dynamic order;

- (void)setQuestion:(Question *)question
{
	if (question) {
		if (self.order) {
			NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(question = %@) AND (order >= %@)", question, self.order];
			NSArray *rules = [self fetchWithPredicate:predicate];
			for (Rule *rule in rules) {
				[rule willChangeValueForKey:@"order"];
				[rule setPrimitiveValue:[NSNumber numberWithInteger:rule.order.integerValue + 1] forKey:@"order"];
				[rule didChangeValueForKey:@"order"];
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
		NSArray *rules = [self fetchWithPredicate:predicate];
		for (Rule *rule in rules) {
			[rule willChangeValueForKey:@"order"];
			[rule setPrimitiveValue:[NSNumber numberWithInteger:rule.order.integerValue - 1] forKey:@"order"];
			[rule didChangeValueForKey:@"order"];
		}
	}
	
	[self willChangeValueForKey:@"question"];
	[self setPrimitiveValue:question forKey:@"question"];
	[self didChangeValueForKey:@"question"];
}

- (void)setOrder:(NSNumber *)order
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(question = %@) AND (order >= %@) AND (SELF != %@)", self.question, order, self];
	NSArray *rules = [self fetchWithPredicate:predicate];
	for (Rule *rule in rules) {
		[rule willChangeValueForKey:@"order"];
		[rule setPrimitiveValue:[NSNumber numberWithInteger:rule.order.integerValue + 1] forKey:@"order"];
		[rule didChangeValueForKey:@"order"];
	}
	
	[self willChangeValueForKey:@"order"];
	[self setPrimitiveValue:order forKey:@"order"];
	[self didChangeValueForKey:@"order"];
}

@end
