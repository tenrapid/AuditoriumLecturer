//
//  SynchronizeInfoSheetConroller.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 30.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "SyncInfoSheetController.h"
#import "Auditorium.h"

@interface SyncInfoSheetController ()
{
	IBOutlet NSTextField *messageTextField;
	IBOutlet NSProgressIndicator *progress;
}
@end

@implementation SyncInfoSheetController

- (id)init
{
	self = [super initWithNibName:@"SyncInfoSheet" bundle:nil];
	if (self) {
		[self view];
		[progress startAnimation:self];
		[NSApp beginSheet:self.view.window modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
	}
	return self;
}

- (void)dealloc
{
	[NSApp endSheet:self.view.window];
	[super dealloc];
}

- (void)setMessage:(NSString *)message
{
	messageTextField.stringValue = message;
}

- (IBAction)cancelAction:(id)sender
{
	[NSApp endSheet:self.view.window];
	[[Auditorium sharedInstance] cancelSync];
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	[sheet orderOut:self];
}

@end
