//
//  Slideshow.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 26.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "Slideshow.h"
#import "Slide.h"
#import <ScriptingBridge/ScriptingBridge.h>
#import "SystemEvents.h"
#import "Keynote.h"
#import "Powerpoint.h"

@implementation Slideshow

@synthesize document;
@synthesize currentSlide;
@synthesize playing;

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
		systemEventsApplication = [[SBApplication applicationWithBundleIdentifier:@"com.apple.SystemEvents"] retain];
		updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update:) userInfo:nil repeats:YES];
		[self update:updateTimer];
    }
    return self;
}

- (void)dealloc
{
	[systemEventsApplication release];
	[updateTimer invalidate];
    [super dealloc];
}

- (void)update:(NSTimer*)myTimer
{
	SBElementArray *processes = [systemEventsApplication applicationProcesses];
	BOOL keynoteRunning = [(SystemEventsApplicationProcess *)[processes objectWithName:@"Keynote"] id];
	BOOL powerpointRunning = [(SystemEventsApplicationProcess *)[processes objectWithName:@"Microsoft PowerPoint"] id];

	NSString *slideshowDocument = nil;
	Slide *slideshowCurrentSlide = nil;
	BOOL slideshowPlaying;
	
	if (keynoteRunning) {
		KeynoteApplication *keynote = [SBApplication applicationWithBundleIdentifier:@"com.apple.iWork.Keynote"];
		
		if (![keynote respondsToSelector:@selector(slideshows)]) {
			return;
		}
		
		KeynoteSlideshow *slideshow = [[keynote slideshows] objectAtIndex:0];
		slideshowDocument = [slideshow path];

		if (slideshowDocument) {
			KeynoteSlide *slide = [slideshow currentSlide];

			slideshowPlaying = [keynote playing];
			slideshowCurrentSlide = [[Slide alloc] initWithNumber:[slide slideNumber] identifier:0 title:[slide title] body:[slide body] notes:[slide notes]];
		}
		else {
			slideshowPlaying = NO;
			slideshowCurrentSlide = nil;
		}
	}
	if (powerpointRunning && !slideshowDocument) {
		PowerpointApplication *powerpoint = [SBApplication applicationWithBundleIdentifier:@"com.microsoft.Powerpoint"];

		if (![powerpoint respondsToSelector:@selector(activePresentation)]) {
			return;
		}
		
		PowerpointPresentation *presentation = [powerpoint activePresentation];
		slideshowDocument = presentation.path ? [NSString stringWithFormat:@"%@/%@", presentation.path, presentation.name] : nil;

		if (slideshowDocument) {
			PowerpointSlideShowView *slideshowView = [[presentation slideShowWindow] slideshowView];
			slideshowPlaying = [slideshowView currentShowPosition] > 0;

			PowerpointSlide *slide = nil;
			NSInteger slideNumber = 0;
			NSInteger slideID = 0;
			NSString *slideNotes = nil;

			if (slideshowPlaying) {
				slideNumber = [slideshowView currentShowPosition];
				slide = [[presentation slides] objectAtIndex:slideNumber - 1];
			}
			else {
				// geht nicht wenn slideminiaturen aktiv
				slide = [[(PowerpointDocumentWindow *)[[presentation documentWindows] objectAtIndex:0] view] slide];
				slideNumber = [slide slideNumber];
			}

			if (slideNumber) {
				slideID = [slide slideID];
				slideNotes = [[[[[[slide notesPage] shapes] objectAtIndex:1] textFrame] textRange] content];
				slideshowCurrentSlide = [[Slide alloc] initWithNumber:slideNumber identifier:slideID title:nil body:nil notes:slideNotes];
			}
			else {
				slideshowCurrentSlide = nil;
			}
		}
		else {
			slideshowCurrentSlide = nil;
			slideshowPlaying = NO;
		}
	}

	if ((![slideshowDocument isEqualToString:self.document] && !(slideshowDocument == nil && self.document == nil))
		|| (slideshowDocument && slideshowCurrentSlide && slideshowCurrentSlide.number != self.currentSlide.number)) {
		self.document = slideshowDocument;
		self.playing = slideshowPlaying;
		self.currentSlide = slideshowCurrentSlide;
	}
	else {
		[slideshowCurrentSlide release];
	}
}

- (void)start
{
	SBElementArray *processes = [systemEventsApplication applicationProcesses];
	BOOL keynoteRunning = [(SystemEventsApplicationProcess *)[processes objectWithName:@"Keynote"] id];
	BOOL powerpointRunning = [(SystemEventsApplicationProcess *)[processes objectWithName:@"Microsoft PowerPoint"] id];

	if (keynoteRunning) {
		KeynoteApplication *keynote = [SBApplication applicationWithBundleIdentifier:@"com.apple.iWork.Keynote"];

		if (![keynote respondsToSelector:@selector(slideshows)]) {
			return;
		}

		KeynoteSlideshow *slideShow = [[keynote slideshows] objectAtIndex:0];
		if ([slideShow respondsToSelector:@selector(start)]) {
			[slideShow start];
		}
	}
	else if (powerpointRunning) {
		PowerpointApplication *powerpoint = [SBApplication applicationWithBundleIdentifier:@"com.microsoft.Powerpoint"];

		if (![powerpoint respondsToSelector:@selector(activePresentation)]) {
			return;
		}

		PowerpointPresentation *presentation = [powerpoint activePresentation];
		if ([presentation respondsToSelector:@selector(start)]) {
//			[presentation ];
		}
	}
}

@end

