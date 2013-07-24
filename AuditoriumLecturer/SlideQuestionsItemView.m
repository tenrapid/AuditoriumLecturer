//
//  QuestionEditView.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "SlideQuestionsItemView.h"
#import "ClickActionTextView.h"

NSString * const SlideQuestionsItemViewHeightDidChangeNotification = @"SlideQuestionsItemViewHeightDidChangeNotification";

@interface SlideQuestionsItemView ( )
{
	float textViewHeight;
}
@end

@implementation SlideQuestionsItemView

@synthesize textView;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		textView = [[ClickActionTextView alloc] initWithFrame:NSMakeRect(16, -3, self.frame.size.width - 32, 75)];
		[textView setAutoresizingMask:NSViewWidthSizable];
		[textView setTextContainerInset:NSMakeSize(14, 2)];
		[textView setRichText:YES];
		[textView setDrawsBackground:NO];
		[textView setDelegate:self];
		[textView setEditable:NO];
		[textView setSelectable:NO];
		[self addSubview:textView];
		textViewHeight = textView.frame.size.height;

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

	[NSGraphicsContext saveGraphicsState];

	NSShadow *theShadow = [[[NSShadow alloc] init] autorelease];
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

	[NSGraphicsContext restoreGraphicsState];

	[[NSGraphicsContext currentContext] setShouldAntialias:NO];
    [[NSColor colorWithCalibratedWhite:0.91f alpha:1.f] set];
	[NSBezierPath strokeLineFromPoint:NSMakePoint(32.0, 39.0) toPoint:NSMakePoint(self.frame.size.width - 32.0, 39.0)];
}

- (void)updateViewHeight
{
	NSRect frame;
	float height = -3;

	frame = [textView frame];
	frame.origin.y = height;
	[textView setFrame:frame];
	height += frame.size.height;

	height += 3;

	frame = [self frame];
	frame.size.height = height;
	[self setFrame:frame];

	[self setNeedsDisplay:YES];
}

- (void)textViewHeightDidChange:(NSNotification *)notification
{
	if (self.textView.frame.size.height != textViewHeight) {
		textViewHeight = self.textView.frame.size.height;
		[[NSNotificationCenter defaultCenter] postNotificationName:SlideQuestionsItemViewHeightDidChangeNotification object:self];
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
