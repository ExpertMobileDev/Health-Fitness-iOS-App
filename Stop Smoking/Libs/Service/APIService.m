//
//  APIService.m
//  SpayceBook
//
//  Created by Dmitry Miller on 7/3/13.
//  Copyright (c) 2013 Spayce Inc. All rights reserved.
//

#import "APIService.h"

// Utility
#import "APIUtils.h"
#import "AFNetworking.h"

@implementation APIService

#pragma mark - Accessors

+ (NSString *)baseUrl {
    return @"http://eden1.goldenxing.com/api/";
}

+ (NSOperationQueue *)apiRequestQueue
{
    static NSOperationQueue *queue = nil;
    
    if (!queue) {
        queue = [[NSOperationQueue alloc] init];
    }
    
    return queue;
}

+ (NSOperationQueue *)assetUploadQueue
{
    static NSOperationQueue *assetQueue = nil;
    
    if (!assetQueue) {
        assetQueue = [[NSOperationQueue alloc] init];
    }
    
    return assetQueue;
}

#pragma mark - Actions

+ (void)makeApiCallWithMethodUrl:(NSString *)methodUrl
                  resultCallback:(void (^)(NSObject * result))resultCallback
                   faultCallback:(void (^)(NSError * fault))faultCallback
{
    [APIService makeApiCallWithMethodUrl:methodUrl
                          andRequestType:RequestTypeGet
                           andPathParams:nil
                          andQueryParams:nil
                          resultCallback:resultCallback
                           faultCallback:faultCallback
                              foreignAPI:NO];
}

+ (void)makeApiCallWithMethodUrl:(NSString *)methodUrl
                  andRequestType:(RequestType)requestType
                   andPathParams:(NSArray *)pathParams
                  andQueryParams:(NSDictionary *)queryParams
                  resultCallback:(void (^)(NSObject * result))resultCallback
                   faultCallback:(void (^)(NSError * fault))faultCallback
{
    [APIService makeApiCallWithMethodUrl:methodUrl
                          andRequestType:requestType
                           andPathParams:pathParams
                          andQueryParams:queryParams
                          resultCallback:resultCallback
                           faultCallback:faultCallback
                              foreignAPI:NO];
}

+ (void)makeApiCallWithMethodUrl:(NSString *)methodUrl
                  andRequestType:(RequestType)requestType
                   andPathParams:(NSArray *)pathParams
                  andQueryParams:(NSDictionary *)queryParams
                  resultCallback:(void (^)(NSObject * result))resultCallback
                   faultCallback:(void (^)(NSError * fault))faultCallback
                      foreignAPI:(BOOL)foreignAPI
{
    
    NSString *fullUrl;
    if (foreignAPI) {
        fullUrl = methodUrl;
    } else {
        fullUrl = [[APIService baseUrl] stringByAppendingString:methodUrl];
    }
    
    NSDictionary *actualQueryParams = queryParams;
    
    APIServiceRequest *request = [[APIServiceRequest alloc] init];
    request.url = fullUrl;
    request.type = requestType;
    request.queryParams = actualQueryParams;
    request.pathParams = pathParams;
    request.timeoutInterval = 60;
    request.resultCallback = resultCallback;
    request.faultCallback = faultCallback;
    request.foreignAPI = foreignAPI;
    
    [request start:[APIService apiRequestQueue]];
}

+ (void)makeMultipartApiCallWithMethodUrl:(NSString *)methodUrl
                  andQueryParams:(NSDictionary *)queryParams
                  resultCallback:(void (^)(NSObject * result))resultCallback
                   faultCallback:(void (^)(NSError * fault))faultCallback {
    
    NSString *fullUrl = [[APIService baseUrl] stringByAppendingString:methodUrl];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:fullUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSString *key in [queryParams allKeys]) {
            NSObject *obj = queryParams[key];
            if ([obj isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:(NSData*)obj name:key fileName:@"video.mp4" mimeType:@"video/mp4"];
            } else if ([obj isKindOfClass:[NSString class]]) {
                NSString *strValue = (NSString*) obj;
                [formData appendPartWithFormData:[strValue dataUsingEncoding:NSUTF8StringEncoding] name:key];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (resultCallback) {
            resultCallback(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (faultCallback) {
            faultCallback(error);
        }
    }];
}
@end
