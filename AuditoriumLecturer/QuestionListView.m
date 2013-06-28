//
//  QuestionListView.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 22.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionListView.h"
#import "Question.h"
#import "Event.h"
#import "QuestionEditSheetController.h"
#import "MoveQuestionToSlideViewController.h"
#import "Slideshow.h"

@interface QuestionListView ()

@property (assign) IBOutlet NSTextField *textField;
@property (assign) IBOutlet NSPopUpButton *popUpButton;
@property (retain) NSTimer *doubleClickTimer;
@property (retain) NSTrackingArea *trackingArea;
@property (retain) QuestionEditSheetController *questionEditSheetController;
@property (retain) MoveQuestionToSlideViewController *moveQuestionToSlideViewController;

@end

@implementation QuestionListView

@synthesize question;
@synthesize textField;
@synthesize popUpButton;
@synthesize doubleClickTimer;
@synthesize trackingArea;
@synthesize questionEditSheetController;
@synthesize moveQuestionToSlideViewController;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self addObserver:self forKeyPath:@"question.text" options:0 context:nil];
		[self addObserver:self forKeyPath:@"question.type" options:0 context:nil];
    }
    return self;
}

- (void)dealloc
{
	[self removeObserver:self forKeyPath:@"question.text"];
	[self removeObserver:self forKeyPath:@"question.type"];
	[self.doubleClickTimer invalidate];
	self.doubleClickTimer = nil;
	self.trackingArea = nil;
	[super dealloc];
}

- (void)awakeFromNib
{
	[self.popUpButton setHidden:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSDictionary *attributes;

	NSMutableAttributedString *as = [[[NSMutableAttributedString alloc] init] autorelease];

	NSMutableParagraphStyle *paragraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
	paragraphStyle.paragraphSpacing = 1.f;

	attributes = @{NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: [NSColor colorWithCalibratedWhite:0.65f alpha:1.f], NSFontAttributeName:[NSFont systemFontOfSize:12.f]};
	[as appendAttributedString:[[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n", QuestionTypeNames[question.type]] attributes:attributes] autorelease]];

	attributes = @{NSFontAttributeName:[NSFont systemFontOfSize:12.f]};
	[as appendAttributedString:[[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", question.text] attributes:attributes] autorelease]];

	self.textField.attributedStringValue = as;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];

	[[NSColor whiteColor] set];
	NSRectFill([self bounds]);
	
    [[NSColor colorWithDeviceWhite:0.85f alpha:1.f] set];
	[NSBezierPath strokeLineFromPoint:NSMakePoint(0, 0) toPoint:NSMakePoint(self.bounds.size.width, 0)];
}

- (void)mouseUp:(NSEvent *)event
{
	if (event.clickCount == 1) {
		self.doubleClickTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(gotoQuestionSlide) userInfo:nil repeats:NO];
	}
	else if (event.clickCount == 2) {
		[self.doubleClickTimer invalidate];
		[self editQuestion];
	}
}

-(void)updateTrackingAreas
{
	[super updateTrackingAreas];
    if (self.trackingArea != nil) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
	
    self.trackingArea = [[[NSTrackingArea alloc] initWithRect:[self bounds] options:NSTrackingMouseEnteredAndExited |NSTrackingActiveInKeyWindow owner:self userInfo:nil] autorelease];
    [self addTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
	[self.popUpButton setHidden:NO];
}

- (void)mouseExited:(NSEvent *)theEvent
{
	[self.popUpButton setHidden:YES];
}

- (void)gotoQuestionSlide
{
	[[Slideshow sharedInstance] gotoSlideWithIdentifier:question.slideIdentifier.integerValue];
}

- (void)editQuestion
{
	self.questionEditSheetController = [[[QuestionEditSheetController alloc] initWithQuestion:self.question delegate:self] autorelease];
}

- (void)editQuestionDidEnd:(NSInteger)returnCode
{
	self.questionEditSheetController = nil;
}

- (IBAction)moveQuestionToSlideAction:(id)sender
{
	self.moveQuestionToSlideViewController = [[[MoveQuestionToSlideViewController alloc] initWithQuestion:self.question delegate:self] autorelease];
}

- (void)moveQuestionToSlideDidEnd:(NSInteger)returnCode
{
	self.moveQuestionToSlideViewController = nil;
}

- (IBAction)removeQuestionAction:(id)sender
{
	NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
	[undoManager beginUndoGrouping];

	[self.question.event recordModification];
	[self.question willBeDeleted];
	[self.question.managedObjectContext deleteObject:self.question];

	[undoManager endUndoGrouping];
}

- (IBAction)moveQuestionUpAction:(id)sender
{
	NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
	[undoManager beginUndoGrouping];

	[self.question moveUpInOrderChain];
	[self.question.event recordModification];

	[undoManager endUndoGrouping];
}

- (IBAction)moveQuestionDownAction:(id)sender
{
	NSUndoManager *undoManager = [[[NSApp delegate] managedObjectContext] undoManager];
	[undoManager beginUndoGrouping];

	[self.question moveDownInOrderChain];
	[self.question.event recordModification];

	[undoManager endUndoGrouping];
}

#pragma mark  NSMenuValidation Protocol

- (BOOL)validateMenuItem:(NSMenuItem *)item {
	NSInteger count = [self.question countWithPredicate:[NSPredicate predicateWithFormat:@"event = %@ AND slideIdentifier = %@", self.question.event, self.question.slideIdentifier]];
    if ([item action] == @selector(moveQuestionUpAction:) && (self.question.order.integerValue == 0)) {
        return NO;
    }
    else if ([item action] == @selector(moveQuestionDownAction:) && (self.question.order.integerValue == count - 1)) {
        return NO;
    }
    return YES;
}

@end
