//
//  Auditorium.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Slide, AuditoriumEvent, Event;

@interface Auditorium : NSObject

@property BOOL loggedIn;
@property (retain) NSString *loggedInUser;
@property (getter = isSaveEnabled) BOOL saveEnabled;

@property (assign) Event *event;

+ (Auditorium *)sharedInstance;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password delegate:(id)delegate;
- (void)logoutWithDelegate:(id)delegate;

- (void)sendSlide:(Slide *)slide;

@end
