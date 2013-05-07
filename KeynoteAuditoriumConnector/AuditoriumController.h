//
//  AuditoriumController.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 27.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Auditorium;
@class Slideshow;

@interface AuditoriumController : NSObject <NSWindowDelegate>
{
	IBOutlet Auditorium *auditorium;
	IBOutlet Slideshow *slideshow;

	IBOutlet NSToolbarItem *sendToolbarItem;
	IBOutlet NSPopUpButton *eventPopUpButton;

	BOOL sending;
}

- (IBAction)sendToolbarItemPressed:(id)sender;
- (IBAction)eventPopUpButtonPressed:(id)sender;

@end
