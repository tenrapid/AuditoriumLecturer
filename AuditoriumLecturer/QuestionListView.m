//
//  QuestionListView.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 22.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionListView.h"
#import "Question.h"

@interface QuestionListView ()

@property (assign) IBOutlet NSTextField *textField;

@end

@implementation QuestionListView

@synthesize question;
@synthesize textField;

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
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSDictionary *attributes;

	NSMutableAttributedString *as = [[[NSMutableAttributedString alloc] init] autorelease];

	NSMutableParagraphStyle *paragraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
	paragraphStyle.paragraphSpacing = 1.f;

	attributes = @{NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: [NSColor colorWithDeviceWhite:0.6f alpha:1.f], NSKernAttributeName: @1.f, NSFontAttributeName:[NSFont systemFontOfSize:10.f]};
	[as appendAttributedString:[[[NSAttributedString alloc] initWithString:[[NSString stringWithFormat:@"%@\r", QuestionTypeNames[question.type]] uppercaseString] attributes:attributes] autorelease]];

	attributes = @{NSFontAttributeName:[NSFont systemFontOfSize:12.f]};
	[as appendAttributedString:[[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", question.text] attributes:attributes] autorelease]];

	self.textField.attributedStringValue = as;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];

	[[NSColor whiteColor] set];
	NSRectFill([self bounds]);
	
    [[NSColor colorWithDeviceWhite:0.8f alpha:1.f] set];
	[NSBezierPath strokeLineFromPoint:NSMakePoint(0, 0) toPoint:NSMakePoint(self.bounds.size.width, 0)];
}

@end
