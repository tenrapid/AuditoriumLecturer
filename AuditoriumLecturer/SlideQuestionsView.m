//
//  SlideQuestionsView.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 11.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "SlideQuestionsView.h"
#import "SlideQuestionsItemViewController.h"
#import "SlideQuestionsItemView.h"
#import "MoveQuestionToSlideSheetController.h"
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
	MoveQuestionToSlideSheetController *moveQuestionToSlideSheetController;
}

@property (assign) NSMutableArray *slideQuestionsItemViewControllers;

@end

@implementation SlideQuestionsView

@synthesize slideQuestionsItemViewControllers;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		slideQuestionsItemViewControllers = [[NSMutableArray alloc] init];
		[self updateViewHeight];
    }
    return self;
}

- (void)setQuestions:(NSArray *)_questions
{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

	for (NSViewController *viewController in slideQuestionsItemViewControllers) {
		[notificationCenter removeObserver:self name:SlideQuestionsItemViewHeightDidChangeNotification object:[viewController view]];
		[viewController commitEditing];
		[[viewController view] removeFromSuperview];
	}
	[slideQuestionsItemViewControllers removeAllObjects];

	[questions release];
	questions = [_questions mutableCopy];

	for (Question *question in questions) {
		SlideQuestionsItemViewController *viewController = [[SlideQuestionsItemViewController alloc] initWithQuestion:question];
		[slideQuestionsItemViewControllers addObject:viewController];
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
		SlideQuestionsItemView *questionView = (SlideQuestionsItemView *)viewController.view;
		[questionView.textView setTarget:self];
		[questionView.textView setAction:@selector(editQuestionAction:)];
		[questionView.textView setRepresentedObject:question];

		NSView *view = [viewController view];
		[view setFrame:NSMakeRect(0, 0, self.frame.size.width, 100)];
		[self addSubview:view];
	}

	[self updateViewHeight];

	for (SlideQuestionsItemViewController *viewController in slideQuestionsItemViewControllers) {
		[notificationCenter addObserver:self selector:@selector(slideQuestionsItemViewHeightDidChange:) name:SlideQuestionsItemViewHeightDidChangeNotification object:viewController.view];
	}
	
	[[self window] recalculateKeyViewLoop];
}

- (void)updateViewHeight
{
	NSRect frame;
	float height = 0;

	for (SlideQuestionsItemViewController *viewController in slideQuestionsItemViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		frame.size.width = self.frame.size.width;
		[viewController.view setFrame:frame];

		[(SlideQuestionsItemView *)viewController.view updateViewHeight];
		height += viewController.view.frame.size.height + 10;
	}

	frame = [self frame];
	frame.origin.y += frame.size.height - height;
	frame.size.height = height;
	[self setFrame:frame];

	[self setNeedsDisplay:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:SlideQuestionsViewHeightDidChangeNotification object:self];
}

- (void)slideQuestionsItemViewHeightDidChange:(NSNotification *)notification
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
	moveQuestionToSlideSheetController = [[MoveQuestionToSlideSheetController alloc] initWithQuestion:question delegate:self];
}

- (void)moveQuestionToSlideDidEnd:(NSInteger)returnCode
{
	[moveQuestionToSlideSheetController release];
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
