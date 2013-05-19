//
//  MoveQuestionToSlideViewController.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 15.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Question;

@interface MoveQuestionToSlideViewController : NSViewController
{
	id delegate;
}

@property (assign) NSInteger slideNumber;

- (id)initWithQuestion:(Question *)question delegate:(id)delegate;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;

@end
