//
//  QuestionListViewController.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 22.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionListViewController.h"

@interface QuestionListViewController ()

@end

@implementation QuestionListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		NSTextView *textView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, 100, 75)];
		[textView setAutoresizingMask:NSViewWidthSizable];
		[textView setTextContainerInset:NSMakeSize(14, 2)];
		[textView setRichText:YES];
		[textView setDrawsBackground:NO];
		[textView setEditable:NO];
		[textView setSelectable:NO];
		self.view = textView;
		[textView bind:@"attributedString" toObject:self withKeyPath:@"representedObject.text" options:nil];
    }
    return self;
}

@end
