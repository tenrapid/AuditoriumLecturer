//
//  QuestionEditViewController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 12.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionView.h"
#import "Question.h"
#import "Answer.h"

@interface QuestionViewController ()

@property (assign) NSArrayController *answers;

@end

@implementation QuestionViewController

@synthesize moveQuestionUpMenuItem;
@synthesize moveQuestionDownMenuItem;
@synthesize moveQuestionToSlideMenuItem;
@synthesize removeQuestionMenuItem;
@synthesize editQuestionButton;

@synthesize answers;

- (id)initWithQuestion:(Question *)question
{
    self = [super initWithNibName:@"QuestionEdit" bundle:nil];
    if (self) {
		answers = [[NSArrayController alloc] init];
		[answers setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[answers setAutomaticallyRearrangesObjects:YES];
		[answers bind:@"contentSet" toObject:self withKeyPath:@"representedObject.answers" options:nil];
		[self addObserver:self forKeyPath:@"representedObject.text" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"representedObject.type" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"answers.arrangedObjects.text" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"answers.arrangedObjects.correct" options:NSKeyValueObservingOptionNew context:nil];
		self.representedObject = question;
    }
    return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"representedObject.text"];
	[self removeObserver:self forKeyPath:@"representedObject.type"];
	[self removeObserver:self forKeyPath:@"answers.arrangedObjects.text"];
	[self removeObserver:self forKeyPath:@"answers.arrangedObjects.correct"];
	[answers unbind:@"contentSet"];
	[answers release];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"representedObject.text"] || [keyPath isEqualToString:@"representedObject.type"] || [keyPath isEqualToString:@"answers.arrangedObjects.text"] || [keyPath isEqualToString:@"answers.arrangedObjects.correct"]) {
		Question *question = self.representedObject;

		NSMutableAttributedString *as = [[[NSMutableAttributedString alloc] initWithString:question.text] autorelease];
		
		if (question.type != QuestionMessageType) {
			NSString *answersHeader = [NSString stringWithFormat:@"\n\nAntworten (%@):", QuestionTypeNames[question.type]];
			NSDictionary *answersHeaderAttributes = @{NSForegroundColorAttributeName: [NSColor grayColor]};
			[as appendAttributedString:[[[NSAttributedString alloc] initWithString:answersHeader attributes:answersHeaderAttributes] autorelease]];
			
			NSMutableParagraphStyle *paragraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
			NSTextTab *tab1 = [[[NSTextTab alloc] initWithType:NSLeftTabStopType location:12] autorelease];
			NSTextTab *tab2 = [[[NSTextTab alloc] initWithType:NSLeftTabStopType location:27] autorelease];
			[paragraphStyle setTabStops:@[tab1, tab2]];
			[paragraphStyle setHeadIndent:27];
			NSDictionary *answerAttributes = @{NSParagraphStyleAttributeName: paragraphStyle};
			
			NSColor *checkMarkColor = [NSColor colorWithDeviceRed:0.6 green:0.85 blue:0.2 alpha:1];
			NSDictionary *checkMarkAttributes = @{NSForegroundColorAttributeName: checkMarkColor};
			NSAttributedString *checkMark = [[[NSAttributedString alloc] initWithString:@"  ✔" attributes:checkMarkAttributes] autorelease];
			
			for (Answer *answer in [self.answers valueForKeyPath:@"arrangedObjects"]) {
				NSString *answerString = [NSString stringWithFormat:@"\n\t●\t%@", answer.text];
				[as appendAttributedString:[[[NSAttributedString alloc] initWithString:answerString attributes:answerAttributes] autorelease]];
				if (answer.correct.boolValue) {
					[as appendAttributedString:checkMark];
				}
			}
		}
		
		QuestionView *questionView = (QuestionView *)self.view;
		[questionView.textView.textStorage setAttributedString:as];
	}
}

@end
