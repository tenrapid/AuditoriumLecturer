//
//  Answer.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 19.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Answer.h"


@implementation Answer

@dynamic question;
@dynamic text;
@dynamic order;
@dynamic correct;

- (void)setQuestion:(Question *)question
{
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:self.entity];
	if (question) {
		if (self.order.integerValue != 0) {
			[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(question = %@) AND (order >= %@)", question, self.order]];
			NSArray *answers = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
			for (Answer *answer in answers) {
				[answer willChangeValueForKey:@"order"];
				[answer setPrimitiveValue:[NSNumber numberWithInteger:answer.order.integerValue + 1] forKey:@"order"];
				[answer didChangeValueForKey:@"order"];
			}
		}
		else {
			[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(question = %@)", question]];
			NSInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
			[self willChangeValueForKey:@"order"];
			[self setPrimitiveValue:[NSNumber numberWithInteger:count] forKey:@"order"];
			[self didChangeValueForKey:@"order"];
		}
	}
	else {
		[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(question = %@) AND (order > %@)", self.question, self.order]];
		NSArray *answers = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
		for (Answer *answer in answers) {
			[answer willChangeValueForKey:@"order"];
			[answer setPrimitiveValue:[NSNumber numberWithInteger:answer.order.integerValue - 1] forKey:@"order"];
			[answer didChangeValueForKey:@"order"];
		}
	}
	[fetchRequest release];

	[self willChangeValueForKey:@"question"];
	[self setPrimitiveValue:question forKey:@"question"];
	[self didChangeValueForKey:@"question"];
}

- (void)setOrder:(NSNumber *)order
{
	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:self.entity];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(question = %@) AND (order >= %@)", self.question, order]];
	NSArray *answers = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	for (Answer *answer in answers) {
		if (answer == self) {
			continue;
		}
		[answer willChangeValueForKey:@"order"];
		[answer setPrimitiveValue:[NSNumber numberWithInteger:answer.order.integerValue + 1] forKey:@"order"];
		[answer didChangeValueForKey:@"order"];
	}
	[fetchRequest release];
	
	[self willChangeValueForKey:@"order"];
	[self setPrimitiveValue:order forKey:@"order"];
	[self didChangeValueForKey:@"order"];
}

@end
