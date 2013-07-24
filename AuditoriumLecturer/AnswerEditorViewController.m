//
//  AnswersEditViewController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 22.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AnswerEditorViewController.h"
#import "AnswerEditorItemViewController.h"
#import "Answer.h"
#import "Question.h"

NSString * const AnswerEditorViewHeightDidChangeNotification = @"AnswerEditorViewHeightDidChangeNotification";


@interface AnswerEditorViewController ()
{
	NSArray *answers;
	NSMutableArray *answerEditorItemViewControllers;
	NSMutableDictionary *correctAnswerRadios;
	IBOutlet NSView *correctAnswerLabel;
}

@property (assign) Question *question;

@end


@implementation AnswerEditorViewController

@synthesize question;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		answerEditorItemViewControllers = [[NSMutableArray alloc] init];
		correctAnswerRadios = [[NSMutableDictionary alloc] init];
		[self addObserver:self forKeyPath:@"question.type" options:0 context:nil];
    }
    
    return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"question.type"];
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	for (NSViewController *viewController in answerEditorItemViewControllers) {
		[notificationCenter removeObserver:self name:AnswerEditorItemViewHeightDidChangeNotification object:[viewController view]];
		[[viewController view] removeFromSuperview];
	}
	[correctAnswerRadios release];
	[answerEditorItemViewControllers release];
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
	for (NSViewController *viewController in answerEditorItemViewControllers) {
		[notificationCenter removeObserver:self name:AnswerEditorItemViewHeightDidChangeNotification object:viewController];
		[viewController commitEditing];
		[[viewController view] removeFromSuperview];
	}
	[answerEditorItemViewControllers removeAllObjects];
	
	[answers release];
	answers = [_answers mutableCopy];

	for (Answer *answer in answers) {
		AnswerEditorItemViewController *viewController = [[AnswerEditorItemViewController alloc] initWithAnswer:answer];
		[answerEditorItemViewControllers addObject:viewController];

		NSView *view = [viewController view];
		[view setFrame:NSMakeRect(0, 0, self.view.frame.size.width, view.frame.size.height)];
		[self.view addSubview:view];
		
		[notificationCenter addObserver:self selector:@selector(answerEditorItemViewHeightDidChange:) name:AnswerEditorItemViewHeightDidChangeNotification object:viewController];
		[viewController release];
	}
	
	if ([answers count]) {
		// set the answers' question and implicitly update the view height
		self.question = [answers[0] question];
		// hide minus button if there is only one answer
		AnswerEditorItemViewController *answerEditorItemViewController = answerEditorItemViewControllers[0];
		[answerEditorItemViewController.minusButton setHidden:[answers count] == 1];
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
			for (AnswerEditorItemViewController *viewController in answerEditorItemViewControllers) {
				Answer *answer = viewController.representedObject;
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
	for (AnswerEditorItemViewController *viewController in answerEditorItemViewControllers) {
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
	[[NSNotificationCenter defaultCenter] postNotificationName:AnswerEditorViewHeightDidChangeNotification object:self];
//	NSLog(@"frame %f, %f, %f, %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

	[self.view setNeedsDisplay:YES];
}

- (void)answerEditorItemViewHeightDidChange:(NSNotification *)notification
{
	[self updateViewHeight];
}

#pragma mark  NSEditor Protocol

- (BOOL)commitEditing
{
	BOOL returnValue = [super commitEditing];
	for (AnswerEditorItemViewController *answerEditViewController in answerEditorItemViewControllers) {
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
	for (AnswerEditorItemViewController *answerEditViewController in answerEditorItemViewControllers) {
		[answerEditViewController discardEditing];
	}
}

@end
