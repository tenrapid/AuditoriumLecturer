//
//  QuestionEditSheetController.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 16.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Question;

@interface QuestionEditSheetController : NSViewController <NSControlTextEditingDelegate>

- (id)initWithQuestion:(Question *)question delegate:(id)delegate;

@end
