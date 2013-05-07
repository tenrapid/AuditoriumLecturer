//
//  AuditoriumEvent.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 05.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuditoriumEvent : NSObject

@property (retain) NSString *identifier;
@property (retain) NSString *title;

- (id)initWithIdentifier:(NSString *)identifier title:(NSString *)title;

@end
