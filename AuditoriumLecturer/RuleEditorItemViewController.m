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
@property (retain) NSMutableArray *answersMenuItems;

@end

@implementation RuleEditorItemViewController

@synthesize plusButton;
@synthesize minusButton;
@synthesize questionPopUpButton;
@synthesize answerPopUpButton;
@synthesize orLabel;

@synthesize questions = _questions;
@synthesize selectedQuestion = _selectedQuestion;
@synthesize answers = _answers;
@synthesize answersMenuItems = _answersMenuItems;

- (id)initWithRule:(Rule *)rule questions:(NSArray *)questions
{
    self = [super initWithNibName:@"RuleEditorItem" bundle:nil];
    if (self) {
		self.representedObject = rule;
		_questions = [questions retain];
		_answersMenuItems = [[NSMutableArray alloc] init];

		_answers = [[NSArrayController alloc] init];
		[_answers setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"answer.order" ascending:YES]]];
		[_answers setContent:_answersMenuItems];

		if (rule.answer) {
			_selectedQuestion = rule.answer.question;
			[self updateAnswersMenuItemValues];
		}
		[self addObserver:self forKeyPath:@"selectedQuestion" options:0 context:nil];
    }
    return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"selectedQuestion"];
	_selectedQuestion = nil;
	[_answers release];
	[_answersMenuItems release];
	[_questions release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"selectedQuestion"]) {
		Rule *rule = self.representedObject;
		rule.answer = nil;
		[self updateAnswersMenuItemValues];
	}
}

- (void)updateAnswersMenuItemValues
{
	[_answersMenuItems removeAllObjects];
	for (Answer *answer in _selectedQuestion.answers) {
		NSString *text;
		if (_selectedQuestion.type == QuestionSingleChoiceType) {
			text = [NSString stringWithFormat:@"%@: %@", answer.correct.boolValue ? @"RICHTIG" : @"FALSCH", answer.text];
		}
		else {
			text = [NSString stringWithFormat:@"%@", answer.text];
		}
		[_answersMenuItems addObject:@{@"answer": answer, @"text": text}];
	}
	[_answers rearrangeObjects];
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
