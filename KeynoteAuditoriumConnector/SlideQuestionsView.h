//
//  EditQuestionsView.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 11.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Question, Slide, MoveQuestionToSlideViewController;

@interface SlideQuestionsView : NSView
{
	NSMutableArray *questions;
	MoveQuestionToSlideViewController *moveQuestionToSlideViewController;
}

@property (assign) NSMutableArray *questionEditViewControllers;
@property (assign) Slide *slide;

- (IBAction)addQuestionButtonAction:(id)sender;

@end
