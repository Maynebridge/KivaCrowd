//
//  NSObject+MBAdditions.h
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

@import Foundation;

@interface NSObject (MBAdditions)

@property (readonly) BOOL isNull;
@property (readonly) BOOL isNumber;
@property (readonly) BOOL isString;
@property (readonly) BOOL isDictionary;
@property (readonly) BOOL isArray;
@property (readonly) BOOL isSet;

@end
