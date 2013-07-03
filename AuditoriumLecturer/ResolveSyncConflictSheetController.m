//
//  ResolveSyncConflictSheetController.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 01.07.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "ResolveSyncConflictSheetController.h"
#import "Auditorium.h"
#import "Event.h"

@interface ResolveSyncConflictSheetController ()
{
	IBOutlet NSTextField *eventTextField;
	IBOutlet NSMatrix *resolveThroughPushOrPullMatrix;
}

@property (assign) Event *event;

@end

@implementation ResolveSyncConflictSheetController

@synthesize event;

- (id)initWithEvent:(Event *)_event
{
    self = [super initWithNibName:@"ResolveSyncConflictSheet" bundle:nil];
    if (self) {
		[self view];
		event = _event;
        eventTextField.stringValue = event.title;
		[NSApp beginSheet:self.view.window modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
    }
    return self;
}

- (void)dealloc
{
	[NSApp endSheet:self.view.window];
	[super dealloc];
}

- (IBAction)okAction:(id)sender
{
	ResolveThroughPushOrPull resolve = resolveThroughPushOrPullMatrix.selectedTag == 0 ? ResolveThroughPush : ResolveThroughPull;
	[NSApp endSheet:self.view.window];
	[[Auditorium sharedInstance] didResolveSyncConflict:self.event resolve:resolve];
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
