//
//  SlideshowApp.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 11.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "SlideshowApp.h"
#import "Slide.h"
#import <ScriptingBridge/ScriptingBridge.h>
#import "SystemEvents.h"
#import "Keynote.h"
#import "Powerpoint.h"

NSString * const SlideshowAppDocumentDidChangeNotification = @"SlideshowAppDocumentDidChangeNotification";
NSString * const SlideshowAppCurrentSlideDidChangeNotification = @"SlideshowAppCurrentSlideDidChangeNotification";
NSString * const SlideshowAppIsPlayingDidChangeNotification = @"SlideshowAppIsPlayingDidChangeNotification";

NSString * const IdentifierTagStart = @"#AUDITORIUMSLIDEID:";
NSString * const IdentifierTagEnd = @"#";

@interface SlideshowApp ()
{
	NSTimer *updateTimer;
}

@property (assign) KeynoteApplication *keynote;
@property (assign) PowerpointApplication *powerpoint;
@property (retain) KeynoteSlideshow *keynoteSlideshow;
@property (retain) PowerpointPresentation *powerpointPresentation;
@property (retain) PowerpointSlideShowView *powerpointSlideshowView;
@property (copy) NSString *document;
@property (assign, getter = isPlaying) BOOL playing;
@property (retain) Slide *currentSlide;

@end

@implementation SlideshowApp

@synthesize keynote;
@synthesize powerpoint;
@synthesize keynoteSlideshow;
@synthesize powerpointPresentation;
@synthesize powerpointSlideshowView;
@synthesize document;
@synthesize playing;
@synthesize currentSlide;

+ (SlideshowApp *)sharedInstance
{
	static SlideshowApp *sharedInstance;
	@synchronized(self)
	{
		if (!sharedInstance) {
			sharedInstance = [[SlideshowApp alloc] init];
		}
		return sharedInstance;
	}
}

