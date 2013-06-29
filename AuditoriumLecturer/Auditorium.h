//
//  Auditorium.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuditoriumNetworkManager.h"

@class Slide, AuditoriumNetworkManager, AuditoriumNetworkManagerDelegateProtocol, AuditoriumObject, AuditoriumEvent, Event;


@interface LoggedInUser : NSObject

@property (copy) NSString *email;
@property (copy) NSString *userName;
@property (copy) NSString *firstName;
@property (copy) NSString *lastName;
@property (copy) NSString *authToken;

@end


@interface Auditorium : NSObject <AuditoriumNetworkManagerDelegateProtocol>

@property (assign) BOOL loggedIn;
@property (assign) BOOL synchronizing;
@property (retain) LoggedInUser *loggedInUser;
@property (assign) Event *event;

+ (Auditorium *)sharedInstance;
+ (id)objectForEntityName:(NSString *)entityName;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password delegate:(id)delegate;
- (void)cancelLogin;
- (void)logoutWithDelegate:(id)delegate;

- (void)synchronize;

- (void)sendSlide:(Slide *)slide;

@end
