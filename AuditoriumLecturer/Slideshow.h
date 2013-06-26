//
//  Slideshow.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 26.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Slide;

@interface Slideshow : NSObject

@property (copy) NSString *document;
@property (retain) Slide *currentSlide;
@property (getter=isPlaying) BOOL playing;
@property (retain) NSMutableDictionary *slideIdentifierToSlideNumberMap;

+ (Slideshow *)sharedInstance;

- (Slide *)slideForSlideNumber:(NSInteger)number;
- (NSInteger)addIdentifierToSlideWithNumber:(NSInteger)number;
- (void)removeIdentifierFromSlide:(NSInteger)identifier;

- (void)gotoSlideWithIdentifier:(NSInteger)indentifier;

@end
