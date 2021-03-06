//
//  Request.h
//  mvvm+rac
//
//  Created by xiuyu on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Request : NSObject

/**
 登录

 @param sucess 成功回调
 @param fail 失败回调
 */
+ (void)loginSucess:(void (^)(NSDictionary *))sucess fail:(void (^)(NSDictionary *))fail;

@end

NS_ASSUME_NONNULL_END
