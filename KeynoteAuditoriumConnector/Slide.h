//
//  Slide.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 05.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Slide : NSObject

@property (assign) NSInteger number;
@property (assign) NSInteger identifier;
@property (retain) NSString *title;
@property (retain) NSString *body;
@property (retain) NSString *notes;

- (id)initWithNumber:(NSInteger)number identifier:(NSInteger)identifier title:(NSString *)title body:(NSString *)body notes:(NSString *)notes;

@end

