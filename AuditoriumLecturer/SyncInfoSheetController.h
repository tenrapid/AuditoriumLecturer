//
//  SynchronizeInfoSheetConroller.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 30.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SyncInfoSheetController : NSViewController

- (id)init;
- (void)setMessage:(NSString *)message;

- (IBAction)cancelAction:(id)sender;

@end
