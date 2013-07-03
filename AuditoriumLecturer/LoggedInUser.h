//
//  LoggedInUser.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 30.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggedInUser : NSObject

@property (copy) NSString *email;
@property (copy) NSString *userName;
@property (copy) NSString *firstName;
@property (copy) NSString *lastName;
@property (copy) NSString *authToken;

@end
