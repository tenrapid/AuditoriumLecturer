//
//  ClickActionTextView.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 21.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ClickActionTextView : NSTextView

@property (assign) id target;
@property (assign) SEL action;
@property (assign) id representedObject;

@end
