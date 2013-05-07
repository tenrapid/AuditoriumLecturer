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

@property (assign) NSArray *auditoriumEvents;

@end


@implementation AuditoriumController

@synthesize auditoriumEvents;

- (void)awakeFromNib
{
	sending = NO;
	[sendToolbarItem setEnabled:NO];
	[eventPopUpButton setEnabled:NO];

	[slideshow addObserver:self forKeyPath:@"currentSlide" options:0 context:@"slideshow"];
	[auditorium addObserver:self forKeyPath:@"loggedIn" options:0 context:@"auditorium"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([(NSString *)context isEqualToString:@"slideshow"]) {
		if ([keyPath isEqualToString:@"currentSlide"] && slideshow.document && auditorium.loggedIn) {
			[auditorium sendSlide:slideshow.currentSlide];
		}
	}
	else if ([(NSString *)context isEqualToString:@"auditorium"]) {
		if ([keyPath isEqualToString:@"loggedIn"]) {
			[sendToolbarItem setImage:[NSImage imageNamed:@"TB3_Record-Active"]];
			sending = NO;
			if (auditorium.loggedIn) {
				[auditorium getEventsWithDelegate:self];
			}
			else {
				[sendToolbarItem setEnabled:NO];
				[eventPopUpButton setEnabled:NO];
				[eventPopUpButton removeAllItems];
				self.auditoriumEvents = nil;
			}
		}
	}
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
	if (sending) {
		[sendToolbarItem setImage:[NSImage imageNamed:@"TB3_Record-Active"]];
		sending = NO;
	}
	else {
		[sendToolbarItem setImage:[NSImage imageNamed:@"TB3_Record-Pressed"]];
		sending = YES;
	}
}

- (IBAction)eventPopUpButtonPressed:(id)sender
{
	NSLog(@"%ld: %@", (long)[eventPopUpButton indexOfSelectedItem], [eventPopUpButton titleOfSelectedItem]);
	[sendToolbarItem setEnabled:[eventPopUpButton indexOfSelectedItem] > 0];
	if ([eventPopUpButton indexOfSelectedItem] == 0) {
		[sendToolbarItem setImage:[NSImage imageNamed:@"TB3_Record-Active"]];
		sending = NO;
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

@end
