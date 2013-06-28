//
//  Question.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 19.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Question.h"
#import "AuditoriumObject.h"
#import "Answer.h"
#import "Slide.h"
#import "Auditorium.h"

const NSString * const QuestionTypeNames[] = {
	@"Nachricht",
	@"Lernaufgabe",
	@"Umfrage"
};

@implementation Question

@dynamic event;
@dynamic order;
@dynamic slideNumber;
@dynamic slideIdentifier;
@dynamic text;
@dynamic type;
@dynamic answers;

- (NSNumber *)slideNumber
{
	return [[Slideshow sharedInstance].slideIdentifierToSlideNumberMap objectForKey:self.slideIdentifier];
}

- (void)setSlideIdentifier:(NSNumber *)slideIdentifier
{
	if (self.slideIdentifier.integerValue != 0) {
		[self removeFromOrderChain];
	}
	self.order = [NSNumber numberWithInteger:[self countWithPredicate:[NSPredicate predicateWithFormat:@"(event = %@) AND (slideIdentifier = %@)", self.event, slideIdentifier]]];

	[self willChangeValueForKey:@"slideIdentifier"];
	[self setPrimitiveValue:slideIdentifier forKey:@"slideIdentifier"];
	[self didChangeValueForKey:@"slideIdentifier"];
}

- (void)setSlide:(Slide *)slide
{
	if (self.slideIdentifier.integerValue != 0) {
		[self removeSlideIdentifierFromSlideshowIfNotUsed];
	}

	self.slideNumber = [NSNumber numberWithInteger:slide.number];
	NSInteger identifier = slide.identifier;
	if (!identifier) {
		identifier = [[Slideshow sharedInstance] addIdentifierToSlideWithNumber:slide.number];
	}
	self.slideIdentifier = [NSNumber numberWithInteger:identifier];
}

- (Slide *)slide
{
	Slide *slide = nil;
	if (self.slideIdentifier.integerValue) {
		slide = [[[Slide alloc] initWithNumber:self.slideNumber.integerValue identifier:self.slideIdentifier.integerValue title:nil body:nil notes:nil] autorelease];
	}
	return slide;
}

- (void)willBeDeleted
{
	if (self.slideIdentifier.integerValue != 0) {
		[self removeFromOrderChain];
		[self removeSlideIdentifierFromSlideshowIfNotUsed];
	}
}

- (void)moveUpInOrderChain
{
	NSInteger order = self.order.integerValue;
	Question *otherQuestion = [self fetchWithPredicate:[NSPredicate predicateWithFormat:@"event = %@ AND slideIdentifier = %@ AND order = %@", self.event, self.slideIdentifier, [NSNumber numberWithInteger:order - 1]]][0];
	self.order = [NSNumber numberWithInteger:order - 1];
	otherQuestion.order = [NSNumber numberWithInteger:order];
}

- (void)moveDownInOrderChain
{
	NSInteger order = self.order.integerValue;
	Question *otherQuestion = [self fetchWithPredicate:[NSPredicate predicateWithFormat:@"event = %@ AND slideIdentifier = %@ AND order = %@", self.event, self.slideIdentifier, [NSNumber numberWithInteger:order + 1]]][0];
	self.order = [NSNumber numberWithInteger:order + 1];
	otherQuestion.order = [NSNumber numberWithInteger:order];
}

- (void)removeFromOrderChain
{
	NSArray *questions = [self fetchWithPredicate:[NSPredicate predicateWithFormat:@"(event = %@) AND (slideIdentifier = %@) AND (order > %@)", self.event, self.slideIdentifier, self.order]];
	for (Question *question in questions) {
		question.order = [NSNumber numberWithInteger:question.order.integerValue - 1];
	}
}

- (void)removeSlideIdentifierFromSlideshowIfNotUsed
{
	NSInteger count = [self countWithPredicate:[NSPredicate predicateWithFormat:@"(event = %@) AND (slideIdentifier = %@) AND (SELF != %@)", self.event, self.slideIdentifier, self]];
	if (count == 0) {
		[[Slideshow sharedInstance] removeIdentifierFromSlide:self.slideIdentifier.integerValue];
	}
}

@end
