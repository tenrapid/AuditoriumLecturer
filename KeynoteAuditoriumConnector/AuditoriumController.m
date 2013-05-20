//
//  AuditoriumController.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AuditoriumController.h"
#import "AuditoriumEvent.h"
#import "Auditorium.h"
#import "Slideshow.h"
#import "Event.h"


@interface AuditoriumController ()
{
	IBOutlet NSToolbarItem *sendToolbarItem;
	IBOutlet NSPopUpButton *eventPopUpButton;
	NSTimer *pulsingTimer;
	NSInteger pulsingState;
}

@property (retain) NSArrayController *events;
@property (assign, getter = isSending) BOOL sending;

@end


@implementation AuditoriumController

@synthesize events;
@synthesize sending;

- (void)awakeFromNib
{
	sending = NO;
	[sendToolbarItem setEnabled:NO];
	[eventPopUpButton setEnabled:NO];

	[[Slideshow sharedInstance] addObserver:self forKeyPath:@"currentSlide" options:NSKeyValueObservingOptionNew context:nil];
	[[Auditorium sharedInstance] addObserver:self forKeyPath:@"loggedIn" options:NSKeyValueObservingOptionNew context:nil];
	[[Auditorium sharedInstance] addObserver:self forKeyPath:@"event" options:NSKeyValueObservingOptionNew context:nil];

	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self selector:@selector(windowDidBecomeKey:) name:NSWindowDidBecomeKeyNotification object:[NSApp mainWindow]];
	[notificationCenter addObserver:self selector:@selector(windowDidResignKey:) name:NSWindowDidResignKeyNotification object:[NSApp mainWindow]];

	[self addObserver:self forKeyPath:@"sending" options:NSKeyValueObservingOptionNew context:nil];
	[self addObserver:self forKeyPath:@"events.selectionIndex" options:NSKeyValueObservingOptionNew context:nil];

	self.events = [[NSArrayController alloc] init];
	[self.events setManagedObjectContext:[[NSApp delegate] managedObjectContext]];
	[self.events setEntityName:@"Event"];
	[self.events setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
	[self.events fetch:self];
}

- (void)dealloc
{
	[[Slideshow sharedInstance] removeObserver:self forKeyPath:@"currentSlide"];
	[[Auditorium sharedInstance] removeObserver:self forKeyPath:@"loggedIn"];
	[[Auditorium sharedInstance] removeObserver:self forKeyPath:@"event"];
	[self removeObserver:self forKeyPath:@"sending"];
	[self removeObserver:self forKeyPath:@"events.selectionIndex"];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[events release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"currentSlide"] && [Slideshow sharedInstance].document && self.isSending) {
		Slide *currentSlide = [change objectForKey:NSKeyValueChangeNewKey];
		[[Auditorium sharedInstance] sendSlide:currentSlide];
	}
	else if ([keyPath isEqualToString:@"loggedIn"]) {
		BOOL loggedInToAuditorium = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
		self.sending = NO;
		if (!loggedInToAuditorium) {
			[sendToolbarItem setEnabled:NO];
			[eventPopUpButton setEnabled:NO];
		}
	}
	else if ([keyPath isEqualToString:@"sending"]) {
		BOOL isSendingSlides = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
		if (isSendingSlides) {
			[sendToolbarItem setImage:[NSImage imageNamed:@"TB3_Record-Pressed"]];
			pulsingState = 1;
			pulsingTimer = [NSTimer scheduledTimerWithTimeInterval:0.75 target:self selector:@selector(pulseSendToolbarItem:) userInfo:nil repeats:YES];
		}
		else {
			[sendToolbarItem setImage:[NSImage imageNamed:@"TB3_Record-Active"]];
			[pulsingTimer invalidate];
			pulsingTimer = nil;
		}
	}
	else if ([keyPath isEqualToString:@"event"]) {
		Event *event = [change objectForKey:NSKeyValueChangeNewKey];
		[sendToolbarItem setEnabled:![event isEqual:[NSNull null]]];
		if ([event isEqual:[NSNull null]]) {
			self.sending = NO;
		}
	}
	else if ([keyPath isEqualToString:@"events.selectionIndex"]) {
		NSInteger selectionIndex = self.events.selectionIndex;
		if (selectionIndex == NSNotFound) {
			[eventPopUpButton performSelector:@selector(setEnabled:) withObject:nil afterDelay:0.0];
		}
		else {
			[eventPopUpButton performSelector:@selector(setEnabled:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.0];
			[Auditorium sharedInstance].event = selectionIndex != 0 ? self.events.selectedObjects[0] : nil;
		}
	}
}

- (void)pulseSendToolbarItem:(NSTimer*)timer
{
	[sendToolbarItem setImage:[NSImage imageNamed:pulsingState < 2 ? @"TB3_Record-Pressed" : @"TB3_Record-Pressed-Off"]];
	pulsingState = pulsingState < 2 ? pulsingState + 1 : 0;
}

- (IBAction)sendToolbarItemPressed:(id)sender
{
	self.sending = !self.isSending;
}

- (void)windowDidBecomeKey:(NSNotification *)notification
{
	[sendToolbarItem setEnabled:[Auditorium sharedInstance].loggedIn && self.events.selectionIndex != NSNotFound && self.events.selectionIndex != 0];
}

- (void)windowDidResignKey:(NSNotification *)notification
{
	[sendToolbarItem setEnabled:NO];
}

@end
