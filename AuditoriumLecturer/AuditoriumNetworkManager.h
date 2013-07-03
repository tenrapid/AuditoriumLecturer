//
//  AuditoriumNetworkManager.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 24.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define AUDITORIUM_URL @"http://localhost:3000/"
#else
#define AUDITORIUM_URL @"http://auditorium.inf.tu-dresden.de/"
#endif

@class LoggedInUser, Event;

@protocol AuditoriumNetworkManagerDelegateProtocol <NSObject>

- (void)didLogin:(LoggedInUser *)user;
- (void)didFailLogin:(NSString *)error;
- (void)didLogout;

- (void)didEventsForUser:(NSArray *)events;
- (void)didFailEventsForUser:(NSString *)error;

- (void)didPullQuestionsForEvent:(Event *)event version:(NSInteger)version questions:(NSArray *)questions;
- (void)didPushQuestionsForEvent:(Event *)event;
- (void)didFailPullPushQuestionsForEvent:(Event *)event error:(NSString *)error;

@end

@interface AuditoriumNetworkManager : NSObject

@property (retain) id<AuditoriumNetworkManagerDelegateProtocol> delegate;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password;
- (void)cancelLogin;
- (void)logout:(LoggedInUser *)user;

- (void)eventsForUser:(LoggedInUser *)user;
- (void)cancelEventsForUser;

- (void)pullQuestionsForEvent:(Event *)event user:(LoggedInUser *)user;
- (void)pushQuestionsForEvent:(Event *)event user:(LoggedInUser *)user;
- (void)cancelPullPushQuestionsForEvent:(Event *)event;

@end
