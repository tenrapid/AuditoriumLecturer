//
//  SMBar.h
//  InspectorTabBar
//
//  Created by Stephan Michels on 12.02.12.
//  Copyright (c) 2012 Stephan Michels Softwareentwicklung und Beratung. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SMBar : NSView
{
	NSGradient *keyGradient;
	NSColor *keyBorderColor;
	NSColor *keyLighterBorderColor;
	NSGradient *nonKeyGradient;
	NSColor *nonKeyBorderColor;
	NSColor *nonKeyLighterBorderColor;
}
@end
