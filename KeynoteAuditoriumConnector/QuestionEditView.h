//
//  QuestionEditView.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const QuestionEditViewHeightDidChangeNotification;

@interface QuestionEditView : NSView <NSTextViewDelegate>

@property (assign) NSTextView *textView;

@end
