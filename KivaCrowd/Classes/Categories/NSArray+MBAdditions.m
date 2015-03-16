//
//  NSArray+MBAdditions.m
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

#import "NSArray+MBAdditions.h"
#import "NSDictionary+MBAdditions.h"

@implementation NSArray (MBAdditions)

- (NSArray *)arrayByRemovingObject:(id)anObject {
    NSMutableArray *mutableCopy = [self mutableCopy];
    [mutableCopy removeObject:anObject];
    
    return [mutableCopy copy];
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index < [self count]) {
        return [self objectAtIndex:index];
    }
    
    return nil;
}

- (NSArray *)arrayByReplacingNullsWithEmptyStrings  {
    NSMutableArray *safeArray = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *emptyString = @"";
    
    for (int index = 0; index < [safeArray count]; index++) {
        id object = [safeArray objectAtIndex:index];
        if (object == nul) {
            [safeArray replaceObjectAtIndex:index withObject:emptyString];
        }
        else if ([object isKindOfClass:[NSDictionary class]]) {
            [safeArray replaceObjectAtIndex:index withObject:[object dictionaryByReplacingNullsWithEmptyStrings]];
        }
        else if ([object isKindOfClass:[NSArray class]]) {
            [safeArray replaceObjectAtIndex:index withObject:[object arrayByReplacingNullsWithEmptyStrings]];
        }
    }
    
    return [safeArray copy];
}

@end
