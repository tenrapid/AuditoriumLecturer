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
#import "Question.h"

NSString * const AnswersEditViewHeightDidChangeNotification = @"AnswersEditViewHeightDidChangeNotification";


@interface AnswersEditViewController ()
{
	NSArray *answers;
	NSMutableArray *answerEditViewControllers;
	IBOutlet NSMatrix *correctAnswerMatrix;
	IBOutlet NSView *correctAnswerLabel;
}

@property (assign) Question *question;

@end


@implementation AnswersEditViewController

@synthesize question;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		answerEditViewControllers = [[NSMutableArray alloc] init];
		[self addObserver:self forKeyPath:@"question.type" options:0 context:nil];
    }
    
    return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"question.type"];
	[correctAnswerMatrix unbind:@"content"];
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	for (NSViewController *viewController in answerEditViewControllers) {
		[notificationCenter removeObserver:self name:AnswerEditViewHeightDidChangeNotification object:[viewController view]];
		[[viewController view] removeFromSuperview];
	}
	[answerEditViewControllers release];
	[answers release];
	[super dealloc];
}

- (void)setAnswers:(NSArray *)_answers
{	
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	
	for (NSViewController *viewController in answerEditViewControllers) {
		[notificationCenter removeObserver:self name:AnswerEditViewHeightDidChangeNotification object:viewController];
		[viewController commitEditing];
		[[viewController view] removeFromSuperview];
	}
	[answerEditViewControllers removeAllObjects];
	
	[answers release];
	answers = [_answers mutableCopy];

	for (Answer *answer in answers) {
		AnswerEditViewController *viewController = [[AnswerEditViewController alloc] initWithAnswer:answer];
		[answerEditViewControllers addObject:viewController];

		NSView *view = [viewController view];
		[view setFrame:NSMakeRect(0, 0, self.view.frame.size.width, view.frame.size.height)];
		[self.view addSubview:view];
		
		[notificationCenter addObserver:self selector:@selector(answerEditViewHeightDidChange:) name:AnswerEditViewHeightDidChangeNotification object:viewController];
		[viewController release];
	}
	
	if ([answers count]) {
		// set the answers' question and implicitly update the view height
		self.question = [answers[0] question];
		// hide minus button if there is only one answer
		AnswerEditViewController *answerEditViewController = answerEditViewControllers[0];
		[answerEditViewController.minusButton setHidden:[answers count] == 1];
	}

	[[self.view window] recalculateKeyViewLoop];
}

- (IBAction)correctAnswerSelectAction:(id)sender
{
	[self performSelector:@selector(updateAnswerCorrectnessFromCellState) withObject:self afterDelay:0];
}

- (void)updateAnswerCorrectnessFromCellState
{
	for (NSButtonCell *cell in [correctAnswerMatrix cells]) {
		Answer *answer = cell.representedObject;
		answer.correct = [NSNumber numberWithBool:cell.state];
	}
}

- (void)updateCellStateFromAnswerCorrectness
{
	for (NSButtonCell *cell in [correctAnswerMatrix cells]) {
		Answer *answer = cell.representedObject;
		[cell setState:answer.correct.integerValue];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"question.type"]) {
		// We have some binding problems here. NSMatrix probably needs to be bound to
		// a NSArrayController?
		if ([correctAnswerMatrix infoForBinding:@"content"]) {
			[correctAnswerMatrix unbind:@"content"];
		}
		[correctAnswerMatrix removeColumn:0];
		[correctAnswerMatrix renewRows:1 columns:1];
		[correctAnswerMatrix bind:@"content" toObject:self withKeyPath:@"answers" options:nil];

		if (self.question.type == QuestionSingleChoiceType) {
			if ([answers count] && ![[answers valueForKeyPath:@"@max.correct"] integerValue]) {
				// mark first answers as correct if no answer is marked as correct
				((Answer *)answers[0]).correct = [NSNumber numberWithBool:YES];
			}
			[self updateCellStateFromAnswerCorrectness];
		}

		[correctAnswerLabel setHidden:self.question.type != QuestionSingleChoiceType];
		[correctAnswerMatrix setHidden:self.question.type != QuestionSingleChoiceType];

		for (AnswerEditViewController *viewController in answerEditViewControllers) {
			[viewController updateViewHeight];
		}
		[self updateViewHeight];
	}
}

- (void)updateViewHeight
{
	NSRect frame;
	// room for "Antworten:" label
	float height = 26;

	if (self.question.type == QuestionSingleChoiceType && answerEditViewControllers.count) {
		NSSize cellSize = [correctAnswerMatrix cellSize];
		NSRect frame = [correctAnswerMatrix frame];
		cellSize.height = ((AnswerEditViewController *)answerEditViewControllers[0]).view.frame.size.height + 5;
		frame.origin.y = floor(-(cellSize.height / 2) + 38);
		frame.size.height = answerEditViewControllers.count * cellSize.height;
		[correctAnswerMatrix setFrame:frame];
		[correctAnswerMatrix setCellSize:cellSize];
	}

	float correctAnswerMatrixWidth = self.question.type == QuestionSingleChoiceType ? 22 : 0;
	for (NSViewController *viewController in answerEditViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		frame.origin.x = correctAnswerMatrixWidth;
		frame.size.width = self.view.frame.size.width - correctAnswerMatrixWidth;
		[viewController.view setFrame:frame];
		height += viewController.view.frame.size.height + 5;
	}

	// room for "korrekte Antwort" label
	height += self.question.type == QuestionSingleChoiceType ? 18 : 0;

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
	[self updateViewHeight];
}

#pragma mark  NSEditor Protocol

- (BOOL)commitEditing
{
	BOOL returnValue = [super commitEditing];
	for (AnswerEditViewController *answerEditViewController in answerEditViewControllers) {
		returnValue &= [answerEditViewController commitEditing];
	}
	if (self.question.type == QuestionMultipleChoiceType) {
		for (Answer *answer in answers) {
			answer.correct = [NSNumber numberWithBool:NO];
		}
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
