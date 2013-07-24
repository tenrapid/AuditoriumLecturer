//
//  ListQuestionsController.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 22.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionListController.h"
#import "QuestionListItemViewController.h"
#import "QuestionListSectionHeaderView.h"
#import "Question.h"
#import "Auditorium.h"
#import "Slideshow.h"

@interface QuestionListController ()

@property (assign) IBOutlet NSView *questionListView;
@property (retain) NSArrayController *questions;
@property (retain) NSMutableArray *questionListItemViewControllers;
@property (retain) NSMutableArray *questionListSectionHeaderViews;

@end

@implementation QuestionListController

@synthesize questionListView;
@synthesize questions;
@synthesize questionListItemViewControllers;

- (void)awakeFromNib
{
	self.questions = [[NSArrayController alloc] init];
	[self.questions setManagedObjectContext:[[NSApp delegate] managedObjectContext]];
	[self.questions setEntityName:@"Question"];
	[self.questions setAutomaticallyRearrangesObjects:YES];
	[self.questions setFetchPredicate:[self questionsFetchPredicate]];
	[self.questions setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"slideNumber" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
	[self.questions fetch:self];

	self.questionListItemViewControllers = [NSMutableArray array];
	self.questionListSectionHeaderViews = [NSMutableArray array];
	
	[self addObserver:self forKeyPath:@"questions.arrangedObjects" options:0 context:nil];
	[[Auditorium sharedInstance] addObserver:self forKeyPath:@"event" options:0 context:nil];
	[[Slideshow sharedInstance] addObserver:self forKeyPath:@"slideIdentifierToSlideNumberMap" options:0 context:nil];
}

- (void)dealloc
{
	[self.questions removeObserver:self forKeyPath:@"arrangedObjects"];
	[[Auditorium sharedInstance] removeObserver:self forKeyPath:@"event"];
	[[Slideshow sharedInstance] removeObserver:self forKeyPath:@"slideIdentifierToSlideNumberMap"];
	self.questions = nil;
	self.questionListItemViewControllers = nil;
	self.questionListSectionHeaderViews = nil;
	[super dealloc];
}

- (NSPredicate *)questionsFetchPredicate
{
	return [NSPredicate predicateWithFormat:@"event = %@", [Auditorium sharedInstance].event];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"questions.arrangedObjects"]) {
		[self performSelector:@selector(update) withObject:nil afterDelay:0];
	}
	if ([keyPath isEqualToString:@"slideIdentifierToSlideNumberMap"]) {
		[self update];
	}
	else if ([keyPath isEqualToString:@"event"]) {
		[self.questions setFetchPredicate:[self questionsFetchPredicate]];
	}
}

- (void)update
{
	for (QuestionListItemViewController *viewController in self.questionListItemViewControllers) {
		[viewController.view removeFromSuperviewWithoutNeedingDisplay];
	}
	[self.questionListItemViewControllers removeAllObjects];
	for (NSView *view in self.questionListSectionHeaderViews) {
		[view removeFromSuperviewWithoutNeedingDisplay];
	}
	[self.questionListSectionHeaderViews removeAllObjects];

	NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"slideNumber" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]];
	NSArray *questionsSorted = [self.questions.arrangedObjects sortedArrayUsingDescriptors:sortDescriptors];
	NSInteger slideNumber = -1;
	CGFloat height = 0;

	for (Question *question in questionsSorted) {
		if (question.slideNumber.integerValue != slideNumber) {
			slideNumber = question.slideNumber.integerValue;
			height -= height ? 1 : 0;
			NSRect frame = NSMakeRect(0, height, questionListView.frame.size.width, 19);
			QuestionListSectionHeaderView *view = [[[QuestionListSectionHeaderView alloc] initWithFrame:frame] autorelease];
			if (slideNumber) {
				view.textField.stringValue = [NSString stringWithFormat:@"Folie %li", (long)slideNumber];
			}
			else {
				view.textField.stringValue = [NSString stringWithFormat:@"nicht zugeordnet"];
			}
			[self.questionListView addSubview:view];
			[self.questionListSectionHeaderViews addObject:view];
			height += frame.size.height;
		}
//		NSLog(@"%@ %@ %@ %@", question.slideIdentifier, question.slideNumber, question.order, question.text);
		QuestionListItemViewController *viewController = [[[QuestionListItemViewController alloc] initWithQuestion:question] autorelease];
		NSRect frame = viewController.view.frame;
		frame.origin.x = 0;
		frame.origin.y = height;
		frame.size.width = questionListView.frame.size.width;
		[viewController.view setFrame:frame];
		[self.questionListView addSubview:viewController.view];
		[self.questionListItemViewControllers addObject:viewController];
		height += frame.size.height;
	}

	NSSize size = self.questionListView.frame.size;
	size.height = height;
	[self.questionListView setFrameSize:size];
}

@end
