//
//  QuestionEditSheetController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 16.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionEditSheetController.h"
#import "AnswersEditViewController.h"
#import "Question.h"
#import "Answer.h"
#import "Auditorium.h"
#import "Slideshow.h"

@interface QuestionEditSheetController ()
{
	NSWindow *sheet;
	id delegate;
}

@property (assign) IBOutlet NSTextField *textField;
@property (assign) IBOutlet NSPopUpButton *typePopupButton;
@property (assign) IBOutlet NSRuleEditor *ruleEditor;
@property (assign) IBOutlet AnswersEditViewController *answersEditViewController;
@property (assign) NSArrayController *answers;

@end

@implementation QuestionEditSheetController

@synthesize textField;
@synthesize typePopupButton;
@synthesize ruleEditor;
@synthesize answersEditViewController;
@synthesize answers;

- (id)initWithQuestion:(Question *)aQuestion delegate:(id)aDelegate
{
    self = [super initWithNibName:@"QuestionEditSheet" bundle:nil];
    if (self) {
		NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
		[undoManager beginUndoGrouping];

		if (!aQuestion) {
			aQuestion = [Auditorium objectForEntityName:@"Question"];
			aQuestion.event = [Auditorium sharedInstance].event;
		}
		self.representedObject = aQuestion;

		delegate = aDelegate;
		sheet = self.view.window;

		answers = [[NSArrayController alloc] init];
		[answers setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[answers setAutomaticallyRearrangesObjects:YES];
		[answers bind:@"content" toObject:self.representedObject withKeyPath:@"answers" options:nil];
		
		[answersEditViewController bind:@"answers" toObject:self withKeyPath:@"answers.arrangedObjects" options:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(answersEditViewHeightDidChange:) name:AnswersEditViewHeightDidChangeNotification object:answersEditViewController];

		[self addObserver:self forKeyPath:@"representedObject.type" options:NSKeyValueObservingOptionNew context:nil];

		[self updateViewWidth];
		[self updateViewHeight];
		[NSApp beginSheet:sheet modalForWindow:[NSApp mainWindow] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
	}
    return self;
}

- (void)dealloc
{
	[answers unbind:@"content"];
	[answersEditViewController unbind:@"answers"];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self removeObserver:self forKeyPath:@"representedObject.type"];
	self.answers = nil;
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"representedObject.type"]) {
		Question *question = self.representedObject;
		if (question.type != QuestionMessageType && ![question.answers count]) {
			NSSet *newAnswers = [NSSet setWithObjects:
							  [Auditorium objectForEntityName:@"Answer"],
							  [Auditorium objectForEntityName:@"Answer"],
							  [Auditorium objectForEntityName:@"Answer"], nil];
			[question addAnswers:newAnswers];
		}
	}
}

- (void)updateViewHeight
{
	Question *question = self.representedObject;
	if (question.type == QuestionMessageType) {
		[answersEditViewController.view setHidden:YES];
	}
	NSInteger staticHeight = (question.type == QuestionMessageType ? 328 : 242) + ([self.view.window isSheet] ? 0 : 22);
	NSInteger dynamicHeight = question.type == QuestionMessageType ? -6 : answersEditViewController.view.frame.size.height;
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

- (void)answersEditViewHeightDidChange:(NSNotification *)notification
{
	[self updateViewHeight];
}

- (IBAction)cancelButtonAction:(id)sender
{
	[self discardEditing];
	[self.answersEditViewController discardEditing];
	[NSApp endSheet:sheet returnCode:NSCancelButton];
}

- (IBAction)saveButtonAction:(id)sender
{
	[self commitEditing];
	[self.answersEditViewController commitEditing];
	
	Question *question = self.representedObject;
	if (!question.slide) {
		question.slide = [Slideshow sharedInstance].currentSlide;
	}
	if (question.type == QuestionMessageType) {
		NSSet *answersToRemove = [NSSet setWithSet:question.answers];
		[question removeAnswers:answersToRemove];
		for (Answer *answer in answersToRemove) {
			[answer.managedObjectContext deleteObject:answer];
		}
	}

	[NSApp endSheet:sheet returnCode:NSOKButton];
}

- (void)sheetDidEnd:(NSWindow *)aSheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	[sheet orderOut:self];

	NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
	[undoManager endUndoGrouping];

	if (returnCode == NSCancelButton) {
		[undoManager undo];
		// clear redo stack by registering fake undo operation
		[undoManager registerUndoWithTarget:[NSNull null] selector:nil object:nil];
		[undoManager performSelector:@selector(removeAllActionsWithTarget:) withObject:[NSNull null] afterDelay:0.0];
	}

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

- (BOOL)control:(NSControl*)control textView:(NSTextField*)textfield doCommandBySelector:(SEL)commandSelector
{
	BOOL result = NO;
	if (commandSelector == @selector(insertNewline:)) {
		[textfield insertNewlineIgnoringFieldEditor:self];
		result = YES;
	}
	return result;
}

@end
