//
//  QuestionListViewController.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 22.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Question;

@interface QuestionListItemViewController : NSCollectionViewItem

- (id)initWithQuestion:(Question *)question;

@end
