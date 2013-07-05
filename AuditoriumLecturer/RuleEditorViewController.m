//
//  RuleEditorViewController.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 04.07.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "RuleEditorViewController.h"
#import "RuleEditorItemViewController.h"
#import "Rule.h"
#import "Question.h"
#import "Event.h"
#import "Auditorium.h"

NSString * const RuleEditorViewHeightDidChangeNotification = @"RuleEditorViewHeightDidChangeNotification";

@interface RuleEditorViewController ()
{
	NSArray *rules;
	NSMutableArray *ruleEditorItemViewControllers;
	NSArrayController *questions;
	NSMutableArray *questionsMenuItems;
}
@end

@implementation RuleEditorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		ruleEditorItemViewControllers = [[NSMutableArray alloc] init];

		questions = [[NSArrayController alloc] init];
		[questions setAutomaticallyRearrangesObjects:YES];
		[questions setFilterPredicate:[NSPredicate predicateWithFormat:@"type != %@", [NSNumber numberWithInteger:QuestionMessageType]]];
		[questions setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"slideNumber" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[questions bind:@"content" toObject:[Auditorium sharedInstance] withKeyPath:@"event.questions" options:0];
		[self updateQuestionsMenuItems];
		[self addObserver:self forKeyPath:@"questions.arrangedObjects" options:0 context:nil];
	}
	return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"questions.arrangedObjects"];
	for (NSViewController *viewController in ruleEditorItemViewControllers) {
		[[viewController view] removeFromSuperview];
	}
	[ruleEditorItemViewControllers removeAllObjects];
	[ruleEditorItemViewControllers release];
	[rules release];
	[questions unbind:@"content"];
	[questions release];
	[questionsMenuItems release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"questions.arrangedObjects"]) {
		[self updateQuestionsMenuItems];
	}
}

- (void)updateQuestionsMenuItems
{
	questionsMenuItems = [NSMutableArray new];
	NSInteger slideNumber = -1;
	for (Question *question in questions.arrangedObjects) {
		if (question.slideNumber.integerValue != slideNumber) {
			slideNumber = question.slideNumber.integerValue;
			[questionsMenuItems addObject:@{@"text": slideNumber ? [NSString stringWithFormat:@"— Folie %li —", (long)slideNumber] : @"— nicht zugeordnet —"}];
		}
		[questionsMenuItems addObject:question];
	}
}

- (void)setRules:(NSArray *)_rules
{
	for (NSViewController *viewController in ruleEditorItemViewControllers) {
		[[viewController view] removeFromSuperview];
	}
	[ruleEditorItemViewControllers removeAllObjects];
	
	[rules release];
	rules = [_rules copy];
	
	for (Rule *rule in rules) {
		RuleEditorItemViewController *viewController = [[RuleEditorItemViewController alloc] initWithRule:rule questions:questionsMenuItems];
		[ruleEditorItemViewControllers addObject:viewController];
		[viewController release];
		
		NSView *view = [viewController view];
		[view setFrame:NSMakeRect(0, 0, self.view.frame.size.width, view.frame.size.height)];
		[self.view addSubview:view];
	}
	
	if ([rules count]) {
		// hide minus button if there is only one answer
		RuleEditorItemViewController *ruleEditorItemViewController = ruleEditorItemViewControllers[0];
		[ruleEditorItemViewController.minusButton setHidden:[rules count] == 1];
	}

	[self updateViewHeight];
	[[self.view window] recalculateKeyViewLoop];
}

- (void)updateViewHeight
{
	NSRect frame;
	// room for "Regeln:" label
	float height = 25;

	for (RuleEditorItemViewController *viewController in ruleEditorItemViewControllers) {
		frame = viewController.view.frame;
		frame.origin.y = height;
		if (height == 25) {
			frame.size.height -= 10;
			[viewController.orLabel setHidden:YES];
		}
		[viewController.view setFrame:frame];

		height += viewController.view.frame.size.height + 4;
	}

	frame = [self.view frame];
	frame.origin.y += frame.size.height - height;
	frame.size.height = height;

	[self.view setFrame:frame];
	[[NSNotificationCenter defaultCenter] postNotificationName:RuleEditorViewHeightDidChangeNotification object:self];
}

@end