- (id)init
{
	self = [super init];
    if (self) {
		updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)dealloc
{
	[updateTimer invalidate];
	self.keynote = nil;
	self.powerpoint = nil;
	self.keynoteSlideshow = nil;
	self.powerpointPresentation = nil;
	self.powerpointSlideshowView = nil;
	self.document = nil;
	self.currentSlide = nil;
    [super dealloc];
}

- (void)update:(NSTimer *)timer
{
	[self updateAppInstance];
	[self updateCurrentSlide];
}

- (void)updateAppInstance
{
	NSString *_document = nil;
	BOOL _playing;
	
	NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
	NSArray *applications;
	if ([workspace respondsToSelector:@selector(runningApplications)]) {
		applications = [[workspace runningApplications] valueForKeyPath:@"bundleIdentifier"];
	}
	else {
		applications = [[workspace launchedApplications] valueForKeyPath:@"NSApplicationBundleIdentifier"];
	}
	BOOL keynoteRunning = [applications containsObject:@"com.apple.iWork.Keynote"];
	BOOL powerpointRunning = [applications containsObject:@"com.microsoft.Powerpoint"];
	
	if (keynoteRunning) {
		self.keynote = [SBApplication applicationWithBundleIdentifier:@"com.apple.iWork.Keynote"];
		
		if (![self.keynote respondsToSelector:@selector(slideshows)]) {
			self.keynote = nil;
		}
	}
	if (self.keynote) {
		self.keynoteSlideshow = [[self.keynote slideshows] objectAtIndex:0];
		_document = [[self.keynoteSlideshow path] copy];
		if (_document) {
			_playing = [self.keynote playing];
		}
		else {
			self.keynote = nil;
		}
	}
	
	if (powerpointRunning && !self.keynote) {
		self.powerpoint = [SBApplication applicationWithBundleIdentifier:@"com.microsoft.Powerpoint"];
		
		if (![self.powerpoint respondsToSelector:@selector(activePresentation)]) {
			self.powerpoint = nil;
		}
	}
	if (self.powerpoint) {
		self.powerpointPresentation = [self.powerpoint activePresentation];
		NSString *powerpointPresentationPath = self.powerpointPresentation.path;
		if (powerpointPresentationPath) {
			_document = [[NSString stringWithFormat:@"%@/%@", powerpointPresentationPath, powerpointPresentation.name] copy];
			self.powerpointSlideshowView = [[self.powerpointPresentation slideShowWindow] slideshowView];
			_playing = [self.powerpointSlideshowView currentShowPosition] > 0;
		}
		else {
			self.powerpoint = nil;
		}
	}

	if ((_document && ![_document isEqualToString:self.document]) || (!_document && self.document)) {
		self.document = _document;
		[[NSNotificationCenter defaultCenter] postNotificationName:SlideshowAppDocumentDidChangeNotification object:self];
	}
	if (_playing != self.isPlaying) {
		self.playing = _playing;
		[[NSNotificationCenter defaultCenter] postNotificationName:SlideshowAppIsPlayingDidChangeNotification object:self];
	}
}

- (void)updateCurrentSlide
{
	Slide *_currentSlide = nil;
	
	if (self.keynote) {
		KeynoteSlide *slide = [self.keynoteSlideshow currentSlide];
		NSString *notes = [slide notes];
		NSInteger identifier = [self slideIdentifierFromNotes:notes];
		_currentSlide = [[[Slide alloc] initWithNumber:[slide slideNumber] identifier:identifier title:[slide title] body:[slide body] notes:notes] autorelease];
	}
	if (self.powerpoint) {
		PowerpointSlide *slide = nil;
		NSInteger slideNumber = 0;
		NSInteger slideID = 0;
		NSString *slideNotes = nil;
		
		if (self.isPlaying) {
			slideNumber = [self.powerpointSlideshowView currentShowPosition];
			slide = [[self.powerpointPresentation slides] objectAtIndex:slideNumber - 1];
		}
		else {
			// geht nicht wenn slideminiaturen aktiv
			slide = [[(PowerpointDocumentWindow *)[[self.powerpointPresentation documentWindows] objectAtIndex:0] view] slide];
			slideNumber = [slide slideNumber];
		}
		
		if (slideNumber) {
			slideID = [slide slideID];
			slideNotes = [[[[[[slide notesPage] shapes] objectAtIndex:1] textFrame] textRange] content];
			_currentSlide = [[[Slide alloc] initWithNumber:slideNumber identifier:slideID title:nil body:nil notes:slideNotes] autorelease];
		}
	}
	
	if ((_currentSlide.number != self.currentSlide.number || _currentSlide.identifier != self.currentSlide.identifier)) {
		self.currentSlide = _currentSlide;
		[[NSNotificationCenter defaultCenter] postNotificationName:SlideshowAppCurrentSlideDidChangeNotification object:self];
	}
}

- (Slide *)slideForSlideNumber:(NSInteger)number
{
	[self updateAppInstance];

	Slide *slide = nil;
	
	if (self.keynote) {
		SBElementArray *slides = [self.keynoteSlideshow slides];
		if (number > [slides count]) {
			return nil;
		}
		
		KeynoteSlide *s = [slides objectAtIndex:number - 1];
		NSString *notes = [s notes];
		NSInteger identifier = [self slideIdentifierFromNotes:notes];
		slide = [[[Slide alloc] initWithNumber:[s slideNumber] identifier:identifier title:[s title] body:[s body] notes:notes] autorelease];
	}
	if (self.powerpoint) {
		SBElementArray *slides = [self.powerpointPresentation slides];
		if (number > [slides count]) {
			return nil;
		}
		
		PowerpointSlide *s = [slides objectAtIndex:number - 1];
		NSString *slideNotes = [[[[[[s notesPage] shapes] objectAtIndex:1] textFrame] textRange] content];
		slide = [[[Slide alloc] initWithNumber:[s slideNumber] identifier:[s slideID] title:nil body:nil notes:slideNotes] autorelease];
	}
	
	return slide;
}

- (void)addIdentifier:(NSInteger)identifier toSlideWithNumber:(NSInteger)number
{
	[self updateAppInstance];
	if (!self.keynote) {
		return;
	}
	
	SBElementArray *slides = [self.keynoteSlideshow slides];
	if (number > [slides count]) {
		return;
	}
	
	KeynoteSlide *slide = [slides objectAtIndex:number - 1];
	NSString *notes = [slide notes];
	// setting slide.notes to an empty string has no effect – taking back the newline insertion
	if ([notes isEqualToString:@"\n"]) {
		notes = @"";
	}
	if (notes.length && ![[notes substringFromIndex:notes.length - 1] isEqualToString:@"\n"]) {
		notes = [notes stringByAppendingString:@"\n"];
	}
	// keynote will append a newline to the note if the previous note ended with a newline
	slide.notes = [NSString stringWithFormat:@"%@%@%li%@", notes, IdentifierTagStart, identifier, IdentifierTagEnd];
}

- (void)removeIdentifierFromSlideWithNumber:(NSInteger)number
{
	[self updateAppInstance];
	if (!self.keynote) {
		return;
	}
	
	SBElementArray *slides = [self.keynoteSlideshow slides];
	if (number > [slides count]) {
		return;
	}

	KeynoteSlide *slide = [slides objectAtIndex:number - 1];
	NSString *notes = [slide notes];
	NSInteger identifier = [self slideIdentifierFromNotes:notes];
	if (!identifier) {
		return;
	}
	NSString *tag = [NSString stringWithFormat:@"%@%li%@", IdentifierTagStart, identifier, IdentifierTagEnd];
	notes = [notes stringByReplacingOccurrencesOfString:tag withString:@""];
	// remove trailing newlines
	if (notes.length) {
		NSRange range = (notes.length == 1) ? NSMakeRange(notes.length - 1, 1) : NSMakeRange(notes.length - 2, 2);
		notes = [notes stringByReplacingOccurrencesOfString:@"\n" withString:@"" options:NSBackwardsSearch range:range];
	}
	// assigning an empty string to slide.notes has no effect
	if (!notes.length) {
		notes = @"\n";
	}
	slide.notes = notes;
}

- (NSInteger)slideIdentifierFromNotes:(NSString *)notes
{
	NSRange tagStartRange = [notes rangeOfString:IdentifierTagStart];
	if (!tagStartRange.length) {
		return 0;
	}
	NSUInteger afterStartTagLocation = tagStartRange.location + tagStartRange.length;
	NSRange searchRange = NSMakeRange(afterStartTagLocation, notes.length - afterStartTagLocation);
	NSRange tagEndRange = [notes rangeOfString:IdentifierTagEnd options:0 range:searchRange];
	if (!tagEndRange.length) {
		return 0;
	}
	NSRange identifierRange = NSMakeRange(afterStartTagLocation, tagEndRange.location - afterStartTagLocation);
	NSString *identifierString = [notes substringWithRange:identifierRange];
	return [identifierString integerValue];
}

- (NSMutableDictionary *)slideIdentifierToSlideNumberMap
{
	[self updateAppInstance];
	NSMutableDictionary *map = nil;

	if (self.keynote) {
		map = [NSMutableDictionary dictionary];
		SBElementArray *slides = [self.keynoteSlideshow slides];
		NSArray *slidesNotes = [slides valueForKey:@"notes"];
		for (NSInteger number = 1; number <= slides.count; number++) {
			NSString *notes = slidesNotes[number - 1];
			NSInteger identifier = [self slideIdentifierFromNotes:notes];
			if (identifier) {
				[map setObject:[NSNumber numberWithInteger:number] forKey:[NSNumber numberWithInteger:identifier]];
			}
		}
	}
	if (self.powerpoint) {
		map = [NSMutableDictionary dictionary];
		SBElementArray *slides = [self.powerpointPresentation slides];
		NSArray *identifiers = [slides valueForKey:@"slideID"];
		for (NSInteger number = 1; number <= slides.count; number++) {
			NSInteger identifier = ((NSNumber *)identifiers[number - 1]).integerValue;
			[map setObject:[NSNumber numberWithInteger:number] forKey:[NSNumber numberWithInteger:identifier]];
		}
	}
	
	return map;
}

- (void)start
{
	[self updateAppInstance];

	if (self.keynote) {
		if ([self.keynoteSlideshow respondsToSelector:@selector(start)]) {
			[self.keynoteSlideshow start];
		}
	}
	else if (self.powerpoint) {
		if ([self.powerpointPresentation respondsToSelector:@selector(start)]) {
			//			[presentation ];
		}
	}
}

@end
