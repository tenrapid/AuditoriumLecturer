//
//  QuestionListViewController.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 22.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionListItemViewController.h"

@interface QuestionListItemViewController ()

@end

@implementation QuestionListItemViewController

@synthesize textField;

- (id)initWithQuestion:(Question *)question;
{
    self = [super initWithNibName:@"QuestionListItem" bundle:nil];
    if (self) {
		self.representedObject = question;
		[self.view bind:@"question" toObject:self withKeyPath:@"representedObject" options:nil];
    }
    return self;
}

@end
