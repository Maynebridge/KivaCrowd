//
//  NSObject+MBAdditions.m
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

#import "NSObject+MBAdditions.h"

@implementation NSObject (MBAdditions)

- (BOOL)isDictionary {
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)isArray {
    return [self isKindOfClass:[NSArray class]];
}

- (BOOL)isString {
    return [self isKindOfClass:[NSString class]];
}

- (BOOL)isNull {
    return [self isKindOfClass:[NSNull class]];
}

- (BOOL)isNumber {
    return [self isKindOfClass:[NSNumber class]];
}

- (BOOL)isSet {
    return [self isKindOfClass:[NSSet class]];
}

@end
