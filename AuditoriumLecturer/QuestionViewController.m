//
//  QuestionEditViewController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionView.h"
#import "QuestionEditSheetController.h"
#import "Question.h"
#import "Answer.h"

@interface QuestionViewController ()

@property (assign) NSArrayController *answers;
@property (assign, getter = isUpdateDisabled) BOOL updateDisabled;
@property (assign, getter = isChanged) BOOL changed;

@end

@implementation QuestionViewController

@synthesize moveQuestionUpMenuItem;
@synthesize moveQuestionDownMenuItem;
@synthesize moveQuestionToSlideMenuItem;
@synthesize removeQuestionMenuItem;
@synthesize editQuestionButton;

@synthesize answers;
@synthesize updateDisabled;
@synthesize changed;

- (id)initWithQuestion:(Question *)question
{
    self = [super initWithNibName:@"QuestionEdit" bundle:nil];
    if (self) {
		self.representedObject = question;
		answers = [[NSArrayController alloc] init];
		[answers setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[answers setAutomaticallyRearrangesObjects:YES];
		[answers bind:@"contentSet" toObject:self withKeyPath:@"representedObject.answers" options:nil];
		[self updateTextView];

		[self addObserver:self forKeyPath:@"representedObject.text" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"representedObject.type" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"answers.arrangedObjects.text" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"answers.arrangedObjects.feedback" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"answers.arrangedObjects.correct" options:NSKeyValueObservingOptionNew context:nil];
		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(questionEditSheet:) name:QuestionEditSheetWillOpenNotification object:nil];
		[notificationCenter addObserver:self selector:@selector(questionEditSheet:) name:QuestionEditSheetDidCloseNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"representedObject.text"];
	[self removeObserver:self forKeyPath:@"representedObject.type"];
	[self removeObserver:self forKeyPath:@"answers.arrangedObjects.text"];
	[self removeObserver:self forKeyPath:@"answers.arrangedObjects.feedback"];
	[self removeObserver:self forKeyPath:@"answers.arrangedObjects.correct"];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[answers unbind:@"contentSet"];
	[answers release];
	[super dealloc];
}

- (void)questionEditSheet:(NSNotification *)notification
{
	if ([notification.name isEqualToString:QuestionEditSheetWillOpenNotification]) {
		self.updateDisabled = YES;
		self.changed = NO;
	}
	else if ([notification.name isEqualToString:QuestionEditSheetDidCloseNotification]) {
		self.updateDisabled = NO;
		if (self.isChanged) {
			[self updateTextView];
		}
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"representedObject.text"] || [keyPath isEqualToString:@"representedObject.type"] || [keyPath isEqualToString:@"answers.arrangedObjects.text"] || [keyPath isEqualToString:@"answers.arrangedObjects.feedback"] || [keyPath isEqualToString:@"answers.arrangedObjects.correct"]) {
		if (self.isUpdateDisabled) {
			self.changed = YES;
		}
		else {
			[self updateTextView];
		}
	}
}

- (void)updateTextView
{
	Question *question = self.representedObject;
	if (!question.text) {
		return;
	}

	NSMutableParagraphStyle *paragraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
	[paragraphStyle setLineSpacing:1];

	NSMutableAttributedString *as = [[[NSMutableAttributedString alloc] initWithString:question.text attributes:@{NSParagraphStyleAttributeName: paragraphStyle}] autorelease];
	
	if (question.type != QuestionMessageType) {
		NSString *answersHeader = [NSString stringWithFormat:@"\n\nAntworten (%@):", QuestionTypeNames[question.type]];
		NSDictionary *answersHeaderAttributes = @{NSForegroundColorAttributeName: [NSColor grayColor], NSParagraphStyleAttributeName: paragraphStyle};
		[as appendAttributedString:[[[NSAttributedString alloc] initWithString:answersHeader attributes:answersHeaderAttributes] autorelease]];
		
		NSMutableParagraphStyle *answerParagraphStyle = [[paragraphStyle mutableCopy] autorelease];
		NSTextTab *tab1 = [[[NSTextTab alloc] initWithType:NSLeftTabStopType location:12] autorelease];
		NSTextTab *tab2 = [[[NSTextTab alloc] initWithType:NSLeftTabStopType location:27] autorelease];
		[answerParagraphStyle setTabStops:@[tab1, tab2]];
		[answerParagraphStyle setHeadIndent:27];
		[answerParagraphStyle setParagraphSpacingBefore:6];
		NSMutableParagraphStyle *feedbackParagraphStyle = [[answerParagraphStyle mutableCopy] autorelease];
		NSDictionary *answerAttributes = @{NSParagraphStyleAttributeName: answerParagraphStyle};
		
		NSColor *greenColor = [NSColor colorWithDeviceRed:0.6 green:0.85 blue:0.2 alpha:1];
		NSColor *redColor = [NSColor colorWithDeviceRed:0.8 green:0.2 blue:0.2 alpha:1];
		NSDictionary *checkMarkAttributes = @{NSForegroundColorAttributeName: greenColor};
		NSAttributedString *checkMark = [[[NSAttributedString alloc] initWithString:@"  ✔" attributes:checkMarkAttributes] autorelease];
		
		for (Answer *answer in [self.answers valueForKeyPath:@"arrangedObjects"]) {
			[as appendAttributedString:[[[NSAttributedString alloc] initWithString:@"\n"] autorelease]];
			NSString *answerString = [NSString stringWithFormat:@"\t●\t%@", answer.text];
			[as appendAttributedString:[[[NSAttributedString alloc] initWithString:answerString attributes:answerAttributes] autorelease]];
			if (question.type == QuestionSingleChoiceType) {
				if (answer.correct.boolValue) {
					[as appendAttributedString:checkMark];
				}
				if (answer.feedback && ![answer.feedback isEqualToString:@""]) {
					[as appendAttributedString:[[[NSAttributedString alloc] initWithString:@"\n"] autorelease]];
					if (answer.correct.boolValue) {
						[as appendAttributedString:[[[NSAttributedString alloc] initWithString:@"\t\tRichtig: " attributes:@{NSForegroundColorAttributeName: greenColor, NSParagraphStyleAttributeName: feedbackParagraphStyle}] autorelease]];
					}
					else {
						[as appendAttributedString:[[[NSAttributedString alloc] initWithString:@"\t\tFalsch: " attributes:@{NSForegroundColorAttributeName: redColor, NSParagraphStyleAttributeName: feedbackParagraphStyle}] autorelease]];
					}
					[as appendAttributedString:[[[NSAttributedString alloc] initWithString:answer.feedback] autorelease]];
				}
			}
		}
	}
	
	QuestionView *questionView = (QuestionView *)self.view;
	[questionView.textView.textStorage setAttributedString:as];
}

@end
