//
//  AuditoriumObject.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 21.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AuditoriumObject : NSManagedObject

@property (nonatomic, retain) NSString * uuid;

@end
