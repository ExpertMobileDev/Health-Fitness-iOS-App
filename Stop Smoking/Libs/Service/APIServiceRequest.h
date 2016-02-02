//
//  APIServiceRequest.h
//  SpayceBook
//
//  Created by Dmitry Miller on 7/3/13.
//  Copyright (c) 2013 Spayce Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * APIServiceRequestDidStartNotification;
extern NSString * APIServiceRequestDidEndNotification;

typedef NS_ENUM(NSInteger, RequestType)
{
    RequestTypeGet,
    RequestTypePost,
    RequestTypeJSON,
    RequestMultipart,
    RequestTypePut,
    RequestTypeDelete
};

@interface APIServiceRequest : NSObject
{
    BOOL initiated;
}

@property (nonatomic, assign) RequestType type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSArray *pathParams;
@property (nonatomic, strong) NSDictionary *queryParams;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) BOOL foreignAPI;
@property (nonatomic, copy) void (^resultCallback)(NSObject *result);
@property (nonatomic, copy) void (^faultCallback)(NSError *fault);

- (void)start:(NSOperationQueue *)operationQueue;

@end
