//
//  AuditoriumNetworkManager.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 24.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AuditoriumNetworkManager.h"
#import "Auditorium.h"
#import "LoggedInUser.h"
#import "Event.h"
#import "Question.h"
#import "Answer.h"
#import "Rule.h"
#import "Slide.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@interface NSNull (IntegerValue);

- (NSInteger)integerValue;

@end

@implementation NSNull (IntegerValue)

- (NSInteger)integerValue
{
	return 0;
}

@end

@interface AuditoriumNetworkManager ()

@property (retain) NSOperationQueue *queue;
@property (retain) ASIHTTPRequest *loginRequest;
@property (retain) ASIHTTPRequest *eventsForUserRequest;
@property (assign) NSMutableDictionary *questionsPullPushRequests;

@end

@implementation AuditoriumNetworkManager

@synthesize delegate;
@synthesize queue;
@synthesize loginRequest;
@synthesize eventsForUserRequest;
@synthesize questionsPullPushRequests;

- (id)init
{
	self = [super init];
    if (self) {
		queue = [[NSOperationQueue alloc] init];
		questionsPullPushRequests = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark Login/Logout

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
{
	NSURL *url = [self auditoriumUrlWithString:@"/users/sign_in.json" user:nil];
	NSDictionary *data = @{@"user": @{@"email": email, @"password": password}};
	self.loginRequest = [self jsonRequest:url
								method:@"POST"
								data:data
								finisch:@selector(didLogin:)
								fail:@selector(didFailLogin:)
								userInfo:nil];
	[self.queue addOperation:self.loginRequest];
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
		error = request.error.localizedDescription;
	}
	[delegate didFailLogin:[NSString stringWithFormat:@"%@", error]];
}

- (void)logout:(LoggedInUser *)user
{
	NSURL *url = [self auditoriumUrlWithString:@"/users/sign_out.json" user:user];
	ASIHTTPRequest *request = [self jsonRequest:url
									method:@"DELETE"
									data:nil
									finisch:@selector(didLogout:)
									fail:@selector(didLogout:)
									userInfo:nil];
	[self.queue addOperation:request];
}

- (void)didLogout:(ASIHTTPRequest *)request
{
	[delegate didLogout];
}

#pragma mark Events

- (void)eventsForUser:(LoggedInUser *)user
{
	NSURL *url = [self auditoriumUrlWithString:@"/users/events.json" user:user];
	self.eventsForUserRequest = [self jsonRequest:url
										method:@"GET"
										data:nil
										finisch:@selector(didEventsForUser:)
										fail:@selector(didFailEventsForUser:)
										userInfo:nil];
	[self.queue addOperation:self.eventsForUserRequest];
}

- (void)didEventsForUser:(ASIHTTPRequest *)request
{
	if (request.responseStatusCode != 200) {
		[self didFailEventsForUser:request];
		return;
	}
	self.eventsForUserRequest = nil;

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
		[event setValue:[e objectForKey:@"version"] forKey:@"version"];
		[event setValue:[e objectForKey:@"modified"] forKey:@"modified"];
		[events addObject:event];
	}
	[delegate didEventsForUser:events];
}

- (void)didFailEventsForUser:(ASIHTTPRequest *)request
{
	self.eventsForUserRequest = nil;
	NSString *error = request.error ? request.error.localizedDescription : request.responseStatusMessage;
	[delegate didFailEventsForUser:error];
}

- (void)cancelEventsForUser
{
	[self.eventsForUserRequest clearDelegatesAndCancel];
	self.eventsForUserRequest = nil;
}

#pragma mark Questions

- (void)pullQuestionsForEvent:(Event *)event user:(LoggedInUser *)user
{
	NSString *urlString = [NSString stringWithFormat:@"/events/%@/pull.json", event.auditoriumId];
	NSURL *url = [self auditoriumUrlWithString:urlString user:user];
	ASIHTTPRequest *request = [self jsonRequest:url
									method:@"POST"
									data:nil
									finisch:@selector(didPullQuestionsForEvent:)
									fail:@selector(didFailPullPushQuestionsForEvent:)
									userInfo:@{@"event": event}];
	[self.questionsPullPushRequests setObject:request forKey:event.auditoriumId];
	[self.queue addOperation:request];
}

