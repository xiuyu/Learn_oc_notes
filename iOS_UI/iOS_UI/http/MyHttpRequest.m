//
//  MyHttpRequest.m
//  iOS_UI
//
//  Created by xiuyu on 2019/6/24.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "MyHttpRequest.h"
#import <AFHTTPSessionManager.h>

@interface MyHttpRequest ()

@end

@implementation MyHttpRequest

static MyHttpRequest *sharedSingleton = nil;

+ (instancetype)sharedSingleton
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[MyHttpRequest alloc] init];
        [sharedSingleton initProperty];
    });
    
    return sharedSingleton;
}

- (void)initProperty
{
    [self checkNetworkStatus];
}

- (BOOL)checkNetworkStatus
{
    AFNetworkReachabilityManager *reach = [AFNetworkReachabilityManager sharedManager];
    
    [reach startMonitoring];
    
    BOOL isConect = NO;
    
    if (reach.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
    {
        isConect = NO;
    }
    else
    {
        isConect = YES;
    }
    
    return isConect;
}

- (void)requestServer:(NSString *)url
          sendMessage:(id)sendDictionary
               method:(NSString *)method
          withBackFun:(MyHttpRequestSucess)backFun
       withFailureFun:(MyHttpRequestFail)failureFun
{
    
    if (![self checkNetworkStatus]) {
        return;
    }
    
    NSString *urlString = url;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/octet-stream", @"application/json", @"text/json", @"text/plain", @"text/html", nil];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.responseSerializer setValue:@"iOS" forKey:@"Platform"];
    
    if ([method isEqualToString:@"GET"])
    {
        //---------- get ---------//
        [manager GET:urlString parameters:sendDictionary
            progress:nil
             success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                 backFun(task, responseObject);
             } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                 failureFun(task, error);
             }];
    }
    else if ([method isEqualToString:@"POST"])
    {
        //---------- post ---------//
        [manager POST:urlString parameters:sendDictionary
             progress:nil
              success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                  backFun(task, responseObject);
              } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                  failureFun(task, error);
              }];
    }
}

@end
