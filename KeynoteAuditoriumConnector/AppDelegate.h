//
//  AppDelegate.h
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 26.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Auditorium, Slideshow;


@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) Auditorium *auditorium;
@property (readonly, strong, nonatomic) Slideshow *slideshow;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication;

@end
