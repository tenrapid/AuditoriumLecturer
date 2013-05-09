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
@synthesize sending;
@synthesize window;

- (void)awakeFromNib
{
	if (self.window != nil) {
		[window setLevel:NSFloatingWindowLevel];
		return;
	}

	sending = NO;
	[sendToolbarItem setEnabled:NO];
	[eventPopUpButton setEnabled:NO];

	[slideshow addObserver:self forKeyPath:@"currentSlide" options:NSKeyValueObservingOptionNew context:nil];
	[auditorium addObserver:self forKeyPath:@"loggedIn" options:NSKeyValueObservingOptionNew context:nil];
	[self addObserver:self forKeyPath:@"sending" options:NSKeyValueObservingOptionNew context:nil];
	
	[NSBundle loadNibNamed:@"EditPresentation" owner:self];
}

- (void)dealloc
{
	[slideshow removeObserver:self forKeyPath:@"currentSlide"];
	[auditorium removeObserver:self forKeyPath:@"loggedIn"];
	[self removeObserver:self forKeyPath:@"sending"];
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
	[sendToolbarItem setEnabled:[eventPopUpButton indexOfSelectedItem] > 0];
	if ([eventPopUpButton indexOfSelectedItem] == 0) {
		self.sending = NO;
	}
}

#pragma mark <NSWindowDelegate>

- (void)windowDidBecomeKey:(NSNotification *)notification
{
	[sendToolbarItem setEnabled:auditorium.loggedIn && [eventPopUpButton indexOfSelectedItem] > 0];
}

- (void)windowDidResignKey:(NSNotification *)notification
{
	[sendToolbarItem setEnabled:NO];
}

- (void)windowDidResignMain:(NSNotification *)notification
{
//	[window setLevel:NSFloatingWindowLevel];
}

- (void)windowDidBecomeMain:(NSNotification *)notification
{
//	[window setLevel:NSNormalWindowLevel];
}

@end
