//
//  QuestionsController.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 10.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "QuestionsController.h"
#import "SMTabBar.h"
#import "SMTabBarItem.h"


@interface QuestionsController ()

@property (assign) IBOutlet SMTabBar *tabBar;
@property (assign) IBOutlet NSTabView *tabView;

@end


@implementation QuestionsController

@synthesize tabBar;
@synthesize tabView;

- (void)awakeFromNib
{
    NSMutableArray *tabBarItems = [NSMutableArray arrayWithCapacity:2];
    {
        NSImage *image = [NSImage imageNamed:@"TB_Edit.png"];
        [image setTemplate:YES];
        SMTabBarItem *item = [[SMTabBarItem alloc] initWithImage:image tag:0];
        item.toolTip = NSLocalizedString(@"Fragen bearbeiten", nil);
        item.keyEquivalent = @"1";
        item.keyEquivalentModifierMask = NSCommandKeyMask;
        [tabBarItems addObject:item];
    }
    {
        NSImage *image = [NSImage imageNamed:@"TB_List.png"];
        [image setTemplate:YES];
        SMTabBarItem *item = [[SMTabBarItem alloc] initWithImage:image tag:1];
        item.toolTip = NSLocalizedString(@"Fragenliste", nil);
        item.keyEquivalent = @"2";
        item.keyEquivalentModifierMask = NSCommandKeyMask;
        [tabBarItems addObject:item];
    }
    self.tabBar.items = tabBarItems;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)tabBar:(SMTabBar *)tabBar didSelectItem:(SMTabBarItem *)item {
    [self.tabView selectTabViewItemAtIndex:[self.tabBar.items indexOfObject:item]];
}

@end
