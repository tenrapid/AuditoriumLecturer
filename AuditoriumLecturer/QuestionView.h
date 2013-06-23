//
//  QuestionEditView.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const QuestionViewHeightDidChangeNotification;

@class ClickActionTextView;

@interface QuestionView : NSView <NSTextViewDelegate>

@property (assign) ClickActionTextView *textView;

- (void)updateViewHeight;

@end
