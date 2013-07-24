//
//  QuestionEditView.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const SlideQuestionsItemViewHeightDidChangeNotification;

@class ClickActionTextView;

@interface SlideQuestionsItemView : NSView <NSTextViewDelegate>

@property (assign) ClickActionTextView *textView;

- (void)updateViewHeight;

@end
