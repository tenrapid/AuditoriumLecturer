//
//  QuestionEditView.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionView.h"
#import "ClickActionTextView.h"

NSString * const QuestionViewHeightDidChangeNotification = @"QuestionViewHeightDidChangeNotification";

@interface QuestionView ( )
{
	float textViewHeight;
}
@end

@implementation QuestionView

@synthesize textView;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		textView = [[ClickActionTextView alloc] initWithFrame:NSMakeRect(16, 3, self.frame.size.width - 32, 75)];
		[textView setAutoresizingMask:NSViewWidthSizable];
		[textView setTextContainerInset:NSMakeSize(14, 2)];
		[textView setRichText:YES];
		[textView setDrawsBackground:NO];
		[textView setDelegate:self];
		[textView setEditable:NO];
		[textView setSelectable:NO];
		[self addSubview:textView];
		textViewHeight = textView.frame.size.height;

		NSBox *box = [[NSBox alloc] initWithFrame:NSMakeRect(32, 38, self.frame.size.width - 64, 1)];
		[box setAutoresizingMask:NSViewWidthSizable];
		[box setBoxType:NSBoxCustom];
		[box setBorderColor:[NSColor colorWithDeviceWhite:0.92f alpha:1.f]];
		[self addSubview:box];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewHeightDidChange:) name:NSViewFrameDidChangeNotification object:textView];
    }
    return self;
} 

- (void)dealloc
{
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter removeObserver:self];

	[textView removeFromSuperviewWithoutNeedingDisplay];
	[textView release];

	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];

	NSShadow *theShadow = [[NSShadow alloc] init];
	[theShadow setShadowOffset:NSMakeSize(0.0, -2.0)];
	[theShadow setShadowBlurRadius:3.0];
	[theShadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:0.2]];
	[theShadow set];

    [[NSColor whiteColor] set];
	NSRect rect = [self bounds];
	rect.origin.x = 16;
	rect.origin.y = 3;
	rect.size.height -= 6;
	rect.size.width -= 32;
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:4.f yRadius:4.f];
	[path fill];

	[theShadow release];
}

- (void)updateViewHeight
{
	NSRect frame;
	float height = 0;

	frame = [textView frame];
	frame.origin.y = height;
	[textView setFrame:frame];
	height += frame.size.height;

	height += 3;

	frame = [self frame];
	frame.origin.y += frame.size.height - height;
	frame.size.height = height;
	[self setFrame:frame];

	[self setNeedsDisplay:YES];
	[[NSNotificationCenter defaultCenter] postNotificationName:QuestionViewHeightDidChangeNotification object:self];
}

- (void)textViewHeightDidChange:(NSNotification *)notification
{
	if (self.textView.frame.size.height != textViewHeight) {
		textViewHeight = self.textView.frame.size.height;
		[self updateViewHeight];
	}
}

#pragma mark  NSTextViewDelegate

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
