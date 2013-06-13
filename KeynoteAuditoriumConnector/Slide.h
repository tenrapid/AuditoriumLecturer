//
//  Slide.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 05.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Slideshow.h"

@interface Slide : NSObject

@property (assign) NSInteger number;
@property (assign) NSInteger identifier;
@property (copy) NSString *title;
@property (copy) NSString *body;
@property (copy) NSString *notes;

- (id)initWithNumber:(NSInteger)number identifier:(NSInteger)identifier title:(NSString *)title body:(NSString *)body notes:(NSString *)notes;

@end

