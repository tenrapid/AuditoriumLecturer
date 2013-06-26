//
//  Slideshow.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 26.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Slideshow.h"
#import "SlideshowApp.h"
#import "Slide.h"
#import <ScriptingBridge/ScriptingBridge.h>
#import "Keynote.h"
#import "Powerpoint.h"

@interface Slideshow ()
{
	NSTimer *updateSlideIdentifierToSlideNumberMapTimer;
	NSInteger nextSlideIdentifier;
}
@end

@implementation Slideshow

@synthesize document;
@synthesize currentSlide;
@synthesize playing;
@synthesize slideIdentifierToSlideNumberMap;

+ (Slideshow *)sharedInstance
{
	static Slideshow *sharedInstance;
	@synchronized(self)
	{
		if (!sharedInstance) {
			sharedInstance = [[Slideshow alloc] init];
		}
		return sharedInstance;
	}
}

- (id)init
{
	self = [super init];
    if (self) {
		SlideshowApp *app = [SlideshowApp sharedInstance];
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(slideshowAppChangeNotification:) name:SlideshowAppDocumentDidChangeNotification object:app];
		[notificationCenter addObserver:self selector:@selector(slideshowAppChangeNotification:) name:SlideshowAppIsPlayingDidChangeNotification object:app];
		[notificationCenter addObserver:self selector:@selector(slideshowAppChangeNotification:) name:SlideshowAppCurrentSlideDidChangeNotification object:app];
		updateSlideIdentifierToSlideNumberMapTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(updateSlideIdentifierToSlideNumberMap:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)dealloc
{
	[updateSlideIdentifierToSlideNumberMapTimer invalidate];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)slideshowAppChangeNotification:(NSNotification *)notification
{
	if ([notification.name isEqualToString:SlideshowAppDocumentDidChangeNotification]) {
		self.document = [SlideshowApp sharedInstance].document;
		[updateSlideIdentifierToSlideNumberMapTimer fire];
	}
	else if ([notification.name isEqualToString:SlideshowAppIsPlayingDidChangeNotification]) {
		self.playing = [SlideshowApp sharedInstance].isPlaying;
	}
	else if ([notification.name isEqualToString:SlideshowAppCurrentSlideDidChangeNotification]) {
		self.currentSlide = [SlideshowApp sharedInstance].currentSlide;
	}
}

- (void)updateSlideIdentifierToSlideNumberMap:(NSTimer*)timer
{
	self.slideIdentifierToSlideNumberMap = [[SlideshowApp sharedInstance] slideIdentifierToSlideNumberMap];
	nextSlideIdentifier = [[[self.slideIdentifierToSlideNumberMap allKeys] valueForKeyPath:@"@max.self"] integerValue] + 1;
}

- (Slide *)slideForSlideNumber:(NSInteger)number
{
	return [[SlideshowApp sharedInstance] slideForSlideNumber:number];
}

- (NSInteger)addIdentifierToSlideWithNumber:(NSInteger)number
{
	NSInteger identifier = nextSlideIdentifier++;
	[[SlideshowApp sharedInstance] addIdentifier:identifier toSlideWithNumber:number];
	[self.slideIdentifierToSlideNumberMap setObject:[NSNumber numberWithInteger:number] forKey:[NSNumber numberWithInteger:identifier]];
	return identifier;
}

- (void)removeIdentifierFromSlide:(NSInteger)identifier
{
	NSNumber *key = [NSNumber numberWithInteger:identifier];
	NSInteger number = ((NSNumber *)[self.slideIdentifierToSlideNumberMap objectForKey:key]).integerValue;
	if (number) {
		[[SlideshowApp sharedInstance] removeIdentifierFromSlideWithNumber:number];
		[self.slideIdentifierToSlideNumberMap removeObjectForKey:key];
	}
}

- (void)gotoSlideWithIdentifier:(NSInteger)identifier
{
	NSInteger number = [[self.slideIdentifierToSlideNumberMap objectForKey:[NSNumber numberWithInteger:identifier]] integerValue];
	if (number) {
		[[SlideshowApp sharedInstance] gotoSlideWithNumber:number];
	}
}

@end

