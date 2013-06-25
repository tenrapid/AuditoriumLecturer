//
//  AuditoriumController.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AuditoriumController.h"
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

@property (assign) Auditorium *auditorium;
@property (retain) NSArrayController *events;
@property (assign, getter = isSending) BOOL sending;

@end


@implementation AuditoriumController

@synthesize auditorium;
@synthesize events;
@synthesize sending;

- (void)awakeFromNib
{
	self.auditorium = [Auditorium sharedInstance];
	self.sending = NO;
	[sendToolbarItem setEnabled:NO];

	[[Slideshow sharedInstance] addObserver:self forKeyPath:@"currentSlide" options:NSKeyValueObservingOptionNew context:nil];
	[self addObserver:self forKeyPath:@"auditorium.loggedIn" options:NSKeyValueObservingOptionNew context:nil];
	[self addObserver:self forKeyPath:@"auditorium.event" options:NSKeyValueObservingOptionNew context:nil];
	[self addObserver:self forKeyPath:@"sending" options:NSKeyValueObservingOptionNew context:nil];
	
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self selector:@selector(windowDidBecomeKey:) name:NSWindowDidBecomeKeyNotification object:[NSApp mainWindow]];
	[notificationCenter addObserver:self selector:@selector(windowDidResignKey:) name:NSWindowDidResignKeyNotification object:[NSApp mainWindow]];

	self.events = [[NSArrayController alloc] init];
	[self.events setManagedObjectContext:[[NSApp delegate] managedObjectContext]];
	[self.events setEntityName:@"Event"];
	[self.events setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
	[self.events fetch:self];
}

- (void)dealloc
{
	[[Slideshow sharedInstance] removeObserver:self forKeyPath:@"currentSlide"];
	[self removeObserver:self forKeyPath:@"auditorium.loggedIn"];
	[self removeObserver:self forKeyPath:@"auditroium.event"];
	[self removeObserver:self forKeyPath:@"sending"];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[events release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"currentSlide"]) {
		if ([Slideshow sharedInstance].document && self.isSending) {
			Slide *currentSlide = [change objectForKey:NSKeyValueChangeNewKey];
			[[Auditorium sharedInstance] sendSlide:currentSlide];
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
	else if ([keyPath isEqualToString:@"auditorium.loggedIn"]) {
		BOOL loggedInToAuditorium = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
		self.sending = NO;
		if (!loggedInToAuditorium) {
			[sendToolbarItem setEnabled:NO];
		}
	}
	else if ([keyPath isEqualToString:@"auditorium.event"]) {
		Event *event = [change objectForKey:NSKeyValueChangeNewKey];
		[sendToolbarItem setEnabled:self.auditorium.loggedIn && ![event isEqual:[NSNull null]]];
		if ([event isEqual:[NSNull null]]) {
			self.sending = NO;
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
	[sendToolbarItem setEnabled:self.auditorium.loggedIn && self.auditorium.event];
}

- (void)windowDidResignKey:(NSNotification *)notification
{
	[sendToolbarItem setEnabled:NO];
}

@end
