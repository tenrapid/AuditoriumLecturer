//
//  SlideQuestionsView.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 11.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "SlideQuestionsView.h"
#import "QuestionViewController.h"
#import "QuestionView.h"
#import "MoveQuestionToSlideViewController.h"
#import "QuestionEditSheetController.h"
#import "Question.h"
#import "Event.h"
#import "Slide.h"
#import "Slideshow.h"
#import "Auditorium.h"
#import "ClickActionTextView.h"

NSString * const SlideQuestionsViewHeightDidChangeNotification = @"SlideQuestionsViewHeightDidChangeNotification";

@interface SlideQuestionsView ()
{
	NSMutableArray *questions;
	QuestionEditSheetController *questionEditSheetController;
	MoveQuestionToSlideViewController *moveQuestionToSlideViewController;
}

@property (assign) NSMutableArray *questionViewControllers;

@end

@implementation SlideQuestionsView

@synthesize questionViewControllers;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		questionViewControllers = [[NSMutableArray alloc] init];
		[self updateViewHeight];
    }
    return self;
}

- (void)setQuestions:(NSArray *)_questions
{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

	for (NSViewController *viewController in questionViewControllers) {
		[notificationCenter removeObserver:self name:QuestionViewHeightDidChangeNotification object:[viewController view]];
		[viewController commitEditing];
		[[viewController view] removeFromSuperview];
	}
	[questionViewControllers removeAllObjects];

	[questions release];
	questions = [_questions mutableCopy];

	for (Question *question in questions) {
		QuestionViewController *viewController = [[QuestionViewController alloc] initWithQuestion:question];
		[questionViewControllers addObject:viewController];
		[viewController release];

		[viewController.moveQuestionUpMenuItem setTarget:self];
		[viewController.moveQuestionUpMenuItem setAction:@selector(moveQuestionUpAction:)];
		[viewController.moveQuestionUpMenuItem setRepresentedObject:question];
		[viewController.moveQuestionDownMenuItem setTarget:self];
		[viewController.moveQuestionDownMenuItem setAction:@selector(moveQuestionDownAction:)];
		[viewController.moveQuestionDownMenuItem setRepresentedObject:question];
		[viewController.moveQuestionToSlideMenuItem setTarget:self];
		[viewController.moveQuestionToSlideMenuItem setAction:@selector(moveQuestionToSlideAction:)];
		[viewController.moveQuestionToSlideMenuItem setRepresentedObject:question];
		[viewController.removeQuestionMenuItem setTarget:self];
		[viewController.removeQuestionMenuItem setAction:@selector(removeQuestionAction:)];
		[viewController.removeQuestionMenuItem setRepresentedObject:question];
		[viewController.editQuestionButton setTarget:self];
		[viewController.editQuestionButton setAction:@selector(editQuestionAction:)];
		[[viewController.editQuestionButton cell] setRepresentedObject:question];
		QuestionView *questionView = (QuestionView *)viewController.view;
		[questionView.textView setTarget:self];
		[questionView.textView setAction:@selector(editQuestionAction:)];
		[questionView.textView setRepresentedObject:question];

		NSView *view = [viewController view];
		[view setFrame:NSMakeRect(0, 0, self.frame.size.width, 100)];
		[self addSubview:view];
	}

	[self updateViewHeight];

	for (QuestionViewController *questionViewController in questionViewControllers) {
		[notificationCenter addObserver:self selector:@selector(questionViewHeightDidChange:) name:QuestionViewHeightDidChangeNotification object:questionViewController.view];
	}
	
	[[self window] recalculateKeyViewLoop];
}

- (void)updateViewHeight
{
	NSRect frame;
	float height = 0;

	for (QuestionViewController *viewController in questionViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		frame.size.width = self.frame.size.width;
		[viewController.view setFrame:frame];

		[(QuestionView *)viewController.view updateViewHeight];
		height += viewController.view.frame.size.height + 10;
	}

	frame = [self frame];
	frame.origin.y += frame.size.height - height;
	frame.size.height = height;
	[self setFrame:frame];

	[self setNeedsDisplay:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:SlideQuestionsViewHeightDidChangeNotification object:self];
}

- (void)questionViewHeightDidChange:(NSNotification *)notification
{
	[self updateViewHeight];
}

- (IBAction)addQuestionAction:(id)sender
{
	questionEditSheetController = [[QuestionEditSheetController alloc] initWithQuestion:nil delegate:self];
}

- (void)editQuestionAction:(id)sender
{
	Question *question = [sender representedObject];
	questionEditSheetController = [[QuestionEditSheetController alloc] initWithQuestion:question delegate:self];
}

- (void)editQuestionDidEnd:(NSInteger)returnCode
{
	[questionEditSheetController release];
}

- (void)removeQuestionAction:(id)sender
{
	NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
	[undoManager beginUndoGrouping];

	Question *question = [sender representedObject];
	[question.event recordModification];
	[question willBeDeleted];
	[question.managedObjectContext deleteObject:question];

	[undoManager endUndoGrouping];
}

- (void)moveQuestionUpAction:(id)sender
{
	NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
	[undoManager beginUndoGrouping];

	Question *question = [sender representedObject];
	[question moveUpInOrderChain];
	[question.event recordModification];

	[undoManager endUndoGrouping];
}

- (void)moveQuestionDownAction:(id)sender
{
	NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
	[undoManager beginUndoGrouping];

	Question *question = [sender representedObject];
	[question moveDownInOrderChain];
	[question.event recordModification];

	[undoManager endUndoGrouping];
}

- (void)moveQuestionToSlideAction:(id)sender
{
	Question *question = [sender representedObject];
	moveQuestionToSlideViewController = [[MoveQuestionToSlideViewController alloc] initWithQuestion:question delegate:self];
}

- (void)moveQuestionToSlideDidEnd:(NSInteger)returnCode
{
	[moveQuestionToSlideViewController release];
}

#pragma mark  NSMenuValidation Protocol

- (BOOL)validateMenuItem:(NSMenuItem *)item {
	Question *question = [item representedObject];
    if ([item action] == @selector(moveQuestionUpAction:) && (question.order.integerValue == 0)) {
        return NO;
    }
    else if ([item action] == @selector(moveQuestionDownAction:) && (question.order.integerValue == questions.count - 1)) {
        return NO;
    }
    return YES;
}

- (BOOL)isFlipped
{
	return YES;
}

@end
