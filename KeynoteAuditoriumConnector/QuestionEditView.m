//
//  QuestionEditView.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionEditView.h"

@implementation QuestionEditView

@synthesize textView;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		textView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, self.frame.size.width, 75)];
		[textView setAutoresizingMask:NSViewWidthSizable];
		[textView setTextContainerInset:NSMakeSize(12, 16)];
		[textView setRichText:NO];
		[textView setDrawsBackground:YES];
		[textView setDelegate:self];
//		[textView setFont:[NSFont systemFontOfSize:12]];
		[self addSubview:textView];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewHeightDidChange:) name:NSViewFrameDidChangeNotification object:textView];
    }
    return self;
} 

- (void)dealloc
{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter removeObserver:self];

	[textView removeFromSuperviewWithoutNeedingDisplay];

	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	return;

    [[NSColor whiteColor] set];
	NSRect bounds = [self bounds];
	bounds.size.height -= 26;
    NSRectFill(bounds);
}

- (void)calculateViewHeight
{
	NSRect frame;
	float height = 0;

	frame = [textView frame];
	frame.origin.y = height;
	[textView setFrame:frame];
	height += frame.size.height;

	height += 26;

	frame = [self frame];
	frame.origin.y += frame.size.height - height;
	frame.size.height = height;
	[self setFrame:frame];

	[self setNeedsDisplay:YES];
}


- (void)textViewHeightDidChange:(NSNotification *)notification
{
	[self calculateViewHeight];
}

- (BOOL)textView:(NSTextView *)aTextView doCommandBySelector:(SEL)aSelector {
    if (aSelector == @selector(insertTab:)) {
        [[aTextView window] selectNextKeyView:aTextView];
        return YES;
    }
	else if (aSelector == @selector(insertBacktab:)) {
        [[aTextView window] selectPreviousKeyView:nil];
        return YES;
	}
    return NO;
}

- (BOOL)isFlipped
{
	return YES;
}

@end
