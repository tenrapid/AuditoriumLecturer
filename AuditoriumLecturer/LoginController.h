//
//  LoginController.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 30.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Auditorium;

@interface LoginController : NSObject
{
	IBOutlet NSTextField *username;
	IBOutlet NSTextField *password;
	IBOutlet NSWindow *loginDialog;
	IBOutlet NSButton *loginDialogLoginButton;
	IBOutlet NSProgressIndicator *loginDialogSpinner;
	IBOutlet NSTextField *loginDialogErrorMessage;

	IBOutlet NSBox *loggedInBox;
	IBOutlet NSBox *notLoggedInBox;
	IBOutlet NSTextField *loggedInUser;
	IBOutlet NSButton *notLoggedInBoxLoginButton;
	IBOutlet NSProgressIndicator *loggedInBoxSpinner;
	IBOutlet NSProgressIndicator *notLoggedInBoxSpinner;
}

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)logoutButtonPressed:(id)sender;
- (IBAction)loginDialogCancelButtonPressed:(id)sender;
- (IBAction)loginDialogLoginButtonPressed:(id)sender;

- (void)didLogout;

@end
