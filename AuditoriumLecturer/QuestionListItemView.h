//
//  QuestionListView.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 22.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Question;

@interface QuestionListItemView : NSView

@property (retain) Question *question;

@end
