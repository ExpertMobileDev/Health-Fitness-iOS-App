//
//  APIService.h
//  SpayceBook
//
//  Created by Dmitry Miller on 7/3/13.
//  Copyright (c) 2013 Spayce Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIServiceRequest.h"

@interface APIService : NSObject

+ (NSString *)baseUrl;
+ (NSOperationQueue *)apiRequestQueue;
+ (NSOperationQueue *)assetUploadQueue;

+ (void)makeApiCallWithMethodUrl:(NSString *)methodUrl
                  resultCallback:(void (^)(NSObject * result))resultCallback
                   faultCallback:(void (^)(NSError * fault))faultCallback;

+ (void)makeApiCallWithMethodUrl:(NSString *)methodUrl
                  andRequestType:(RequestType)requestType
                   andPathParams:(NSArray *)pathParams
                  andQueryParams:(NSDictionary *)queryParams
                  resultCallback:(void (^)(NSObject * result))resultCallback
                   faultCallback:(void (^)(NSError * fault))faultCallback;

+ (void)makeApiCallWithMethodUrl:(NSString *)methodUrl
                  andRequestType:(RequestType)requestType
                   andPathParams:(NSArray *)pathParams
                  andQueryParams:(NSDictionary *)queryParams
                  resultCallback:(void (^)(NSObject * result))resultCallback
                   faultCallback:(void (^)(NSError * fault))faultCallback
                      foreignAPI:(BOOL)foreignAPI;

+ (void)makeMultipartApiCallWithMethodUrl:(NSString *)methodUrl
                           andQueryParams:(NSDictionary *)queryParams
                           resultCallback:(void (^)(NSObject * result))resultCallback
                            faultCallback:(void (^)(NSError * fault))faultCallback;

@end
