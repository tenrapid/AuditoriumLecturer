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
	NSMutableDictionary *correctAnswerRadios;
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
		correctAnswerRadios = [[NSMutableDictionary alloc] init];
		[self addObserver:self forKeyPath:@"question.type" options:0 context:nil];
    }
    
    return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"question.type"];
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	for (NSViewController *viewController in answerEditViewControllers) {
		[notificationCenter removeObserver:self name:AnswerEditViewHeightDidChangeNotification object:[viewController view]];
		[[viewController view] removeFromSuperview];
	}
	[correctAnswerRadios release];
	[answerEditViewControllers release];
	[answers release];
	[super dealloc];
}

- (void)setAnswers:(NSArray *)_answers
{	
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	
	for (NSButton *radio in [correctAnswerRadios allValues]) {
		[radio removeFromSuperview];
	}
	[correctAnswerRadios removeAllObjects];
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
	for (NSButton *radio in [correctAnswerRadios allValues]) {
		if (radio != sender) {
			[radio.cell setState:0];
		}
	}
	[self updateAnswerCorrectnessFromCellState];
}

- (void)updateAnswerCorrectnessFromCellState
{
	for (NSButton *radio in [correctAnswerRadios allValues]) {
		NSButtonCell *cell = radio.cell;
		Answer *answer = cell.representedObject;
		answer.correct = [NSNumber numberWithBool:cell.state];
	}
}

- (void)updateCellStateFromAnswerCorrectness
{
	for (NSButton *radio in [correctAnswerRadios allValues]) {
		NSButtonCell *cell = radio.cell;
		Answer *answer = cell.representedObject;
		[cell setState:answer.correct.integerValue];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"question.type"]) {
		if (self.question.type == QuestionSingleChoiceType) {
			for (AnswerEditViewController *answerEditViewController in answerEditViewControllers) {
				Answer *answer = answerEditViewController.representedObject;
				NSButton *radio = [[NSButton alloc] init];
				[radio setButtonType:NSRadioButton];
				[radio setTitle:@""];
				[radio setTarget:self];
				[radio setAction:@selector(correctAnswerSelectAction:)];
				[radio.cell setRepresentedObject:answer];
				[radio sizeToFit];
				[self.view addSubview:radio];
				[correctAnswerRadios setObject:radio forKey:answer.uuid];
			}
			if ([answers count] && ![[answers valueForKeyPath:@"@max.correct"] integerValue]) {
				// mark first answers as correct if no answer is marked as correct
				((Answer *)answers[0]).correct = [NSNumber numberWithBool:YES];
			}
			[self updateCellStateFromAnswerCorrectness];
		}
		else {
			for (NSButton *radio in [correctAnswerRadios allValues]) {
				[radio removeFromSuperview];
			}
			[correctAnswerRadios removeAllObjects];
		}

		[correctAnswerLabel setHidden:self.question.type != QuestionSingleChoiceType];

		[self updateViewHeight];
	}
}

- (void)updateViewHeight
{
	NSRect frame;
	// room for "Antworten:" label
	float height = 26;

	float originX = self.question.type == QuestionSingleChoiceType ? 22 : 0;
	for (AnswerEditViewController *viewController in answerEditViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		frame.origin.x = originX;
		frame.size.width = self.view.frame.size.width - originX;
		[viewController.view setFrame:frame];

		if (self.question.type == QuestionSingleChoiceType) {
			Answer *answer = viewController.representedObject;
			NSButton *radio = [correctAnswerRadios objectForKey:answer.uuid];
			NSRect radioFrame = radio.frame;
			radioFrame.origin.y = height + 2;
			[radio setFrame:radioFrame];
		}
		
		[viewController updateViewHeight];
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
			if (answer.correct.boolValue) {
				answer.correct = [NSNumber numberWithBool:NO];
			}
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
