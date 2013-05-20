//
//  SlideQuestionsView.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 11.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "SlideQuestionsView.h"
#import "QuestionEditViewController.h"
#import "QuestionEditView.h"
#import "MoveQuestionToSlideViewController.h"
#import "QuestionEditSheetController.h"
#import "Question.h"
#import "Slide.h"
#import "Slideshow.h"
#import "Auditorium.h"

NSString * const QuestionEditSheetWillOpenNotification = @"QuestionEditSheetWillOpenNotification";
NSString * const QuestionEditSheetDidCloseNotification = @"QuestionEditSheetDidCloseNotification";

@interface SlideQuestionsView ()
{
	QuestionEditSheetController *questionEditSheetController;
}
@end

@implementation SlideQuestionsView

@synthesize questionEditViewControllers;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		questionEditViewControllers = [[NSMutableArray alloc] init];
		[self calculateViewHeight];
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

	for (NSViewController *viewController in questionEditViewControllers) {
		[notificationCenter removeObserver:self name:NSViewFrameDidChangeNotification object:[viewController view]];
		[viewController commitEditing];
		[[viewController view] removeFromSuperview];
	}
	[questionEditViewControllers removeAllObjects];

	for (Question *question in questions) {
		QuestionEditViewController *viewController = [[QuestionEditViewController alloc] initWithQuestion:question];
		[questionEditViewControllers addObject:viewController];
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

		[notificationCenter addObserver:self selector:@selector(textViewHeightDidChange:) name:NSViewFrameDidChangeNotification object:view];
	}

	[self calculateViewHeight];
	[[self window] recalculateKeyViewLoop];
}

- (IBAction)addQuestionButtonAction:(id)sender
{
	NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
	NSUndoManager *undoManager = context.undoManager;
	[undoManager beginUndoGrouping];

	[[NSNotificationCenter defaultCenter] postNotificationName:QuestionEditSheetWillOpenNotification object:self];

	Question *question = [Auditorium objectForEntityName:@"Question"];
	question.event = [Auditorium sharedInstance].event;
	questionEditSheetController = [[QuestionEditSheetController alloc] initWithQuestion:question delegate:self];
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
	Question *question = moveQuestionToSlideViewController.representedObject;
	if (returnCode == NSOKButton && moveQuestionToSlideViewController.slide.number != question.slideNumber.integerValue) {
		question.slide = moveQuestionToSlideViewController.slide;
	}
	[moveQuestionToSlideViewController release];
}

- (void)removeQuestionAction:(id)sender
{
	Question *question = [sender representedObject];
	NSInteger order = question.order.integerValue;
	[[[self infoForBinding:@"questions"] valueForKey:NSObservedObjectKey] removeObject:question];
	for (NSInteger i = order; i < questions.count; i++) {
		[[questions objectAtIndex:i] setOrder:[NSNumber numberWithInteger:i]];
	}
}

- (void)editQuestionAction:(id)sender
{
	Question *question = [[sender cell ]representedObject];

	NSUndoManager *undoManager = question.managedObjectContext.undoManager;
	[undoManager beginUndoGrouping];

	[[NSNotificationCenter defaultCenter] postNotificationName:QuestionEditSheetWillOpenNotification object:self];
	questionEditSheetController = [[QuestionEditSheetController alloc] initWithQuestion:question delegate:self];
}

- (void)editQuestionDidEnd:(NSInteger)returnCode
{
	Question *question = question = questionEditSheetController.representedObject;
	NSManagedObjectContext *context = question.managedObjectContext;
	NSUndoManager *undoManager = context.undoManager;

	switch (returnCode) {
		case NSOKButton:
			if (!question.slideNumber.integerValue) {
				question.slide = [Slideshow sharedInstance].currentSlide;
			}
			[undoManager endUndoGrouping];
			break;
		case NSCancelButton:
			[undoManager endUndoGrouping];
			[undoManager undo];
			// clear redo stack by registering fake undo operation
			[undoManager registerUndoWithTarget:[NSNull null] selector:nil object:nil];
			[undoManager performSelector:@selector(removeAllActionsWithTarget:) withObject:[NSNull null] afterDelay:0.0];
			break;
	}

	[questionEditSheetController release];
	[[NSNotificationCenter defaultCenter] postNotificationName:QuestionEditSheetDidCloseNotification object:self];
}

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

- (void)calculateViewHeight
{
	NSRect frame;
	float height = 0;

	for (NSViewController *viewController in questionEditViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		frame.size.width = self.frame.size.width;
		[viewController.view setFrame:frame];
		height += viewController.view.frame.size.height + 30;
	}
	
	frame = [self frame];
	frame.origin.y += frame.size.height - height;
	frame.size.height = height;
	[self setFrame:frame];

	[self setNeedsDisplay:YES];
}

- (void)textViewHeightDidChange:(NSNotification *)notification
{
	[self calculateViewHeight];
}

- (BOOL)isFlipped
{
	return YES;
}

@end
