//
//  Question.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 19.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Question.h"
#import "Answer.h"
#import "Slide.h"
#import "Auditorium.h"

const NSString * const QuestionTypeNames[] = {
	@"Nachricht",
	@"Single Choice",
	@"Multiple Choice"
};

@implementation Question

@dynamic event;
@dynamic order;
@dynamic slideNumber;
@dynamic slideIdentifier;
@dynamic text;
@dynamic type;
@dynamic answers;

- (void)removeFromOrderChain
{
	NSError *error = nil;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:self.entity];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(event = %@) AND (slideNumber = %@) AND (order > %@)", self.event, self.slideNumber, self.order]];
	NSArray *questions = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	for (Question *question in questions) {
		question.order = [NSNumber numberWithInteger:question.order.integerValue - 1];
	}
}

- (void)setSlideNumber:(NSNumber *)slideNumber
{
	if (self.slideNumber.integerValue != 0) {
		[self removeFromOrderChain];
	}

	NSError *error;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:self.entity];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(event = %@) AND (slideNumber = %@)", self.event, slideNumber]];
	NSInteger count = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
	self.order = [NSNumber numberWithInteger:count];

	[self willChangeValueForKey:@"slideNumber"];
	[self setPrimitiveValue:slideNumber forKey:@"slideNumber"];
	[self didChangeValueForKey:@"slideNumber"];

	[fetchRequest release];
}

- (void)setSlide:(Slide *)slide
{
	self.slideNumber = [NSNumber numberWithInteger:slide.number];
	self.slideIdentifier = [NSNumber numberWithInteger:slide.identifier];
}

- (Slide *)slide
{
	Slide *slide = [[[Slide alloc] initWithNumber:self.slideNumber.integerValue identifier:self.slideIdentifier.integerValue title:nil body:nil notes:nil] autorelease];
	return slide;
}

- (void)prepareForDeletion
{
	if (self.slideNumber.integerValue != 0) {
		[self removeFromOrderChain];
	}
}

@end
