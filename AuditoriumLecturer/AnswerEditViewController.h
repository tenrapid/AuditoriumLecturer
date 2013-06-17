//
//  AnswerEditViewController.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 22.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const AnswerEditViewHeightDidChangeNotification;

@class Answer;

@interface AnswerEditViewController : NSViewController

@property (assign) IBOutlet NSButton *plusButton;
@property (assign) IBOutlet NSButton *minusButton;

- (AnswerEditViewController *)initWithAnswer:(Answer *)answer;
- (IBAction)addAnswerAction:(id)sender;
- (IBAction)removeAnswerAction:(id)sender;

- (void)updateViewHeight;

@end
