//
//  NSDictionary+MBAdditions.m
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

#import "NSDictionary+MBAdditions.h"
#import "NSArray+MBAdditions.h"

@implementation NSDictionary (MBAdditions)

- (id)objectOrNilForKey:(id)aKey {
    id returnedObject = [self objectForKey:aKey];
    
    if ([returnedObject isEqual:[NSNull null]]) {
        return nil;
    }
    
    return returnedObject;
}

- (NSString *)stringForKey:(id <NSCopying>)key {
    return [self objectOfClass:[NSString class] forKey:key];
}

- (NSArray *)arrayForKey:(id <NSCopying>)key {
    return [self objectOfClass:[NSArray class] forKey:key];
}

- (NSNumber *)numberForKey:(id <NSCopying>)key {
    return [self objectOfClass:[NSNumber class] forKey:key];
}

- (NSDictionary *)dictionaryForKey:(id <NSCopying>)key {
    return [self objectOfClass:[NSDictionary class] forKey:key];
}

- (id)objectOfClass:(Class)class forKey:(id <NSCopying>)key {
    id object = self[key];
    if (![object isKindOfClass:class]) {
        if (object) {
            NSLog(@"Object: %@ is not of class %@ and therefore will not be returned", object, NSStringFromClass(class));
        }
        
        return nil;
    }
    
    return object;
}

- (NSDictionary *)dictionaryByReplacingNullsWithEmptyStrings {
    NSMutableDictionary *safeDictionary = [self mutableCopy];
    NSString *emptyString = @"";
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        
        if ([object isKindOfClass:[NSNull class]]) {
            [safeDictionary setObject:emptyString forKey:key];
        }
        else if ([object isKindOfClass:[NSDictionary class]]) {
            [safeDictionary setObject:[object dictionaryByReplacingNullsWithEmptyStrings] forKey:key];
        }
        else if ([object isKindOfClass:[NSArray class]]) {
            [safeDictionary setObject:[object arrayByReplacingNullsWithEmptyStrings] forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:[safeDictionary copy]];
}

@end
