//
//  NSEmptyStringNilTransformer.m
//  Keynote Auditorium Connector
//
//  Created by Matthias Rahne on 26.05.13.
//  Copyright (c) 2013 Matthias Rahne. All rights reserved.
//

#import "NilToEmptyStringTransformer.h"

@implementation NilToEmptyStringTransformer

+ (Class)transformedValueClass
{
	return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

- (id)transformedValue:(id)value
{
	return value;
}

- (id)reverseTransformedValue:(id)value
{
	return value == nil ? @"" : value;
}

@end
