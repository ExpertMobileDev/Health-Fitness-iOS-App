//
//  APIServiceRequest.m
//  SpayceBook
//
//  Created by Dmitry Miller on 7/3/13.
//  Copyright (c) 2013 Spayce Inc. All rights reserved.
//

#import "APIServiceRequest.h"

// Utility
#import "APIService.h"
#import "APIUtils.h"

@implementation APIServiceRequest

NSString * APIServiceRequestDidStartNotification = @"APIServiceRequestDidStart";
NSString * APIServiceRequestDidEndNotification   = @"APIServiceRequestDidEnd";

- (id)init
{
    self = [super init];

    if (self != nil)
    {
        initiated = NO;
        self.timeoutInterval = 40;
    }

    return self;
}

- (NSURLRequest *)buildRequest {
    NSAssert(!initiated, @"Cannot initiate a request that is already active");
    initiated = YES;

    NSMutableString * fullUrl = [[NSMutableString alloc] initWithString:self.url];

    if (self.pathParams.count > 0)
    {
        [fullUrl appendString:@"/"];
        [fullUrl appendString:[self listFromCollection:self.pathParams withSeparator:@"/"]];
    }

    if (self.type == RequestTypeGet || self.type == RequestTypeDelete) //|| (self.type == RequestTypePost && nil != self.queryParams))
    {
        NSString * queryString = [APIUtils queryStringForParams:self.queryParams];

        if(queryString.length > 0)
        {
            [fullUrl appendString:@"?"];
            [fullUrl appendString:queryString];
        }
    }

    NSLog(@"Call API - %@", fullUrl);

    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:fullUrl]
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                        timeoutInterval:self.timeoutInterval];

    if (self.type == RequestTypeGet)
    {
        req.HTTPMethod = @"GET";
    }
    else if (self.type == RequestTypePost || self.type == RequestTypeJSON)
    {
        req.HTTPMethod = @"POST";
    }
    else if (self.type == RequestTypePut)
    {
        req.HTTPMethod = @"PUT";
    }
    else if (self.type == RequestTypeDelete)
    {
        req.HTTPMethod = @"DELETE";
    }

    if (self.type == RequestTypeJSON) {
        NSData *queryData = [NSJSONSerialization dataWithJSONObject:self.queryParams options:kNilOptions error:nil];
        NSString *queryStr = [[NSString alloc] initWithData:queryData encoding:NSASCIIStringEncoding];
        req.HTTPBody = [queryStr dataUsingEncoding:NSUTF8StringEncoding];
        
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    } else if (self.type != RequestTypeGet)
    {
        NSString *queryStr = [APIUtils queryStringForParams:self.queryParams];
        req.HTTPBody = [queryStr dataUsingEncoding:NSUTF8StringEncoding];
    }

    return req;
}

-(NSString *) listFromCollection:(NSArray *)collection withSeparator:(NSString *) separator
{
    NSMutableString * res = [[NSMutableString alloc] init];
    
    BOOL isFirstItem = YES;
    for(NSObject * item in collection)
    {
        if(isFirstItem)
        {
            isFirstItem = NO;
        }
        else
        {
            [res appendString:separator];
        }
        
        if([item isKindOfClass:[NSString class]])
        {
            [res appendString:(NSString *)item];
        }
        else
        {
            [res appendString:[item description]];
        }
    }
    
    return res;
}


- (void)start:(NSOperationQueue *)operationQueue
{
    NSURLRequest *req = [self buildRequest];

    [[NSNotificationCenter defaultCenter] postNotificationName:APIServiceRequestDidStartNotification object:self];

    __weak typeof(self)weakSelf = self;

    [NSURLConnection sendAsynchronousRequest:req
                                       queue:operationQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *fault)
                                {
                                    [[NSNotificationCenter defaultCenter] postNotificationName:APIServiceRequestDidEndNotification object:self];

                                    __strong typeof(weakSelf)strongSelf = weakSelf;
                                    if (!strongSelf) {
                                        return;
                                    }

                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        if(fault != nil)
                                        {
                                            if (strongSelf.faultCallback) {
                                                strongSelf.faultCallback(fault);
                                            }
                                        }
                                        else if (data != nil)
                                        {
                                            NSError *parseError = nil;
                                            
//                                            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);

                                            NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                                                           options:kNilOptions
                                                                                                             error:&parseError];

                                            if (parseError != nil)
                                            {
                                                if (strongSelf.faultCallback) {
                                                    strongSelf.faultCallback(parseError);
                                                }
                                            }
                                            else
                                            {
                                                if (strongSelf.resultCallback) {
                                                    strongSelf.resultCallback(parsedResponse);
                                                }
                                            }
                                        }
                                    });
                                }
     ];
}

- (NSError *)generalErrorWithCode:(NSNumber *)code title:(NSString *)title description:(NSString *)description {
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    if (title != nil) {
        userInfo[@"title"] = title;
    }
    if (description != nil) {
        userInfo[@"description"] = description;
    }
    
    return [NSError errorWithDomain:@"GeneralError"
                               code:[code integerValue]
                           userInfo:userInfo];
}

- (NSError *)generalErrorWithCode:(NSNumber *)code {
    return [self generalErrorWithCode:code title:nil description:nil];
}



@end
