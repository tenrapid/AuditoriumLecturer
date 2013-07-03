//
//  ResolveSyncConflictSheetController.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 01.07.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class  Event;

typedef enum ResolveThroughPushOrPull {
	ResolveThroughPush = 0,
	ResolveThroughPull = 1
} ResolveThroughPushOrPull;

@interface ResolveSyncConflictSheetController : NSViewController

- (id)initWithEvent:(Event *)event;

@end
