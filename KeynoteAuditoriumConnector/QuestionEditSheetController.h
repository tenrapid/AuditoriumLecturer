//
//  QuestionEditSheetController.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 16.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Question;

@interface QuestionEditSheetController : NSViewController <NSControlTextEditingDelegate>

@property (assign) IBOutlet NSTextField *textField;
@property (assign) IBOutlet NSRuleEditor *ruleEditor;

- (id)initWithQuestion:(Question *)question delegate:(id)delegate;

@end
