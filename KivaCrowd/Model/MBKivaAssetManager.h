//
//  MBKivaAssetManager.h
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MBKivaAssetManagerCompletionBlock)(NSDictionary *dictionary, NSError *error);

@interface MBKivaAssetManager : NSObject

+ (MBKivaAssetManager *)sharedManager;

- (void)releaseVersionWithCompletion:(MBKivaAssetManagerCompletionBlock)completionBlock;

@end
