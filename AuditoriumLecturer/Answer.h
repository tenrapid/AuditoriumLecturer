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

@class Question, Rule;

@interface Answer : AuditoriumObject

@property (nonatomic, assign) Question * question;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * feedback;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * correct;
@property (nonatomic, retain) NSSet *rules;

@end

@interface Answer (CoreDataGeneratedAccessors)

- (void)addRulesObject:(Rule *)value;
- (void)removeRulesObject:(Rule *)value;
- (void)addRules:(NSSet *)values;
- (void)removeRules:(NSSet *)values;

@end
