//
//  Slideshow.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 26.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SystemEventsApplication;
@class Slide;

@interface Slideshow : NSObject
{
	NSTimer *updateTimer;
	SystemEventsApplication *systemEventsApplication;
}

@property (retain) NSString *document;
@property (retain) Slide *currentSlide;
@property (getter=isPlaying) BOOL playing;

- (void)update:(NSTimer*)myTimer;

@end
