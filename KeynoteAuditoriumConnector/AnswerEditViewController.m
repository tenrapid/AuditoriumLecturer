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

@implementation AnswerEditViewController

@synthesize plusButton;
@synthesize minusButton;

- (AnswerEditViewController *)initWithAnswer:(Answer *)answer;
{
    self = [super initWithNibName:@"AnswerEdit" bundle:nil];
    if (self) {
        self.representedObject = answer;
    }
    return self;
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

@end
