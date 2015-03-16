//
//  MBKivaAssetFetcher.h
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

@import Foundation;

typedef void(^MBKivaAssetFetcherCompletionBlock)(NSDictionary *dictionary, NSError *error);

@interface MBKivaAssetFetcher : NSObject

- (void)requestAPIReleaseVersionWithCompletion:(MBKivaAssetFetcherCompletionBlock)completionBlock;

@end
