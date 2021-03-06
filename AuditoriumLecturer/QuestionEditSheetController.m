//
//  QuestionEditSheetController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 16.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionEditSheetController.h"
#import "AnswerEditorViewController.h"
#import "RuleEditorViewController.h"
#import "Question.h"
#import "Answer.h"
#import "Rule.h"
#import "Event.h"
#import "Auditorium.h"
#import "Slideshow.h"

NSString * const QuestionEditSheetWillOpenNotification = @"QuestionEditSheetWillOpenNotification";
NSString * const QuestionEditSheetDidCloseNotification = @"QuestionEditSheetDidCloseNotification";

@interface QuestionEditSheetController ()
{
	NSWindow *sheet;
	id delegate;
}

@property (assign) IBOutlet NSTextField *textField;
@property (assign) IBOutlet NSPopUpButton *typePopupButton;
@property (assign) IBOutlet AnswerEditorViewController *answerEditorViewController;
@property (assign) IBOutlet RuleEditorViewController *ruleEditorViewController;
@property (assign) NSArrayController *answers;
@property (assign) NSArrayController *rules;

@end

@implementation QuestionEditSheetController

@synthesize textField;
@synthesize typePopupButton;
@synthesize answerEditorViewController;
@synthesize ruleEditorViewController;
@synthesize answers;
@synthesize rules;

- (id)initWithQuestion:(Question *)aQuestion delegate:(id)aDelegate
{
    self = [super initWithNibName:@"QuestionEditSheet" bundle:nil];
    if (self) {
		[[NSNotificationCenter defaultCenter] postNotificationName:QuestionEditSheetWillOpenNotification object:self];

		NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
		[undoManager beginUndoGrouping];

		if (!aQuestion) {
			aQuestion = [Auditorium objectForEntityName:@"Question"];
			aQuestion.event = [Auditorium sharedInstance].event;
		}
		[self addObserver:self forKeyPath:@"representedObject.type" options:NSKeyValueObservingOptionNew context:nil];
		self.representedObject = aQuestion;

		delegate = [aDelegate retain];
		sheet = self.view.window;

		[self updateViewWidth];
		
		answers = [[NSArrayController alloc] init];
		[answers setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[answers setAutomaticallyRearrangesObjects:YES];
		[answers bind:@"content" toObject:self.representedObject withKeyPath:@"answers" options:nil];
		
		[answerEditorViewController bind:@"answers" toObject:self withKeyPath:@"answers.arrangedObjects" options:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(answerEditorViewHeightDidChange:) name:AnswerEditorViewHeightDidChangeNotification object:answerEditorViewController];

		rules = [[NSArrayController alloc] init];
		[rules setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[rules setAutomaticallyRearrangesObjects:YES];
		[rules bind:@"content" toObject:self.representedObject withKeyPath:@"rules" options:nil];
		
		[ruleEditorViewController bind:@"rules" toObject:self withKeyPath:@"rules.arrangedObjects" options:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ruleEditorViewHeightDidChange:) name:RuleEditorViewHeightDidChangeNotification object:ruleEditorViewController];

		[self updateViewHeight];

		[NSApp beginSheet:sheet modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
	}
    return self;
}

- (void)dealloc
{
	[answerEditorViewController unbind:@"answers"];
	[ruleEditorViewController unbind:@"rules"];
	[answers unbind:@"content"];
	[rules unbind:@"content"];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self removeObserver:self forKeyPath:@"representedObject.type"];
	[answers release];
	[rules release];
	[delegate release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"representedObject.type"]) {
		Question *question = self.representedObject;
		if (!question.uuid) {
			return;
		}
		if (question.type != QuestionMessageType && ![question.answers count]) {
			NSSet *newAnswers = [NSSet setWithObjects:
							  [Auditorium objectForEntityName:@"Answer"],
							  [Auditorium objectForEntityName:@"Answer"],
							  [Auditorium objectForEntityName:@"Answer"], nil];
			[question addAnswers:newAnswers];
		}
		else if (question.type == QuestionMessageType && ![question.rules count]) {
			Rule *rule = [Auditorium objectForEntityName:@"Rule"];
			[question addRulesObject:rule];
		}
	}
}

