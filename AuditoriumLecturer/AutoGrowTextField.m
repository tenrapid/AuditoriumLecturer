//
//  AutoGrowTextField.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 19.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AutoGrowTextField.h"

NSString * const AutoGrowTextFieldHeightDidChangeNotification = @"AutoGrowTextFieldHeightDidChangeNotification";

@implementation AutoGrowTextField

- (void)setObjectValue:(id < NSCopying >)object
{
	[super setObjectValue:object];
	if ([self sizeFrameHeightToFit]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:AutoGrowTextFieldHeightDidChangeNotification object:self];
	}
}

- (void)setFrame:(NSRect)frameRect
{
	BOOL update = frameRect.size.width != self.frame.size.width && ![self.stringValue isEqualToString:@""];
	if (update) {
		frameRect.size.height = [self neededFrameHeight];
	}
	[super setFrame:frameRect];
}

- (void)textDidChange:(NSNotification *)aNotification
{
	[super textDidChange:aNotification];
	if ([self sizeFrameHeightToFit]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:AutoGrowTextFieldHeightDidChangeNotification object:self];
	}
}

- (CGFloat)neededFrameHeight
{
	NSRect bounds = self.frame;
	bounds.size.height = CGFLOAT_MAX;
	[self stringValue];
	return [self.cell cellSizeForBounds:bounds].height;
}

- (BOOL)sizeFrameHeightToFit
{
	NSRect frame = self.frame;
	CGFloat height = frame.size.height;
	CGFloat newHeight = [self neededFrameHeight];
	
	if (height == newHeight) {
		return NO;
	}
	
	frame.size.height = newHeight;
	[self setFrame:frame];
	return YES;
}

@end
