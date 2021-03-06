//
//  SlideQuestionsController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 10.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "SlideQuestionsController.h"
#import "SlideQuestionsView.h"
#import "Question.h"
#import "Auditorium.h"
#import "Slideshow.h"
#import "Slide.h"
#import "Event.h"


@interface SlideQuestionsController ()

@property (assign) IBOutlet NSTabViewItem *tabViewItem;
@property (assign) IBOutlet NSScrollView *scrollView;
@property (assign) IBOutlet NSView *documentView;
@property (assign) IBOutlet SlideQuestionsView *slideQuestionsView;

@property (assign) NSArrayController *questions;
@property (retain) Slide *slide;
@property (retain) Event *event;

@end


@implementation SlideQuestionsController

@synthesize tabViewItem;
@synthesize scrollView;
@synthesize documentView;
@synthesize slideQuestionsView;

@synthesize questions;
@synthesize slide;
@synthesize event;

- (void)awakeFromNib
{
	if (self.documentView) {
		[self.tabViewItem setView:self.scrollView];
		[self.scrollView setDocumentView:self.documentView];
		
		self.questions = [[NSArrayController alloc] init];
		[self.questions setManagedObjectContext:[[NSApp delegate] managedObjectContext]];
		[self.questions setEntityName:@"Question"];
		[self.questions setAutomaticallyRearrangesObjects:YES];
		[self.questions setFetchPredicate:[self questionsFetchPredicate]];
		[self.questions setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[self.questions fetch:self];

		[self.slideQuestionsView bind:@"questions" toObject:self.questions withKeyPath:@"arrangedObjects" options:nil];

		[self addObserver:self forKeyPath:@"event" options:0 context:nil];
		[self addObserver:self forKeyPath:@"slide" options:0 context:nil];
		[self bind:@"event" toObject:[Auditorium sharedInstance] withKeyPath:@"event" options:nil];
		[self bind:@"slide" toObject:[Slideshow sharedInstance] withKeyPath:@"currentSlide" options:nil];

		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(slideQuestionsViewHeightDidChange:) name:SlideQuestionsViewHeightDidChangeNotification object:self.slideQuestionsView];

		[self updateViewHeight];
		return;
	}
	[NSBundle loadNibNamed:@"SlideQuestions" owner:self];
}

- (void)dealloc
{
	[self.slideQuestionsView unbind:@"questions"];
	[self unbind:@"event"];
	[self unbind:@"slide"];
	[self removeObserver:self forKeyPath:@"event"];
	[self removeObserver:self forKeyPath:@"slide"];
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter removeObserver:self];
	self.questions = nil;

	[super dealloc];
}

- (NSPredicate *)questionsFetchPredicate
{
	return [NSPredicate predicateWithFormat:@"event = %@ AND slideIdentifier = %@ AND slideIdentifier != 0", self.event, [NSNumber numberWithInteger:self.slide.identifier]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"event"] || [keyPath isEqualToString:@"slide"]) {
		[self.questions setFetchPredicate:[self questionsFetchPredicate]];
	}
}

- (void)updateViewHeight
{
	float height = self.documentView.frame.size.height - self.slideQuestionsView.frame.origin.y;
	// space for add button
	height += self.slideQuestionsView.frame.size.height ? 85 : 90;
	[self.documentView setFrameSize:NSMakeSize(self.documentView.frame.size.width, height)];
}

- (void)slideQuestionsViewHeightDidChange:(NSNotification *)notification
{
	[self updateViewHeight];
}

- (IBAction)nextOrPreviousSlideAction:(id)sender
{
	NSSegmentedControl *control = sender;
	NSSegmentedCell *cell = control.cell;
	if (cell.selectedSegment == 0) {
		[[Slideshow sharedInstance] gotoPreviousSlide];
	}
	else if (cell.selectedSegment == 1) {
		[[Slideshow sharedInstance] gotoNextSlide];
	}
}

@end
