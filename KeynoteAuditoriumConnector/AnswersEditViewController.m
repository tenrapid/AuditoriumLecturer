//
//  AnswersEditViewController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 22.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AnswersEditViewController.h"
#import "AnswerEditViewController.h"
#import "Answer.h"

NSString * const AnswersEditViewHeightDidChangeNotification = @"AnswersEditViewHeightDidChangeNotification";

@interface AnswersEditViewController ()
{
	NSArray *answers;
	NSMutableArray *answerEditViewControllers;
}
@end

@implementation AnswersEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		answerEditViewControllers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	for (NSViewController *viewController in answerEditViewControllers) {
		[notificationCenter removeObserver:self name:NSViewFrameDidChangeNotification object:[viewController view]];
		[[viewController view] removeFromSuperview];
	}
	[answerEditViewControllers release];
	[answers release];
	[super dealloc];
}

- (void)setAnswers:(NSArray *)_answers
{
	[answers release];
	answers = [_answers mutableCopy];
	[self update];
}

- (void)update
{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

	for (NSViewController *viewController in answerEditViewControllers) {
		[notificationCenter removeObserver:self name:NSViewFrameDidChangeNotification object:[viewController view]];
		[viewController commitEditing];
		[[viewController view] removeFromSuperview];
	}
	[answerEditViewControllers removeAllObjects];

	for (Answer *answer in answers) {
		AnswerEditViewController *viewController = [[AnswerEditViewController alloc] initWithAnswer:answer];
		[answerEditViewControllers addObject:viewController];
		[viewController release];

		NSView *view = [viewController view];
		[view setFrame:NSMakeRect(0, 0, self.view.frame.size.width, view.frame.size.height)];
		[self.view addSubview:view];

		[notificationCenter addObserver:self selector:@selector(answerEditViewHeightDidChange:) name:NSViewFrameDidChangeNotification object:view];
	}
	if ([answers count] >= 1) {
		AnswerEditViewController *answerEditViewController = answerEditViewControllers[0];
		[answerEditViewController.minusButton setHidden:[answers count] == 1];
	}

	[self updateViewHeight];
	[[self.view window] recalculateKeyViewLoop];
}

- (void)updateViewHeight
{
	NSRect frame;
	float height = 23;

	for (NSViewController *viewController in answerEditViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		frame.size.width = self.view.frame.size.width;
		[viewController.view setFrame:frame];
		height += viewController.view.frame.size.height + 5;
	}

	frame = [self.view frame];
	frame.origin.y += frame.size.height - height;
	frame.size.height = height;

	[self.view setFrame:frame];
	[[NSNotificationCenter defaultCenter] postNotificationName:AnswersEditViewHeightDidChangeNotification object:self];
//	NSLog(@"frame %f, %f, %f, %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

	[self.view setNeedsDisplay:YES];
}

- (void)answerEditViewHeightDidChange:(NSNotification *)notification
{
}

#pragma mark  NSEditor Protocol

- (BOOL)commitEditing
{
	BOOL returnValue = [super commitEditing];
	for (AnswerEditViewController *answerEditViewController in answerEditViewControllers) {
		returnValue &= [answerEditViewController commitEditing];
	}
	return returnValue;
}

- (void)discardEditing
{
	[super discardEditing];
	for (AnswerEditViewController *answerEditViewController in answerEditViewControllers) {
		[answerEditViewController discardEditing];
	}
}

@end
