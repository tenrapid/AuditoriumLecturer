//
//  MoveQuestionToSlideViewController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 15.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "MoveQuestionToSlideViewController.h"

@interface MoveQuestionToSlideViewController ()
{
	
}
@end

@implementation MoveQuestionToSlideViewController

@synthesize slideNumber;

- (id)initWithQuestion:(Question *)aQuestion delegate:(id)aDelegate
{
    self = [super initWithNibName:@"MoveQuestionToSlide" bundle:nil];
    if (self) {
		self.representedObject = aQuestion;
		delegate = aDelegate;
		[NSApp beginSheet:self.view.window modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
	}
    return self;
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	[sheet orderOut:self];
	[self invokeDelegateWith:returnCode];
}

- (IBAction)cancelButtonAction:(id)sender
{
	[NSApp endSheet:self.view.window returnCode:NSCancelButton];
}

- (IBAction)saveButtonAction:(id)sender
{
	[NSApp endSheet:self.view.window returnCode:NSOKButton];
}

- (void)invokeDelegateWith:(NSInteger)returnCode
{
	SEL selector = @selector(moveQuestionToSlideDidEnd:);
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

@end