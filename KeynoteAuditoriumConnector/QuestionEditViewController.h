//
//  QuestionEditViewController.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Question;

@interface QuestionEditViewController : NSViewController

@property (assign) IBOutlet NSMenuItem *moveQuestionUpMenuItem;
@property (assign) IBOutlet NSMenuItem *moveQuestionDownMenuItem;
@property (assign) IBOutlet NSMenuItem *moveQuestionToSlideMenuItem;
@property (assign) IBOutlet NSMenuItem *removeQuestionMenuItem;
@property (assign) IBOutlet NSButton *editQuestionButton;

- (id)initWithQuestion:(Question *)question;

@end
