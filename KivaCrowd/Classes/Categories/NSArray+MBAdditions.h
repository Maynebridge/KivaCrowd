//
//  NSArray+MBAdditions.h
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

@import Foundation;

/**
 *  The NSArray+JSONProcessing category provides convenience methods allow you to remove/add/manipulate arrays safely and easily.
 */
@interface NSArray (MBAdditions)

/**
 *  Returns a new array that has the specified object removed from it.
 *
 *  @param anObject The object to remove from the array.
 *
 *  @return An array without the object in it anymore.
 */
- (NSArray *)arrayByRemovingObject:(id)anObject;

/**
 *  Safely returns an object at the specified index. If the index is outside of the bounds of the array, returns nil.
 *
 *  @param index The index of the object to retrieve.
 *
 *  @return The object at the specified index or nil.
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

/**
 *  Returns an NSArray that is safe to write to disk by replacing any occurances of NSNull with the empty string.
 *
 *  @return An NSArray instance that has had all instances of NSNull replaced.
 */
- (NSArray *)arrayByReplacingNullsWithEmptyStrings;

@end
