//
//  QuestionListGroupHeaderView.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 25.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionListGroupHeaderView.h"

@implementation QuestionListGroupHeaderView

@synthesize textField;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAutoresizingMask:NSViewWidthSizable];
		frame.origin.x = 12;
		frame.origin.y = 0;
		textField = [[NSTextField alloc] initWithFrame:frame];
		textField.font = [NSFont boldSystemFontOfSize:13];
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
	[[NSColor colorWithDeviceWhite:0.85f alpha:1.f] set];
	NSRectFill([self bounds]);
}

@end
