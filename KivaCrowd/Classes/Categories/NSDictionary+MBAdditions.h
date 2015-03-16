//
//  NSDictionary+MBAdditions.h
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

@import Foundation;

/**
 *  The NSDictionary+NYTAdditions category provides convenience methods for accessing objects on an NSDictionary.
 */
@interface NSDictionary (MBAdditions)

/**
 *  Returns an object for the specified key, or nil. This method will also return nil for instances of NSNull.
 *
 *  @param aKey The key to check the dictionary for.
 *
 *  @return An object if the specified key existed in the dictionary. Otherwise, nil.
 */
- (id)objectOrNilForKey:(id)aKey;

/**
 *  Returns the NSString value for the specified key, or nil if it's not an NSString instance.
 *
 *  @param key The key to check the dictionary for.
 *
 *  @return An instance of NSString if the key exists in the dictionary, otherwise nil.
 */
- (NSString *)stringForKey:(id <NSCopying>)key;

/**
 *  Returns the NSArray value for the specified key, or nil if it's not an NSArray instance.
 *
 *  @param key The key to check the dictionary for.
 *
 *  @return An instance of NSArray if the key exists in the dictionary, otherwise nil.
 */
- (NSArray *)arrayForKey:(id <NSCopying>)key;

/**
 *  Returns the NSNumber value for the specified key, or nil if it's not an NSNumber instance.
 *
 *  @param key The key to check the dictionary for.
 *
 *  @return An instance of NSNumber if the key exists in the dictionary, otherwise nil.
 */
- (NSNumber *)numberForKey:(id <NSCopying>)key;

/**
 *  Returns the NSDictionary value for the specified key, or nil if it's not an NSDictionary instance.
 *
 *  @param key The key to check the dictionary for.
 *
 *  @return An instance of NSDictionary if the key exists in the dictionary, otherwise nil.
 */
- (NSDictionary *)dictionaryForKey:(id <NSCopying>)key;

/**
 *  Returns an NSDictionary that is safe to write to disk by replacing any occurances of NSNull with the empty string.
 *
 *  @return An NSDictionary instance that has had all instances of NSNull replaced.
 */
- (NSDictionary *)dictionaryByReplacingNullsWithEmptyStrings;

@end
