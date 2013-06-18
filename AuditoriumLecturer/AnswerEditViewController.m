//
//  AnswerEditViewController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 22.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AnswerEditViewController.h"
#import "Question.h"
#import "Answer.h"
#import "Auditorium.h"

NSString * const AnswerEditViewHeightDidChangeNotification = @"AnswerEditViewHeightDidChangeNotification";

@interface AnswerEditViewController ()

@property (assign) IBOutlet NSTextField *answerTextField;
@property (assign) IBOutlet NSTextField *feedbackTextField;

@end

@implementation AnswerEditViewController

@synthesize plusButton;
@synthesize minusButton;
@synthesize answerTextField;
@synthesize feedbackTextField;

- (AnswerEditViewController *)initWithAnswer:(Answer *)answer;
{
    self = [super initWithNibName:@"AnswerEdit" bundle:nil];
    if (self) {
        self.representedObject = answer;
		[self view];
		
		NSRect frame, bounds;
		float height;
		
		frame = [answerTextField frame];
		bounds = frame;
		bounds.size.height = CGFLOAT_MAX;
		height = [answerTextField.cell cellSizeForBounds: bounds].height;
		frame.size.height = height;
		[answerTextField setFrame:frame];
		
		frame = [feedbackTextField frame];
		bounds = frame;
		bounds.size.height = CGFLOAT_MAX;
		height = [feedbackTextField.cell cellSizeForBounds: bounds].height;
		frame.size.height = height;
		[feedbackTextField setFrame:frame];

		[self updateViewHeight];
    }
    return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)updateViewHeight
{
	Answer *answer = self.representedObject;
	Question *question = answer.question;
	
	float height = 0;

	if (question.type == QuestionSingleChoiceType) {
		if ([feedbackTextField isHidden]) {
			[feedbackTextField setHidden:NO];
		}
		NSRect feedbackFrame = feedbackTextField.frame;
		height += feedbackFrame.size.height + 5;
		feedbackFrame.origin.y = 0;
		[feedbackTextField setFrame:feedbackFrame];
	}
	else {
		if (![feedbackTextField isHidden]) {
			[feedbackTextField setHidden:YES];
		}
	}
	NSRect answerFrame = answerTextField.frame;
	answerFrame.origin.y = height;
	[answerTextField setFrame:answerFrame];
	height += answerFrame.size.height;
	
	NSRect frame = [self.view frame];
	frame.size.height = height;
	[self.view setFrame:frame];
}

- (IBAction)addAnswerAction:(id)sender
{
	Answer *answer = self.representedObject;
	Answer *newAnswer = [Auditorium objectForEntityName:@"Answer"];
	newAnswer.order = [NSNumber numberWithInteger:answer.order.integerValue + 1];
	[answer.question addAnswersObject:newAnswer];
}

- (IBAction)removeAnswerAction:(id)sender
{
	Answer *answer = self.representedObject;
	[answer.question removeAnswersObject:answer];
	[answer.managedObjectContext deleteObject:answer];
}

- (void)controlTextDidChange:(NSNotification *)notification
{
	NSTextField *textField = notification.object;
	NSTextView *textView = [notification.userInfo objectForKey:@"NSFieldEditor"];
	NSRect textFieldFrame = textField.frame;
	NSRect textViewFrame = [textView.textContainer.layoutManager usedRectForTextContainer:textView.textContainer];
	textFieldFrame.size.height = textViewFrame.size.height + 5;
	[textField setFrame:textFieldFrame];
	[self updateViewHeight];
	[[NSNotificationCenter defaultCenter] postNotificationName:AnswerEditViewHeightDidChangeNotification object:self];
}

@end
