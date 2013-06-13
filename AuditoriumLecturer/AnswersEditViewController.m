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
	if ([answers count]) {
		self.question = [answers[0] question];
	}
	[self update];
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
	if (self.question.type == QuestionMessageType) {
		return;
	}

	if ([correctAnswerMatrix infoForBinding:@"content"]) {
		[correctAnswerMatrix unbind:@"content"];
	}

	NSButtonCell *prototypeCell = [[NSButtonCell alloc] init];
	if (self.question.type == QuestionSingleChoiceType) {
		[correctAnswerMatrix setMode:NSRadioModeMatrix];
		[prototypeCell setButtonType:NSRadioButton];
		[correctAnswerMatrix setPrototype:prototypeCell];
	}
	else if (self.question.type == QuestionMultipleChoiceType) {
		[correctAnswerMatrix setMode:NSHighlightModeMatrix];
		[prototypeCell setButtonType:NSSwitchButton];
		[correctAnswerMatrix setPrototype:prototypeCell];
	}
	[correctAnswerMatrix removeColumn:0];
	[correctAnswerMatrix renewRows:1 columns:1];
	[correctAnswerMatrix bind:@"content" toObject:self withKeyPath:@"answers" options:nil];

	
	if (self.question.type == QuestionSingleChoiceType) {
		if ([answers count] && ![[answers valueForKeyPath:@"@max.correct"] integerValue]) {
			((Answer *)answers[0]).correct = [NSNumber numberWithBool:YES];
		}
		else {
			BOOL yesFound = NO;
			for (Answer *answer in answers) {
				if (!yesFound) {
					yesFound = answer.correct.boolValue;
				}
				else {
					answer.correct = [NSNumber numberWithBool:NO];
				}
			}
		}
	}
	[self updateCellStateFromAnswerCorrectness];
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
	[self updateCellStateFromAnswerCorrectness];

	if ([answers count]) {
		AnswerEditViewController *answerEditViewController = answerEditViewControllers[0];
		[answerEditViewController.minusButton setHidden:[answers count] == 1];
	}

	[self updateViewHeight];
	[[self.view window] recalculateKeyViewLoop];
}

- (void)updateViewHeight
{
	NSRect frame;
	// room for "Antworten:" label
	float height = 26;

	for (NSViewController *viewController in answerEditViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		frame.origin.x = 22;
		frame.size.width = self.view.frame.size.width - 22;
		[viewController.view setFrame:frame];
		height += viewController.view.frame.size.height + 5;
	}

	// room for "korrekte Antwort" label
	height += 18;

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