- (void)updateViewHeight
{
	Question *question = self.representedObject;
	if (question.type == QuestionMessageType) {
		[answerEditorViewController.view setHidden:YES];
	}
	NSInteger staticHeight = 242 + ([self.view.window isSheet] ? 0 : 22);
	NSInteger dynamicHeight = question.type == QuestionMessageType ? ruleEditorViewController.view.frame.size.height : answerEditorViewController.view.frame.size.height;
	NSRect frame = sheet.frame;
	frame.origin.y += (frame.size.height - staticHeight) - dynamicHeight;
	frame.size.height = staticHeight + dynamicHeight;
	[sheet setFrame:frame display:YES animate:YES];
}

- (void)updateViewWidth
{
	NSRect frame = sheet.frame;
	frame.size.width = [[NSApp mainWindow] frame].size.width - 20;
	[sheet setFrame:frame display:YES animate:YES];
}

- (void)answerEditorViewHeightDidChange:(NSNotification *)notification
{
	[self updateViewHeight];
}

- (void)ruleEditorViewHeightDidChange:(NSNotification *)notification
{
	[self updateViewHeight];
}

- (IBAction)cancelButtonAction:(id)sender
{
	[self discardEditing];
	[self.answerEditorViewController discardEditing];
	[NSApp endSheet:sheet returnCode:NSCancelButton];
}

- (IBAction)saveButtonAction:(id)sender
{
	[self commitEditing];
	[self.answerEditorViewController commitEditing];
	[NSApp endSheet:sheet returnCode:NSOKButton];
}

- (void)sheetDidEnd:(NSWindow *)aSheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	[sheet orderOut:self];

	if (returnCode == NSOKButton) {
		Question *question = self.representedObject;
		
		if (!question.slide) {
			question.slide = [Slideshow sharedInstance].currentSlide;
		}
		
		if (question.type == QuestionMessageType) {
			// remove answers
			NSSet *answersToRemove = [NSSet setWithSet:question.answers];
			if (answersToRemove.count) {
				[question removeAnswers:answersToRemove];
				for (Answer *answer in answersToRemove) {
					[answer.managedObjectContext deleteObject:answer];
				}
			}
			// remove invalid rules
			for (Rule *rule in [NSSet setWithSet:question.rules]) {
				if (!(rule.question && rule.answer)) {
					[question removeRulesObject:rule];
					[rule.managedObjectContext deleteObject:rule];
				}
			}
			// remove duplicate rules
			NSArray *rulesAnswers = [question.rules valueForKeyPath:@"@distinctUnionOfObjects.answer"];
			if (rulesAnswers.count != question.rules.count) {
				for (Answer *ruleAnswer in rulesAnswers) {
					NSArray *rulesWithSameAnswer = [question.rules.allObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"answer = %@", ruleAnswer]];
					if (rulesWithSameAnswer.count > 1) {
						[question removeRulesObject:rulesWithSameAnswer.lastObject];
						[ruleAnswer.managedObjectContext deleteObject:rulesWithSameAnswer.lastObject];
					}
				}
			}
		}
		else {
			// remove rules
			NSSet *rulesToRemove = [NSSet setWithSet:question.rules];
			if (rulesToRemove.count) {
				[question removeRules:rulesToRemove];
				for (Rule *rule in rulesToRemove) {
					[rule.managedObjectContext deleteObject:rule];
				}
			}
		}
		
		BOOL hasChanges = NO;
		hasChanges |= question.isInserted || question.isUpdated;
		for (Answer *answer in question.answers) {
			hasChanges |= answer.isInserted || answer.isUpdated;
		}
		for (Rule *rule in question.rules) {
			hasChanges |= rule.isInserted || rule.isUpdated;
		}
		if (hasChanges) {
			[question.event recordModification];
		}
	}

	NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
	[undoManager endUndoGrouping];

	if (returnCode == NSCancelButton) {
		[undoManager undo];
		// clear redo stack by registering fake undo operation
		[undoManager registerUndoWithTarget:[NSNull null] selector:nil object:nil];
		[undoManager performSelector:@selector(removeAllActionsWithTarget:) withObject:[NSNull null] afterDelay:0.0];
	}

	[[NSNotificationCenter defaultCenter] postNotificationName:QuestionEditSheetDidCloseNotification object:self];
	[self invokeDelegateWith:returnCode];
}

- (void)invokeDelegateWith:(NSInteger)returnCode
{
	SEL selector = @selector(editQuestionDidEnd:);
	NSMethodSignature *methodSignature = [delegate methodSignatureForSelector:selector];
	if (methodSignature == nil) {
		return;
	}
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
	[invocation setTarget:delegate];
	[invocation setSelector:selector];
	[invocation setArgument:&returnCode atIndex:2];
	[invocation invoke];
}

@end
