//
//  LoginController.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 30.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "LoginController.h"
#import "Auditorium.h"
#import "AuditoriumNetworkManager.h"

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
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOnAppLaunch:) name:NSApplicationDidBecomeActiveNotification object:nil];
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

	[notLoggedInBox.superview addSubview:loggedInBox positioned:NSWindowAbove relativeTo:notLoggedInBox];
	[loggedInBox setFrame:notLoggedInBox.frame];
	[loggedInBox setHidden:YES];
}

- (void)loginOnAppLaunch:(NSNotification *)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidBecomeActiveNotification object:nil];

#ifdef DEBUG
	NSURLCredential *credentials = [NSURLCredential credentialWithUser:@"mr8@mail.de" password:@"testing" persistence:NSURLCredentialPersistenceNone];
#else
	NSURL *url = [NSURL URLWithString:AUDITORIUM_URL];
	NSURLProtectionSpace *protectionSpace = [[[NSURLProtectionSpace alloc] initWithHost:url.host port:url.port.intValue protocol:url.scheme realm:nil authenticationMethod:NSURLAuthenticationMethodDefault] autorelease];
	NSURLCredential *credentials = [[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:protectionSpace];
#endif
	if (credentials) {
		//credential found in keychain
		[notLoggedInBoxSpinner setHidden:NO];
		[notLoggedInBoxSpinner startAnimation:self];
		[notLoggedInBoxLoginButton setEnabled:NO];
		email.stringValue = credentials.user;
		password.stringValue = credentials.password;
		[self loginButtonPressed:nil];
		[self loginDialogLoginButtonPressed:nil];
	}
}

- (void)controlTextDidChange:(NSNotification *)obj
{
	[loginDialogLoginButton setEnabled:(![email.stringValue isEqualToString:@""] && ![password.stringValue isEqualToString:@""])];
}

- (IBAction)loginButtonPressed:(id)sender
{
	[email setEnabled:YES];
	[password setEnabled:YES];
	[email selectText:self];
	[loginDialogErrorMessage setHidden:YES];
	[loginDialogSpinner setHidden:YES];
	[loginDialogSpinner stopAnimation:self];
	[self controlTextDidChange:nil];
	[NSApp beginSheet:loginDialog modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:@selector(loginDialogDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (IBAction)loginDialogLoginButtonPressed:(id)sender
{
	[email setEnabled:NO];
	[password setEnabled:NO];
	[loginDialogLoginButton setEnabled:NO];
	[loginDialogErrorMessage setHidden:YES];
	[loginDialogSpinner setHidden:NO];
	[loginDialogSpinner startAnimation:self];
	[[Auditorium sharedInstance] loginWithEmail:email.stringValue password:password.stringValue delegate:self];
}

- (IBAction)loginDialogCancelButtonPressed:(id)sender
{
	[NSApp endSheet:loginDialog returnCode:NSCancelButton];
	[[Auditorium sharedInstance] cancelLogin];
	[self didLogout];
}

- (void)loginDialogDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	[sheet orderOut:self];
}

- (IBAction)logoutButtonPressed:(id)sender
{
	[loggedInBoxSpinner setHidden:NO];
	[loggedInBoxSpinner startAnimation:self];
	[[Auditorium sharedInstance] logoutWithDelegate:self];
}

- (void)didLogin
{
	[loginDialogSpinner setHidden:YES];
	[loginDialogSpinner stopAnimation:self];
	
	[notLoggedInBoxSpinner setHidden:YES];
	[notLoggedInBoxSpinner stopAnimation:self];
	[notLoggedInBox setHidden:YES];
	
	[loggedInBox setHidden:NO];
	loggedInUser.stringValue = [Auditorium sharedInstance].loggedInUser.userName;
	
	NSURL *url = [NSURL URLWithString:AUDITORIUM_URL];
	NSURLCredential *credentials = [NSURLCredential credentialWithUser:email.stringValue password:password.stringValue persistence:NSURLCredentialPersistencePermanent];
	NSURLProtectionSpace *protectionSpace = [[[NSURLProtectionSpace alloc] initWithHost:url.host port:url.port.intValue protocol:url.scheme realm:nil authenticationMethod:NSURLAuthenticationMethodDefault] autorelease];
	[[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credentials forProtectionSpace:protectionSpace];

	if ([loginDialog isSheet]) {
		[NSApp endSheet:loginDialog returnCode:NSOKButton];
	}
}

- (void)didFailLogin:(NSString *)error
{
	if ([loginDialog isSheet]) {
		[email setEnabled:YES];
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

- (void)didFailLogout:(NSString *)error
{
	[self didLogout];
}

@end
