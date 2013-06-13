//
//  AppDelegate.m
//  KeynoteAuditoriumConnector
//
//  Created by Matthias Rahne on 26.04.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AppDelegate.h"
#import "Auditorium.h"
#import "Slideshow.h"
#import "NilToEmptyStringTransformer.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize auditorium = _auditorium;
@synthesize slideshow = _slideshow;

+ (void)initialize
{
	NilToEmptyStringTransformer *emptyStringToNilTransformer = [[[NilToEmptyStringTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:emptyStringToNilTransformer forName:@"NilToEmptyStringTransformer"];
}

- (id)init
{
	self = [super init];
	if (self) {
		[NSApp setDelegate:self];
		_auditorium = [Auditorium sharedInstance];
		_slideshow = [Slideshow sharedInstance];
	}
	return self;
}

- (void)dealloc
{
	[_persistentStoreCoordinator release];
	[_managedObjectModel release];
	[_managedObjectContext release];
	[_auditorium release];
	[_slideshow release];
    [super dealloc];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];

	NSEntityDescription *entity;
	NSAttributeDescription *textAttribute;
	entity = [[_managedObjectModel entitiesByName] objectForKey:@"Question"];
	textAttribute = [[entity attributesByName] objectForKey:@"text"];
	[textAttribute setDefaultValue:@""];
	entity = [[_managedObjectModel entitiesByName] objectForKey:@"Answer"];
	textAttribute = [[entity attributesByName] objectForKey:@"text"];
	[textAttribute setDefaultValue:@""];

    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSError *error = nil;
        
    NSPersistentStoreCoordinator *coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom] autorelease];
	if (![coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
	}
    _persistentStoreCoordinator = [coordinator retain];
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
	
    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	return YES;
}

@end
