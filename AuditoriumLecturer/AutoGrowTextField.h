//
//  AutoGrowTextField.h
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 19.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const AutoGrowTextFieldHeightDidChangeNotification;

@interface AutoGrowTextField : NSTextField

- (BOOL)sizeFrameHeightToFit;

@end
