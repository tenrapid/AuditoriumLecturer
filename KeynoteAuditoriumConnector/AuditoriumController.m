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


@interface AuditoriumController ()
{
	NSTimer *pulsingTimer;
	NSInteger pulsingState;
}

@property (retain) NSArray *auditoriumEvents;
@property (assign, getter = isSending) BOOL sending;
@property (assign) IBOutlet NSWindow *window;

@end


@implementation AuditoriumController

@synthesize auditoriumEvents;
@synthesize currentAuditoriumEvent;
@synthesize sending;
@synthesize window;

- (void)awakeFromNib
{
	sending = NO;
	[sendToolbarItem setEnabled:NO];
	[eventPopUpButton setEnabled:NO];

	[slideshow addObserver:self forKeyPath:@"currentSlide" options:NSKeyValueObservingOptionNew context:nil];
	[auditorium addObserver:self forKeyPath:@"loggedIn" options:NSKeyValueObservingOptionNew context:nil];
	[self addObserver:self forKeyPath:@"sending" options:NSKeyValueObservingOptionNew context:nil];
	[self addObserver:self forKeyPath:@"currentAuditoriumEvent" options:NSKeyValueObservingOptionNew context:nil];

	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter addObserver:self selector:@selector(windowDidBecomeKey:) name:NSWindowDidBecomeKeyNotification object:[NSApp mainWindow]];
	[notificationCenter addObserver:self selector:@selector(windowDidResignKey:) name:NSWindowDidResignKeyNotification object:[NSApp mainWindow]];
}

- (void)dealloc
{
	[slideshow removeObserver:self forKeyPath:@"currentSlide"];
	[auditorium removeObserver:self forKeyPath:@"loggedIn"];
	[self removeObserver:self forKeyPath:@"sending"];
	[self removeObserver:self forKeyPath:@"currentAuditoriumEvent"];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[auditoriumEvents release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"currentSlide"] && slideshow.document && self.isSending) {
		Slide *currentSlide = [change objectForKey:NSKeyValueChangeNewKey];
		[auditorium sendSlide:currentSlide];
	}
	else if ([keyPath isEqualToString:@"loggedIn"]) {
		BOOL loggedInToAuditorium = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
		self.sending = NO;
		if (loggedInToAuditorium) {
			[auditorium getEventsWithDelegate:self];
		}
		else {
			[sendToolbarItem setEnabled:NO];
			[eventPopUpButton setEnabled:NO];
			[eventPopUpButton removeAllItems];
			self.auditoriumEvents = nil;
			self.currentAuditoriumEvent = nil;
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
	else if ([keyPath isEqualToString:@"currentAuditoriumEvent"]) {
		[sendToolbarItem setEnabled:self.currentAuditoriumEvent != nil];
		if (self.currentAuditoriumEvent == nil) {
			self.sending = NO;
		}
	}
}

- (void)pulseSendToolbarItem:(NSTimer*)myTimer
{
	[sendToolbarItem setImage:[NSImage imageNamed:pulsingState < 2 ? @"TB3_Record-Pressed" : @"TB3_Record-Pressed-Off"]];
	pulsingState = pulsingState < 2 ? pulsingState + 1 : 0;
}

- (void)didGetEvents:(NSArray *)events
{
	self.auditoriumEvents = events;

	[eventPopUpButton addItemWithTitle:@"Veranstaltung wählen…"];
	for (AuditoriumEvent *event in self.auditoriumEvents) {
		[eventPopUpButton addItemWithTitle:event.title];
	}
	[eventPopUpButton selectItemAtIndex:0];
	[eventPopUpButton setEnabled:YES];
}

- (IBAction)sendToolbarItemPressed:(id)sender
{
	self.sending = !self.isSending;
}

- (IBAction)eventPopUpButtonPressed:(id)sender
{
	if ([eventPopUpButton indexOfSelectedItem] > 0) {
		self.currentAuditoriumEvent = [self.auditoriumEvents objectAtIndex:[eventPopUpButton indexOfSelectedItem] - 1];
		[auditorium fetchQuestionsForEvent:self.currentAuditoriumEvent];
	}
	else {
		self.currentAuditoriumEvent = nil;
	}
}

- (void)windowDidBecomeKey:(NSNotification *)notification
{
	[sendToolbarItem setEnabled:auditorium.loggedIn && [eventPopUpButton indexOfSelectedItem] > 0];
}

- (void)windowDidResignKey:(NSNotification *)notification
{
	[sendToolbarItem setEnabled:NO];
}

@end
