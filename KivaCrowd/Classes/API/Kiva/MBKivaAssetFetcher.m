//
//  MBKivaAssetFetcher.m
//  KivaCrowd
//
//  Created by Mark Keefe on 3/15/15.
//  Copyright (c) 2015 Maynebridge, Inc. All rights reserved.
//

#import "MBKivaAssetFetcher.h"
#import "MBKivaConstants.h"
#import "MBNetworkReachability.h"
#import "NSObject+MBAdditions.h"

static NSString * const MBKivaAssetFetcherAPIScheme = @"http";
static NSString * const MBKivaAssetFetcherAPIVersion = @"v1";
static NSString * const MBKivaAssetFetcherAPIEndpointRelease = @"releases/api/current";
static NSString * const MBKivaAssetFetcherAPIFileType = @"json";

@interface MBKivaAssetFetcher ()

@property (nonatomic) NSURLSession *session;

@end


@implementation MBKivaAssetFetcher

#pragma mark - Class Interface

- (void)requestAPIReleaseVersionWithCompletion:(MBKivaAssetFetcherCompletionBlock)completionBlock {
    NSURLRequest *URLRequest = [self URLRequestForAPIReleaseVersion];
    
    if (!URLRequest) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey :@"Unable to generate URLRequest for asset"};
        NSError *URLRequestError = [NSError errorWithDomain:NSStringFromClass([self class])
                                                       code:0
                                                   userInfo:userInfo];
        [self runCompletionBlock:completionBlock withResult:nil error:URLRequestError];
        return;
    }
    
    [self requestAssetUsingURLRequest:URLRequest completionBlock:completionBlock];
}

#pragma mark - URLRequests

- (NSURLRequest *)URLRequestForAPIReleaseVersion {
    
    NSString *fullEndpoint = [NSString stringWithFormat:@"/%@/%@.%@", MBKivaAssetFetcherAPIVersion, MBKivaAssetFetcherAPIEndpointRelease, MBKivaAssetFetcherAPIFileType];
    NSURL *URL = [[NSURL alloc] initWithScheme:MBKivaAssetFetcherAPIScheme host:MBKivaConstantsAPIHost path:fullEndpoint];
    
    if (!URL) {
        return nil;
    }

    return [NSURLRequest requestWithURL:URL];
}

#pragma mark - Helper methods

- (void)requestAssetUsingURLRequest:(NSURLRequest *)URLRequest completionBlock:(MBKivaAssetFetcherCompletionBlock)completionBlock {
    
    if (completionBlock == NULL) {
        return;
    }
    
    if (![[MBNetworkReachability sharedKivaHostReachability] isReachable]) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey :@"Unable to fetch data assets from Kiva because we are not connected to the internet"};
        NSError *networkNotReachableError = [NSError errorWithDomain:NSStringFromClass([self class])
                                                                code:0
                                                            userInfo:userInfo];
        [self runCompletionBlock:completionBlock withResult:nil error:networkNotReachableError];
        return;
    }
    
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.session = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    
    NSURLSessionTask *task = [_session dataTaskWithRequest:URLRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"An error occurred while attempting to fetch data assets from Kiva %@", error);
            
            [self runCompletionBlock:completionBlock withResult:nil error:error];
            return;
        }
        
        NSError *unexpectedDataError;
        if (!data) {
            unexpectedDataError = [NSError errorWithDomain:NSStringFromClass([self class])
                                                      code:0
                                                  userInfo:@{NSLocalizedDescriptionKey :@"The attempt to fetch assets from Kiva did not return any data."}];
            [self runCompletionBlock:completionBlock withResult:nil error:unexpectedDataError];
            return;
        }
        
        NSError *JSONParsingError;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingAllowFragments
                                                                             error:&JSONParsingError];
        if (![responseDictionary isDictionary] || JSONParsingError) {
            
            if (JSONParsingError && !responseDictionary) {
                // We did not get JSON back.
                
                [self runCompletionBlock:completionBlock withResult:nil error:JSONParsingError];
                return;
            }
            else {
                NSLog(@"Error parsing raw JSON response data from URLConnection: %@", JSONParsingError);
                
                [self runCompletionBlock:completionBlock withResult:nil error:JSONParsingError];
                return;
            }
        }
        
        [self runCompletionBlock:completionBlock withResult:responseDictionary];
        
    }];
    
    [task resume];
}

#pragma mark - Completion handling

- (void)runCompletionBlock:(MBKivaAssetFetcherCompletionBlock)completionBlock withResult:(NSDictionary *)dictionary {
    [self runCompletionBlock:completionBlock withResult:dictionary error:nil];
}

- (void)runCompletionBlock:(MBKivaAssetFetcherCompletionBlock)completionBlock withResult:(NSDictionary *)dictionary error:(NSError *)error {
    if (completionBlock) {
        completionBlock(dictionary, error);
    }
}

@end
