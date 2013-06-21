//
//  Answer.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 19.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AuditoriumObject.h"

@class Question;

@interface Answer : AuditoriumObject

@property (nonatomic, assign) Question * question;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * feedback;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * correct;

@end
