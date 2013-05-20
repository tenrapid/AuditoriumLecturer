//
//  QuestionEditSheetController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 16.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionEditSheetController.h"
#import "Question.h"

@interface QuestionEditSheetController ()
{
	NSWindow *sheet;
	id delegate;
}

@property (assign) IBOutlet NSTextField *textField;
@property (assign) IBOutlet NSPopUpButton *type;
@property (assign) IBOutlet NSRuleEditor *ruleEditor;

@end

@implementation QuestionEditSheetController

@synthesize textField;
@synthesize ruleEditor;

- (id)initWithQuestion:(Question *)aQuestion delegate:(id)aDelegate
{
    self = [super initWithNibName:@"QuestionEditSheet" bundle:nil];
    if (self) {
		self.representedObject = aQuestion;
		delegate = aDelegate;
		
		sheet = self.view.window;
		[self calculateViewHeight];
		
		[NSApp beginSheet:sheet modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
	}
    return self;
}

- (void)calculateViewHeight
{
	NSRect frame = sheet.frame;
	frame.size.width = [[NSApp mainWindow] frame].size.width - 15;
	[sheet setFrame:frame display:YES animate:YES];
}

- (IBAction)cancelButtonAction:(id)sender
{
	[self discardEditing];
	[NSApp endSheet:sheet returnCode:NSCancelButton];
}

- (IBAction)saveButtonAction:(id)sender
{
	[self commitEditing];
	[NSApp endSheet:sheet returnCode:NSOKButton];
}

- (void)sheetDidEnd:(NSWindow *)aSheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	[sheet orderOut:self];
	[self invokeDelegateWith:returnCode];
}

- (void)invokeDelegateWith:(NSInteger)returnCode
{
	SEL selector = @selector(editQuestionDidEnd:);
	NSMethodSignature *methodSignature = [delegate methodSignatureForSelector:selector];
	if (methodSignature == nil) {
		return;
	}
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:delegate];
	[invocation setSelector:selector];
	[invocation setArgument:&returnCode atIndex:2];
	[invocation invoke];
}

- (BOOL)control:(NSControl*)control textView:(NSTextField*)textfield doCommandBySelector:(SEL)commandSelector
{
	BOOL result = NO;
	if (commandSelector == @selector(insertNewline:)) {
		[textfield insertNewlineIgnoringFieldEditor:self];
		result = YES;
	}
	return result;
}

@end
