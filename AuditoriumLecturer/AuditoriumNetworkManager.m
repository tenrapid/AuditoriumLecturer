//
//  AuditoriumNetworkManager.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 24.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AuditoriumNetworkManager.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@implementation AuditoriumNetworkManager

- (id)init
{
	self = [super init];
    if (self) {
		NSURL *url = [NSURL URLWithString:@"/users/sign_in.json" relativeToURL:[NSURL URLWithString:AUDITORIUM_URL]];
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
		[request setDelegate:self];
		[request addRequestHeader:@"Accept" value:@"application/json"];
		[request addRequestHeader:@"Content-type" value:@"application/json"];
		NSDictionary *data = @{@"user": @{@"email": @"mr8@mail.zih.tu-dresden.de", @"password": @"testing"}};
		[request appendPostData:[data JSONData]];
		[request startAsynchronous];
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
}

@end
