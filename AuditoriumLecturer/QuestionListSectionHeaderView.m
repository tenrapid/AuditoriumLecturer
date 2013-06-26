//
//  QuestionListGroupHeaderView.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 25.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionListSectionHeaderView.h"

@implementation QuestionListSectionHeaderView

@synthesize textField;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAutoresizingMask:NSViewWidthSizable];
		frame.origin.x = 12;
		frame.origin.y = -1;
		textField = [[NSTextField alloc] initWithFrame:frame];
		textField.font = [NSFont boldSystemFontOfSize:12];
		textField.textColor = [NSColor colorWithDeviceWhite:0.3f alpha:1.f];
		[textField setEditable:NO];
		[textField setSelectable:NO];
		[textField setDrawsBackground:NO];
		[textField setBordered:NO];
		[self addSubview:textField];
	}
    return self;
}

- (void)dealloc
{
	[self.textField removeFromSuperviewWithoutNeedingDisplay];
	self.textField = nil;
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSColor *gradientEndColor = [NSColor colorWithCalibratedRed:0.946 green:0.946 blue:0.946 alpha:1.0];
	NSColor *gradientStartColor = [NSColor colorWithCalibratedRed:0.821 green:0.821 blue:0.821 alpha:1.0];
    NSGradient *gradient = [[[NSGradient alloc] initWithStartingColor:gradientStartColor endingColor:gradientEndColor] autorelease];
    [gradient drawInRect:[self bounds] angle:-90.0];
	
    [[NSColor colorWithDeviceWhite:0.8 alpha:1.0] set];
	[NSBezierPath strokeLineFromPoint:NSMakePoint(0, 0) toPoint:NSMakePoint(self.bounds.size.width, 0)];
}

@end
