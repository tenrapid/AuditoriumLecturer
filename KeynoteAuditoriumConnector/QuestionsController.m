//
//  QuestionsController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 10.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionsController.h"
#import "Auditorium.h"
#import "AuditoriumEvent.h"
#import "Slideshow.h"
#import "SMTabBar.h"
#import "SMTabBarItem.h"


@interface QuestionsController ()

@property (assign) IBOutlet SMTabBar *tabBar;
@property (assign) IBOutlet NSTabView *tabView;

@end


@implementation QuestionsController

@synthesize auditorium;
@synthesize auditoriumController;
@synthesize slideshow;
@synthesize tabBar;
@synthesize tabView;

- (void)awakeFromNib
{
    NSMutableArray *tabBarItems = [NSMutableArray arrayWithCapacity:2];
    {
        NSImage *image = [NSImage imageNamed:@"TB_Edit.png"];
        [image setTemplate:YES];
        SMTabBarItem *item = [[SMTabBarItem alloc] initWithImage:image tag:0];
        item.toolTip = NSLocalizedString(@"Tab 1", nil);
        item.keyEquivalent = @"1";
        item.keyEquivalentModifierMask = NSCommandKeyMask;
        [tabBarItems addObject:item];
    }
    {
        NSImage *image = [NSImage imageNamed:@"TB_List.png"];
        [image setTemplate:YES];
        SMTabBarItem *item = [[SMTabBarItem alloc] initWithImage:image tag:1];
        item.toolTip = NSLocalizedString(@"Tab 2", nil);
        item.keyEquivalent = @"2";
        item.keyEquivalentModifierMask = NSCommandKeyMask;
        [tabBarItems addObject:item];
    }
    self.tabBar.items = tabBarItems;
	
	[auditoriumController addObserver:self forKeyPath:@"currentAuditoriumEvent" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
	[auditoriumController removeObserver:self forKeyPath:@"currentAuditoriumEvent"];
	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"currentAuditoriumEvent"]) {
	}
}
	
- (void)tabBar:(SMTabBar *)tabBar didSelectItem:(SMTabBarItem *)item {
    [self.tabView selectTabViewItemAtIndex:[self.tabBar.items indexOfObject:item]];
}

@end
