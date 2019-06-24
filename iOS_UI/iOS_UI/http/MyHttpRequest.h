//
//  MyHttpRequest.h
//  iOS_UI
//
//  Created by xiuyu on 2019/6/24.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MyHttpRequestSucess)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject);
typedef void (^MyHttpRequestFail)(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error);

@interface MyHttpRequest : NSObject

@property (nonatomic, strong) NSString *contentType;

@property (nonatomic, strong) NSString *hostUrl;


+ (instancetype)sharedSingleton;

/**
 初始化
 */
- (void)initProperty;

/**
 *  检测网络
 *
 *  @return 是否有网
 */
- (BOOL)checkNetworkStatus;

/**
 *  请求网络数据
 *
 *  @param url 地址
 *  @param sendDictionary 参数
 *  @param method post get
 *  @param backFun 成功结果回调
 *  @param failureFun 失败结果回调
 */
- (void)requestServer:(NSString *)url
          sendMessage:(id)sendDictionary
               method:(NSString *)method
          withBackFun:(MyHttpRequestSucess)backFun
       withFailureFun:(MyHttpRequestFail)failureFun;

@end

NS_ASSUME_NONNULL_END
