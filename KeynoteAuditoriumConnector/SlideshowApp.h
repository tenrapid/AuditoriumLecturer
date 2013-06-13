//
//  SlideshowApp.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 11.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KeynoteApplication, PowerpointApplication, Slide;

extern NSString * const SlideshowAppDocumentDidChangeNotification;
extern NSString * const SlideshowAppCurrentSlideDidChangeNotification;
extern NSString * const SlideshowAppIsPlayingDidChangeNotification;

@interface SlideshowApp : NSObject

@property (assign, readonly) KeynoteApplication *keynote;
@property (assign, readonly) PowerpointApplication *powerpoint;
@property (copy, readonly) NSString *document;
@property (assign, readonly, getter = isPlaying) BOOL playing;
@property (retain, readonly) Slide *currentSlide;

+ (SlideshowApp *)sharedInstance;

- (Slide *)slideForSlideNumber:(NSInteger)number;
- (NSMutableDictionary *)slideIdentifierToSlideNumberMap;
- (void)addIdentifier:(NSInteger)identifier toSlideWithNumber:(NSInteger)number;
- (void)removeIdentifierFromSlideWithNumber:(NSInteger)number;

@end
