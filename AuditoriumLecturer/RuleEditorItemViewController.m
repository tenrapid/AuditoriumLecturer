//
//  RuleEditorViewItemController.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 04.07.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "RuleEditorItemViewController.h"
#import "Rule.h"
#import "Question.h"
#import "Answer.h"
#import "Auditorium.h"

@interface RuleEditorItemViewController ()

@property (assign) IBOutlet NSPopUpButton *questionPopUpButton;
@property (assign) IBOutlet NSPopUpButton *answerPopUpButton;

@property (retain) NSArray *questions;
@property (assign) Question *selectedQuestion;
@property (retain) NSArrayController *answers;

@end

@implementation RuleEditorItemViewController

@synthesize plusButton;
@synthesize minusButton;
@synthesize questionPopUpButton;
@synthesize answerPopUpButton;

@synthesize questions = _questions;
@synthesize selectedQuestion = _selectedQuestion;
@synthesize answers = _answers;

- (id)initWithRule:(Rule *)rule questions:(NSArray *)questions
{
    self = [super initWithNibName:@"RuleEditorItem" bundle:nil];
    if (self) {
		self.representedObject = rule;
		_questions = [questions retain];

		if (rule.answer) {
			_selectedQuestion = rule.answer.question;
		}
		[self addObserver:self forKeyPath:@"selectedQuestion" options:0 context:nil];

		_answers = [[NSArrayController alloc] init];
		[_answers setAutomaticallyRearrangesObjects:YES];
		[_answers setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[_answers bind:@"content" toObject:self withKeyPath:@"selectedQuestion.answers" options:0];
    }
    return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"selectedQuestion"];
	self.selectedQuestion = nil;
	self.answers = nil;
	self.questions = nil;
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"selectedQuestion"]) {
		Rule *rule = self.representedObject;
		rule.answer = nil;
	}
}

- (IBAction)addRuleAction:(id)sender
{
	Rule *rule = self.representedObject;
	Rule *newRule = [Auditorium objectForEntityName:@"Rule"];
	newRule.order = [NSNumber numberWithInteger:rule.order.integerValue + 1];
	[rule.question addRulesObject:newRule];
}

- (IBAction)removeRuleAction:(id)sender
{
	Rule *rule = self.representedObject;
	[rule.question removeRulesObject:rule];
	[rule.managedObjectContext deleteObject:rule];
}

#pragma mark  NSMenuDelegate Protocol

- (NSInteger)numberOfItemsInMenu:(NSMenu *)menu
{
	// menu items + nil placeholder
	return self.questions.count + 1;
}

- (BOOL)menu:(NSMenu *)menu updateItem:(NSMenuItem *)item atIndex:(NSInteger)index shouldCancel:(BOOL)shouldCancel
{
	Class class = [item.representedObject class];
	if (class && class != Question.class) {
		[item setEnabled:NO];
	}
    return YES;
}

@end
