//
//  AuditoriumNetworkManager.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 24.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AuditoriumNetworkManager.h"
#import "Auditorium.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@implementation AuditoriumNetworkManager

@synthesize delegate;

- (id)init
{
	self = [super init];
    if (self) {
    }
    return self;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *response = [request responseString];
	NSLog(@"%@", [[response objectFromJSONString] objectForKey:@"auth_token"]);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"%@", error);
	NSLog(@"%@", [request.responseData objectFromJSONData]);
	NSLog(@"%@", request.responseStatusMessage);
	NSLog(@"%i", request.responseStatusCode);
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
{
	NSURL *url = [NSURL URLWithString:@"/users/sign_in.json" relativeToURL:[NSURL URLWithString:AUDITORIUM_URL]];
	NSDictionary *data = @{@"user": @{@"email": email, @"password": password}};
	[self jsonRequest:url method:@"POST" data:data finisch:@selector(didLogin:) fail:@selector(didFailLogin:)];
}

- (void)didLogin:(ASIHTTPRequest *)request
{
	NSDictionary *response = [request.responseString objectFromJSONString];
	LoggedInUser *user = [[LoggedInUser new] autorelease];
	user.userName = [response objectForKey:@"username"];
	user.email = [response objectForKey:@"email"];
	user.firstName = [response objectForKey:@"first_name"];
	user.lastName = [response objectForKey:@"last_name"];
	user.authToken = [response objectForKey:@"auth_token"];
	[delegate didLogin:user];
}

- (void)didFailLogin:(ASIHTTPRequest *)request
{
	NSString *error;
	if (request.responseStatusCode == 401) {
		error = @"Benutzername/Passwort falsch";
	}
	else {
		error = request.responseStatusMessage;
	}
	[delegate didFailLogin:error];
}

- (void)logout:(LoggedInUser *)user
{
	NSURL *url = [NSURL URLWithString:@"/users/sign_out.json" relativeToURL:[NSURL URLWithString:AUDITORIUM_URL]];
	url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?auth_token=%@", url.absoluteString, [user.authToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	[self jsonRequest:url method:@"DELETE" data:nil finisch:@selector(didLogout:) fail:@selector(didLogout:)];
}

- (void)didLogout:(ASIHTTPRequest *)request
{
	[delegate didLogout];
}

- (void)jsonRequest:(NSURL *)url method:(NSString *)method data:(NSDictionary *)data finisch:(SEL)finish fail:(SEL)fail
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request setRequestMethod:method];
	[request addRequestHeader:@"Accept" value:@"application/json"];
	[request addRequestHeader:@"Content-type" value:@"application/json"];
	[request setDidFinishSelector:finish];
	[request setDidFailSelector:fail];
	if (data) {
		[request appendPostData:[data JSONData]];
	}
	[request startAsynchronous];

}

@end