- (void)didPullQuestionsForEvent:(ASIHTTPRequest *)request
{
	if (request.responseStatusCode != 200) {
		[self didFailPullPushQuestionsForEvent:request];
		return;
	}
	Event *event = [request.userInfo objectForKey:@"event"];
	[self.questionsPullPushRequests removeObjectForKey:event.auditoriumId];

	NSDictionary *responseEvent = [request.responseString objectFromJSONString];
	NSDictionary *responsePolls = [responseEvent objectForKey:@"polls"];
	NSInteger version = ((NSNumber *)[responseEvent objectForKey:@"version"]).integerValue;
	NSMutableArray *questions = [NSMutableArray array];

	for (NSDictionary *poll in responsePolls) {
		NSMutableDictionary *question = [NSMutableDictionary dictionary];
		[question setObject:[self normalizeUUID:[poll objectForKey:@"id"]] forKey:@"uuid"];
		[question setObject:[poll objectForKey:@"questiontext"] forKey:@"text"];
		[question setObject:[poll objectForKey:@"on_slide"] forKey:@"slideIdentifier"];
		[question setObject:[poll objectForKey:@"order"] ? [poll objectForKey:@"order"] : [NSNull null] forKey:@"order"];
		NSMutableArray *answers = [NSMutableArray array];
		for (NSDictionary *choice in [poll objectForKey:@"choices"]) {
			NSMutableDictionary *answer = [NSMutableDictionary dictionary];
			[answer setObject:[self normalizeUUID:[choice objectForKey:@"id"]] forKey:@"uuid"];
			[answer setObject:[choice objectForKey:@"answertext"] forKey:@"text"];
			[answer setObject:[choice objectForKey:@"feedback"] forKey:@"feedback"];
			[answer setObject:[choice objectForKey:@"is_correct"] forKey:@"correct"];
			[answer setObject:[choice objectForKey:@"order"] ? [choice objectForKey:@"order"] : [NSNull null] forKey:@"order"];
			[answers addObject:answer];
		}
		QuestionType type;
		if (answers.count == 0) {
			type = QuestionMessageType;
		}
		else {
			NSNumber *correct = [answers valueForKeyPath:@"@max.correct"];
			type = correct.integerValue ? QuestionSingleChoiceType : QuestionMultipleChoiceType;
		}
		[question setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
		[question setObject:answers forKey:@"answers"];
		[questions addObject:question];
	}

	// recreate order
	NSArray *sortedQuestions = [questions sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"slideIdentifier" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
	NSInteger slideIdentifier = 0;
	NSInteger questionOrder = 0;
	for (NSMutableDictionary *question in sortedQuestions) {
		NSInteger questionSlideIdentifier = ((NSNumber *)[question objectForKey:@"slideIdentifier"]).integerValue;
		if (questionSlideIdentifier != slideIdentifier) {
			slideIdentifier = questionSlideIdentifier;
			questionOrder = 0;
		}
		[question setObject:[NSNumber numberWithInteger:questionOrder] forKey:@"order"];
		questionOrder++;
		
		NSInteger answerOrder = 0;
		NSArray *sortedAnswers = [[question objectForKey:@"answers"] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		for (NSMutableDictionary *answer in sortedAnswers) {
			[answer setObject:[NSNumber numberWithInteger:answerOrder] forKey:@"order"];
			answerOrder++;
		}

		NSInteger ruleOrder = 0;
		NSArray *sortedRules = [[question objectForKey:@"rules"] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		for (NSMutableDictionary *rule in sortedRules) {
			[rule setObject:[NSNumber numberWithInteger:ruleOrder] forKey:@"order"];
			ruleOrder++;
		}
	}
//	NSLog(@"%@", questions);
	[delegate didPullQuestionsForEvent:event version:version questions:questions];
}

- (void)pushQuestionsForEvent:(Event *)event user:(LoggedInUser *)user
{
	NSMutableArray *questions = [NSMutableArray array];
	for (Question *question in event.questions) {
		NSMutableArray *answers = [NSMutableArray array];
		for (Answer *answer in question.answers) {
			[answers addObject:@{
				@"version": [NSNumber numberWithInteger:0], // we don't need this – the API "needs" it
				@"id": answer.uuid,
				@"answertext": answer.text,
				@"feedback": answer.feedback,
				@"is_correct": answer.correct,
				@"position": answer.order,
			 }];
		}
		NSMutableArray *rules = [NSMutableArray array];
		for (Rule *rule in question.rules) {
			[rules addObject:@{
				@"id": rule.uuid,
				@"choice_id": rule.answer.uuid,
				@"position": rule.order,
			 }];
		}
		[questions addObject:@{
			@"version": [NSNumber numberWithInteger:0], // we don't need this – the API "needs" it
			@"id": question.uuid,
			@"questiontext": question.text,
			@"on_slide": question.slideIdentifier,
			@"position": question.order,
			@"choices": answers,
			@"poll_rules": rules
		 }];
	}
	NSDictionary *data = @{
		@"id": event.auditoriumId,
		@"version": event.version,
		@"polls": questions
	};
//	NSLog(@"%@", data);

	NSString *urlString = [NSString stringWithFormat:@"/events/%@/push.json", event.auditoriumId];
	NSURL *url = [self auditoriumUrlWithString:urlString user:user];
	ASIHTTPRequest *request = [self jsonRequest:url
									method:@"POST"
									data:data
									finisch:@selector(didPushQuestionsForEvent:)
									fail:@selector(didFailPullPushQuestionsForEvent:)
									userInfo:@{@"event": event}];
	[self.questionsPullPushRequests setObject:request forKey:event.auditoriumId];
	[self.queue addOperation:request];
}

- (void)didPushQuestionsForEvent:(ASIHTTPRequest *)request
{
	if (request.responseStatusCode != 200) {
		[self didFailPullPushQuestionsForEvent:request];
		return;
	}
	Event *event = [request.userInfo objectForKey:@"event"];
	[self.questionsPullPushRequests removeObjectForKey:event.auditoriumId];
	[delegate didPushQuestionsForEvent:event];
}

- (void)didFailPullPushQuestionsForEvent:(ASIHTTPRequest *)request
{
	Event *event = [request.userInfo objectForKey:@"event"];
	[self.questionsPullPushRequests removeObjectForKey:event.auditoriumId];
	NSString *error = request.error ? request.error.description : request.responseStatusMessage;
	[delegate didFailPullPushQuestionsForEvent:event error:error];
}

- (void)cancelPullPushQuestionsForEvent:(Event *)event
{
	ASIHTTPRequest *request = [self.questionsPullPushRequests objectForKey:event.auditoriumId];
	[self.questionsPullPushRequests removeObjectForKey:event.auditoriumId];
	[request clearDelegatesAndCancel];
}

#pragma mark Presentation

- (void)sendCurrentSlide:(Slide *)slide forEvent:(Event *)event user:(LoggedInUser *)user;
{
	NSDictionary *currentSlide = @{
		@"slide_number": [NSNumber numberWithInteger:slide.number],
		@"slide_id": [NSNumber numberWithInteger:slide.identifier]
	};

	NSString *urlString = [NSString stringWithFormat:@"/events/%@/update_slide", event.auditoriumId];
	NSURL *url = [self auditoriumUrlWithString:urlString user:user];
	ASIHTTPRequest *request = [self jsonRequest:url
										 method:@"POST"
										   data:currentSlide
										finisch:@selector(didSendCurrentSlide:)
										   fail:@selector(didSendCurrentSlide:)
									   userInfo:nil];
	[self.queue addOperation:request];
}

- (void)didSendCurrentSlide:(ASIHTTPRequest *)request
{
#ifdef DEBUG
	NSLog(@"%i %@\n%@", request.responseStatusCode, request.responseStatusMessage, request.responseString);
#endif
}

#pragma mark jsonRequest

- (NSURL *)auditoriumUrlWithString:(NSString *)string user:(LoggedInUser *)user
{
	NSURL *url = [NSURL URLWithString:string relativeToURL:[NSURL URLWithString:AUDITORIUM_URL]];
	if (user) {
		NSString *authToken = [user.authToken stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?auth_token=%@", url.absoluteString, authToken]];
	}
	return url;
}

- (ASIHTTPRequest *)jsonRequest:(NSURL *)url method:(NSString *)method data:(NSDictionary *)data finisch:(SEL)finish fail:(SEL)fail userInfo:(id)userInfo
{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request setRequestMethod:method];
	[request addRequestHeader:@"Accept" value:@"application/json"];
	[request addRequestHeader:@"Content-type" value:@"application/json"];
	[request setDidFinishSelector:finish];
	[request setDidFailSelector:fail];
	if (userInfo) {
		[request setUserInfo:userInfo];
	}
	if (data) {
		[request appendPostData:[data JSONData]];
	}
	return request;
}

#pragma mark UUID

- (NSString *)normalizeUUID:(NSString *)uuid
{
	if (uuid.length == 32) {
		return [[NSString stringWithFormat:@"%@-%@-%@-%@-%@",
				[uuid substringWithRange:NSMakeRange(0, 8)],
				[uuid substringWithRange:NSMakeRange(8, 4)],
				[uuid substringWithRange:NSMakeRange(12, 4)],
				[uuid substringWithRange:NSMakeRange(16, 4)],
				[uuid substringWithRange:NSMakeRange(20, 12)]] uppercaseString];
	}
	else {
		return uuid;
	}
}

@end
