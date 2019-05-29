//
//  LoginModel.h
//  mvvm+rac
//
//  Created by xiuyu on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject

@property (assign,nonatomic) NSInteger code;

@property (copy,nonatomic) NSString *message;

@end

NS_ASSUME_NONNULL_END
