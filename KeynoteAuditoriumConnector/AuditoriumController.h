//
//  AuditoriumController.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Auditorium, AuditoriumEvent, Slideshow;

@interface AuditoriumController : NSObject
{
	IBOutlet Auditorium *auditorium;
	IBOutlet Slideshow *slideshow;

	IBOutlet NSToolbarItem *sendToolbarItem;
	IBOutlet NSPopUpButton *eventPopUpButton;
}

@property (assign) AuditoriumEvent *currentAuditoriumEvent;

- (IBAction)sendToolbarItemPressed:(id)sender;
- (IBAction)eventPopUpButtonPressed:(id)sender;

@end
