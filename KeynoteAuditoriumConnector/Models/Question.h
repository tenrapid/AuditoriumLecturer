//
//  Question.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 19.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AuditoriumObject.h"

@class Answer, Slide, Event;


enum QuestionType : int16_t {
	QuestionMessageType,
	QuestionSingleChoiceType,
	QuestionMultipleChoiceType

};
typedef enum QuestionType QuestionType;


@interface Question : AuditoriumObject

@property (nonatomic, assign) Event * event;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, assign) Slide * slide;
@property (nonatomic, retain) NSNumber * slideNumber;
@property (nonatomic, retain) NSNumber * slideIdentifier;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, assign) QuestionType type;
@property (nonatomic, retain) NSSet *answers;

+ (NSPredicate *)slideQuestionsPredicate;

@end

@interface Question (CoreDataGeneratedAccessors)

- (void)addAnswersObject:(Answer *)value;
- (void)removeAnswersObject:(Answer *)value;
- (void)addAnswers:(NSSet *)values;
- (void)removeAnswers:(NSSet *)values;

@end
