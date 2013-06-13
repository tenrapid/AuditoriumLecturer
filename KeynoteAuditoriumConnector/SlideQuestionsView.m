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
#import "Slide.h"
#import "Slideshow.h"
#import "Auditorium.h"

NSString * const QuestionEditSheetWillOpenNotification = @"QuestionEditSheetWillOpenNotification";
NSString * const QuestionEditSheetDidCloseNotification = @"QuestionEditSheetDidCloseNotification";
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
	[questions release];
	questions = [_questions mutableCopy];
	[self update];
}

- (void)update
{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

	for (NSViewController *viewController in questionViewControllers) {
		[notificationCenter removeObserver:self name:NSViewFrameDidChangeNotification object:[viewController view]];
		[viewController commitEditing];
		[[viewController view] removeFromSuperview];
	}
	[questionViewControllers removeAllObjects];

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

		NSView *view = [viewController view];
		[view setFrame:NSMakeRect(0, 0, self.frame.size.width, 100)];
		[self addSubview:view];

		[notificationCenter addObserver:self selector:@selector(questionEditViewHeightDidChange:) name:NSViewFrameDidChangeNotification object:view];
	}

	[self updateViewHeight];
	[[self window] recalculateKeyViewLoop];
}

- (void)updateViewHeight
{
	NSRect frame;
	float height = 0;

	for (NSViewController *viewController in questionViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		frame.size.width = self.frame.size.width;
		[viewController.view setFrame:frame];
		height += viewController.view.frame.size.height + 20;
	}

	frame = [self frame];
	frame.origin.y += frame.size.height - height;
	frame.size.height = height;
	[self setFrame:frame];

	[self setNeedsDisplay:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:SlideQuestionsViewHeightDidChangeNotification object:self];
}

- (void)questionEditViewHeightDidChange:(NSNotification *)notification
{
	[self updateViewHeight];
}

- (IBAction)addQuestionAction:(id)sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName:QuestionEditSheetWillOpenNotification object:self];
	questionEditSheetController = [[QuestionEditSheetController alloc] initWithQuestion:nil delegate:self];
}

- (void)moveQuestionUpAction:(id)sender
{
	Question *question = [sender representedObject];
	NSInteger order = question.order.integerValue;
	Question *otherQuestion = questions[order -	1];
	question.order = [NSNumber numberWithInteger:order - 1];
	otherQuestion.order = [NSNumber numberWithInteger:order];
}

- (void)moveQuestionDownAction:(id)sender
{
	Question *question = [sender representedObject];
	NSInteger order = question.order.integerValue;
	Question *otherQuestion = questions[order +	1];
	question.order = [NSNumber numberWithInteger:order + 1];
	otherQuestion.order = [NSNumber numberWithInteger:order];
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

- (void)removeQuestionAction:(id)sender
{
	Question *question = [sender representedObject];
	[question willBeDeleted];
	[question.managedObjectContext deleteObject:question];
}

- (void)editQuestionAction:(id)sender
{
	Question *question = [[sender cell]representedObject];
	[[NSNotificationCenter defaultCenter] postNotificationName:QuestionEditSheetWillOpenNotification object:self];
	questionEditSheetController = [[QuestionEditSheetController alloc] initWithQuestion:question delegate:self];
}

- (void)editQuestionDidEnd:(NSInteger)returnCode
{
	[questionEditSheetController release];
	[[NSNotificationCenter defaultCenter] postNotificationName:QuestionEditSheetDidCloseNotification object:self];
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
