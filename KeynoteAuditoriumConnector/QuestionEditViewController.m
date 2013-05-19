//
//  QuestionEditViewController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionEditViewController.h"
#import "QuestionEditView.h"
#import "Question.h"

@implementation QuestionEditViewController

@synthesize moveQuestionUpMenuItem;
@synthesize moveQuestionDownMenuItem;
@synthesize moveQuestionToSlideMenuItem;
@synthesize removeQuestionMenuItem;
@synthesize editQuestionButton;

- (id)initWithQuestion:(Question *)question
{
    self = [super initWithNibName:@"QuestionEdit" bundle:nil];
    if (self) {
		self.representedObject = question;

		QuestionEditView *questionEditView = (QuestionEditView *)self.view;
		[questionEditView.textView bind:@"value" toObject:self withKeyPath:@"representedObject.text" options:nil];
    }

    return self;
}

@end
