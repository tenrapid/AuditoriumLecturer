//
//  AuditoriumObject.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 21.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "AuditoriumObject.h"


@implementation AuditoriumObject

@dynamic uuid;

- (NSArray *)fetchWithPredicate:(NSPredicate *)predicate
{
	NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setEntity:self.entity];
	[fetchRequest setPredicate:predicate];
	return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (NSInteger)countWithPredicate:(NSPredicate *)predicate
{
	NSError *error;
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	[fetchRequest setEntity:self.entity];
	[fetchRequest setPredicate:predicate];
	return [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
}

@end
