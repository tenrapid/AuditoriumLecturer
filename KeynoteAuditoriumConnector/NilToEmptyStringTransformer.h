//
//  NSEmptyStringNilTransformer.h
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 26.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NilToEmptyStringTransformer : NSValueTransformer

+ (Class)transformedValueClass;
+ (BOOL)allowsReverseTransformation;

- (id)transformedValue:(id)value;
- (id)reverseTransformedValue:(id)value;

@end
