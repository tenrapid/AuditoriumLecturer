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

@interface AuditoriumNetworkManager ()

@property (retain) ASIHTTPRequest *loginRequest;

@end

@implementation AuditoriumNetworkManager

@synthesize delegate;
@synthesize loginRequest;

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

#pragma mark Login/Logout

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
{
	NSURL *url = [NSURL URLWithString:@"/users/sign_in.json" relativeToURL:[NSURL URLWithString:AUDITORIUM_URL]];
	NSDictionary *data = @{@"user": @{@"email": email, @"password": password}};
	self.loginRequest = [self jsonRequest:url method:@"POST" data:data finisch:@selector(didLogin:) fail:@selector(didFailLogin:)];
}

- (void)cancelLogin
{
	[self.loginRequest clearDelegatesAndCancel];
	self.loginRequest = nil;
}

- (void)didLogin:(ASIHTTPRequest *)request
{
	self.loginRequest = nil;

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
	self.loginRequest = nil;

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

#pragma mark Events

- (void)eventsForUser:(LoggedInUser *)user
{
	NSURL *url = [NSURL URLWithString:@"/users/events.json" relativeToURL:[NSURL URLWithString:AUDITORIUM_URL]];
	url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?auth_token=%@", url.absoluteString, [user.authToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	[self jsonRequest:url method:@"GET" data:nil finisch:@selector(didEventsForUser:) fail:@selector(requestFailed:)];
}

- (void)didEventsForUser:(ASIHTTPRequest *)request
{
	NSArray *response = [request.responseString objectFromJSONString];
	NSMutableArray *events = [NSMutableArray array];

	NSDateFormatter *dateParser = [[[NSDateFormatter alloc] init] autorelease];
	[dateParser setDateFormat:@"yyyy-MM-dd"];

	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];

	for (NSDictionary *e in response) {
		NSMutableDictionary *event = [NSMutableDictionary dictionary];
		NSDate *date = [dateParser dateFromString:[e objectForKey:@"beginDate"]];
		NSString *dateString = [dateFormatter stringFromDate:date];
		NSString *courseName = [(NSDictionary *)[e objectForKey:@"course"] objectForKey:@"name"];
		NSString *title = [NSString stringWithFormat:@"%@ – %@", courseName, dateString];
		[event setValue:[e objectForKey:@"id"] forKey:@"auditoriumId"];
		[event setValue:title forKey:@"title"];
		[event setValue:date forKey:@"date"];
		[events addObject:event];
	}
	[delegate didEventsForUser:events];
}

- (ASIHTTPRequest *)jsonRequest:(NSURL *)url method:(NSString *)method data:(NSDictionary *)data finisch:(SEL)finish fail:(SEL)fail
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

	return request;
}

@end
