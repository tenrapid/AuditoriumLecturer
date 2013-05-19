//
//  SlideQuestionsController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 10.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "SlideQuestionsController.h"
#import "SlideQuestionsView.h"
#import "QuestionEditView.h"
#import "Question.h"
#import "Auditorium.h"
#import "Slideshow.h"
#import "Slide.h"


@interface SlideQuestionsController ()

@property (assign) IBOutlet Slideshow *slideshow;
@property (assign) IBOutlet Auditorium *auditorium;

@property (assign) IBOutlet NSTabViewItem *tabViewItem;
@property (assign) IBOutlet NSScrollView *scrollView;
@property (assign) IBOutlet NSView *documentView;
@property (assign) IBOutlet SlideQuestionsView *slideQuestionsView;

@property (assign) NSArrayController *questions;
@property (retain) Slide *slide;

@end


@implementation SlideQuestionsController

@synthesize slideshow;
@synthesize auditorium;

@synthesize tabViewItem;
@synthesize scrollView;
@synthesize documentView;
@synthesize slideQuestionsView;

@synthesize questions;
@synthesize slide;

- (void)awakeFromNib
{
	if (self.documentView) {
		[self.tabViewItem setView:self.scrollView];
		[self.scrollView setDocumentView:self.documentView];
		
		self.questions = [[NSArrayController alloc] init];
		[self.questions setManagedObjectContext:[[NSApp delegate] managedObjectContext]];
		[self.questions setEntityName:@"Question"];
		[self.questions setClearsFilterPredicateOnInsertion:NO];
		[self.questions setAutomaticallyRearrangesObjects:YES];
		[self.questions setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
		[self.questions fetch:self];

		[self.slideQuestionsView bind:@"questions" toObject:self.questions withKeyPath:@"arrangedObjects" options:nil];

		[self addObserver:self forKeyPath:@"slide" options:0 context:nil];
		[self bind:@"slide" toObject:self.slideshow withKeyPath:@"currentSlide" options:nil];
		[self.slideQuestionsView bind:@"slide" toObject:self withKeyPath:@"slide" options:nil];

		NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(slideQuestionsViewHeightDidChange:) name:NSViewFrameDidChangeNotification object:self.slideQuestionsView];

		[self calculateViewHeight];
		return;
	}
	[NSBundle loadNibNamed:@"SlideQuestions" owner:self];
}

- (void)dealloc
{
	[self.slideQuestionsView unbind:@"questions"];
	[self.slideQuestionsView unbind:@"slide"];
	[self unbind:@"slide"];
	[self removeObserver:self forKeyPath:@"slide"];
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	[notificationCenter removeObserver:self];
	self.questions = nil;

	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"slide"]) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"slideIdentifier = %@", [NSNumber numberWithInteger:self.slide.number]];
		[self.questions setFilterPredicate:predicate];
	}
}

- (void)calculateViewHeight
{
	float height = self.documentView.frame.size.height - self.slideQuestionsView.frame.origin.y;
	// space for add button
	height += self.slideQuestionsView.frame.size.height ? 65 : 90;
	[self.documentView setFrameSize:NSMakeSize(self.documentView.frame.size.width, height)];
}

- (void)slideQuestionsViewHeightDidChange:(NSNotification *)notification
{
	[self calculateViewHeight];
}

@end
