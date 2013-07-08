//
//  Auditorium.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuditoriumNetworkManager.h"
#import "ResolveSyncConflictSheetController.h"

@class Slide, AuditoriumNetworkManager, AuditoriumNetworkManagerDelegateProtocol, AuditoriumObject, AuditoriumEvent, Event, LoggedInUser;

@interface Auditorium : NSObject <AuditoriumNetworkManagerDelegateProtocol>

@property (assign) BOOL loggedIn;
@property (assign) BOOL syncing;
@property (retain) LoggedInUser *loggedInUser;
@property (assign) Event *event;

+ (Auditorium *)sharedInstance;
+ (id)objectForEntityName:(NSString *)entityName;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password delegate:(id)delegate;
- (void)cancelLogin;
- (void)logoutWithDelegate:(id)delegate;

- (void)sync;
- (void)cancelSync;
- (void)didResolveSyncConflict:(Event *)event resolve:(ResolveThroughPushOrPull)resolve;

- (void)sendCurrentSlide:(Slide *)slide;

@end
