//
//  RuleEditorViewItemController.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 04.07.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Rule;

@interface RuleEditorItemViewController : NSViewController

@property (assign) IBOutlet NSButton *plusButton;
@property (assign) IBOutlet NSButton *minusButton;

- (RuleEditorItemViewController *)initWithRule:(Rule *)rule questions:(NSArray *)questions;
- (IBAction)addRuleAction:(id)sender;
- (IBAction)removeRuleAction:(id)sender;

@end
