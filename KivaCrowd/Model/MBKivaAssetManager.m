//
//  MBKivaAssetManager.m
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

#import "MBKivaAssetManager.h"
#import "MBKivaAssetFetcher.h"

@interface MBKivaAssetManager ()

@property (nonatomic) MBKivaAssetFetcher *fetcher;

@end

@implementation MBKivaAssetManager

+ (MBKivaAssetManager *)sharedManager {
    static MBKivaAssetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MBKivaAssetManager alloc] init];
        manager.fetcher = [[MBKivaAssetFetcher alloc] init];
    });
    
    return manager;
}

- (void)releaseVersionWithCompletion:(MBKivaAssetManagerCompletionBlock)completionBlock {
    [self.fetcher requestAPIReleaseVersionWithCompletion:completionBlock];
}

@end
