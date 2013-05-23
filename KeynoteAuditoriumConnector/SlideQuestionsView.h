//
//  EditQuestionsView.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 11.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const QuestionEditSheetWillOpenNotification;
extern NSString * const QuestionEditSheetDidCloseNotification;
extern NSString * const SlideQuestionsViewHeightDidChangeNotification;

@interface SlideQuestionsView : NSView

- (IBAction)addQuestionButtonAction:(id)sender;

@end
