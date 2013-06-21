//
//  ClickActionTextView.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 21.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "ClickActionTextView.h"

@implementation ClickActionTextView

@synthesize target;
@synthesize action;
@synthesize representedObject;

- (void)mouseDown:(NSEvent *)theEvent
{
	[NSApp sendAction:action to:target from:self];
}

@end
