//
//  Rule.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 04.07.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AuditoriumObject.h"

@class Answer, Question;

@interface Rule : AuditoriumObject

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) Answer *answer;
@property (nonatomic, retain) NSNumber *order;

@end
