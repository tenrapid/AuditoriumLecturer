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
#import "AutoGrowTextField.h"

NSString * const AnswerEditViewHeightDidChangeNotification = @"AnswerEditViewHeightDidChangeNotification";

@interface AnswerEditViewController ()

@property (assign) IBOutlet AutoGrowTextField *answerTextField;
@property (assign) IBOutlet AutoGrowTextField *feedbackTextField;

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
		
		NSNotificationCenter *notficationCenter = [NSNotificationCenter defaultCenter];
		[notficationCenter addObserver:self selector:@selector(textFieldHeightDidChange:) name:AutoGrowTextFieldHeightDidChangeNotification object:answerTextField];
		[notficationCenter addObserver:self selector:@selector(textFieldHeightDidChange:) name:AutoGrowTextFieldHeightDidChangeNotification object:feedbackTextField];
    }
    return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

- (void)updateViewHeight
{
	Answer *answer = self.representedObject;
	Question *question = answer.question;
	
	[answerTextField sizeFrameHeightToFit];
	[feedbackTextField sizeFrameHeightToFit];
	
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

- (void)textFieldHeightDidChange:(NSNotification *)notification
{
	[self updateViewHeight];
	[[NSNotificationCenter defaultCenter] postNotificationName:AnswerEditViewHeightDidChangeNotification object:self];
}

@end
