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
		frame.origin.x = 16;
		frame.origin.y = -1;
		textField = [[NSTextField alloc] initWithFrame:frame];
		textField.font = [NSFont boldSystemFontOfSize:12];
		textField.textColor = [NSColor colorWithDeviceWhite:0.2f alpha:1.f];
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
	NSColor *gradientStartColor = [NSColor colorWithCalibratedRed:0.95 green:0.95 blue:0.95 alpha:1.0];
	NSColor *gradientEndColor = [NSColor colorWithCalibratedRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    NSGradient *gradient = [[[NSGradient alloc] initWithColorsAndLocations:gradientStartColor, 0.0, gradientEndColor, 0.9, gradientEndColor, 1.0, nil] autorelease];
    [gradient drawInRect:[self bounds] angle:-90.0];
	
    [[NSColor colorWithDeviceWhite:0.7 alpha:1.0] set];
	[NSBezierPath strokeLineFromPoint:NSMakePoint(0, 0) toPoint:NSMakePoint(self.bounds.size.width, 0)];

    [[NSColor colorWithDeviceWhite:0.8 alpha:1.0] set];
	[NSBezierPath strokeLineFromPoint:NSMakePoint(0, self.bounds.size.height) toPoint:NSMakePoint(self.bounds.size.width, self.bounds.size.height)];
}

@end
