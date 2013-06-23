//
//  ListQuestionsController.m
//  AuditoriumLecturer
//
//  Created by Matthias Rahne on 22.06.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "ListQuestionsController.h"
#import "QuestionListViewController.h"

@interface ListQuestionsController ()

@property (assign) IBOutlet NSCollectionView *collectionView;
@property (retain) NSArrayController *questions;

@end

@implementation ListQuestionsController

@synthesize collectionView;
@synthesize questions;

- (void)awakeFromNib
{
	self.questions = [[NSArrayController alloc] init];
	[self.questions setManagedObjectContext:[[NSApp delegate] managedObjectContext]];
	[self.questions setEntityName:@"Question"];
	[self.questions setClearsFilterPredicateOnInsertion:NO];
	[self.questions setAutomaticallyRearrangesObjects:YES];
	[self.questions setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES]]];
	[self.questions fetch:self];

	[self.collectionView setItemPrototype:[[[QuestionListViewController alloc] initWithNibName:nil bundle:nil] autorelease]];
	[self.collectionView bind:@"content" toObject:self.questions	withKeyPath:@"arrangedObjects" options:nil];
//	[self.questions addObserver:self forKeyPath:@"arrangedObjects" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	NSLog(@"%@", self.questions.arrangedObjects);
}

@end
