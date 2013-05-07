//
//  LoginController.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 30.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "LoginController.h"
#import "Auditorium.h"

@interface LoginController ()
{
	BOOL reallyAwake;
}
@end

@implementation LoginController

- (id)init
{
	self = [super init];
    if (self) {
		reallyAwake = NO;
		[NSBundle loadNibNamed:@"LoginDialog" owner:self];
    }
    return self;
}

- (void)awakeFromNib
{
	// awakeFromNib is received twice because LoginDialog is instantiated in the main nib file and is also an owner of another nib
	if (!reallyAwake) {
		reallyAwake = YES;
		return;
	}
	
	[notLoggedInBox.superview addSubview:loggedInBox];
	[loggedInBox setFrame:notLoggedInBox.frame];
	[loggedInBox setHidden:YES];

	//credential found in keychain
	if (YES) {
		[notLoggedInBoxSpinner setHidden:NO];
		[notLoggedInBoxSpinner startAnimation:self];
		[notLoggedInBoxLoginButton setEnabled:NO];
		username.stringValue = @"abc";
		password.stringValue = @"abc";
		[auditorium loginWithUsername:@"abc" password:@"" delegate:self];
	}
}

- (void)controlTextDidChange:(NSNotification *)obj
{
	[loginDialogLoginButton setEnabled:(![username.stringValue isEqualToString:@""] && ![password.stringValue isEqualToString:@""])];
}

- (IBAction)loginButtonPressed:(id)sender
{
	[username setEnabled:YES];
	[password setEnabled:YES];
	[username selectText:self];
	[loginDialogErrorMessage setHidden:YES];
	[self controlTextDidChange:nil];
	[NSApp beginSheet:loginDialog modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:@selector(loginDialoDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (IBAction)loginDialogLoginButtonPressed:(id)sender
{
	[username setEnabled:NO];
	[password setEnabled:NO];
	[loginDialogLoginButton setEnabled:NO];
	[loginDialogErrorMessage setHidden:YES];
	[loginDialogSpinner setHidden:NO];
	[loginDialogSpinner startAnimation:self];
	[auditorium loginWithUsername:username.stringValue password:password.stringValue delegate:self];
}

- (IBAction)loginDialogCancelButtonPressed:(id)sender
{
	[NSApp endSheet:loginDialog returnCode:NSCancelButton];
}

- (void)loginDialoDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	[sheet orderOut:self];
}

- (IBAction)logoutButtonPressed:(id)sender
{
	[loggedInBoxSpinner setHidden:NO];
	[loggedInBoxSpinner startAnimation:self];
	[auditorium logoutWithDelegate:self];
}

- (void)didLogin
{
	[loginDialogSpinner setHidden:YES];
	[loginDialogSpinner stopAnimation:self];
	
	[notLoggedInBoxSpinner setHidden:YES];
	[notLoggedInBoxSpinner stopAnimation:self];
	[notLoggedInBox setHidden:YES];
	
	[loggedInBox setHidden:NO];
	loggedInUser.stringValue = auditorium.loggedInUser;
	
	if ([loginDialog isSheet]) {
		[NSApp endSheet:loginDialog returnCode:NSOKButton];
	}
}

- (void)didLogout
{
	[loggedInBoxSpinner setHidden:YES];
	[loggedInBoxSpinner stopAnimation:self];
	[loggedInBox setHidden:YES];

	[notLoggedInBoxSpinner setHidden:YES];
	[notLoggedInBoxSpinner stopAnimation:self];
	[notLoggedInBoxLoginButton setEnabled:YES];
	[notLoggedInBox setHidden:NO];
}

- (void)didFailWithError:(NSString *)error context:(NSString *)context
{
	if ([context isEqualToString:@"login"]) {
		if ([loginDialog isSheet]) {
			[username setEnabled:YES];
			[password setEnabled:YES];
			[loginDialogSpinner setHidden:YES];
			[loginDialogSpinner stopAnimation:self];
			[loginDialogLoginButton setEnabled:YES];
			[loginDialogErrorMessage setHidden:NO];
			loginDialogErrorMessage.stringValue = error;
		}
		else {
			[self didLogout];
		}
		
	}
	else if ([context isEqualToString:@"logout"]) {
		[self didLogout];
	}
}

@end
