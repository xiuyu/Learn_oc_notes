//
//  Utils.h
//  mvvm+rac
//
//  Created by xiuyu on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

/**
 *
 * 手机号码是否正确
 *
 */
+(BOOL)verifyPhoneNumber:(NSString *)mobileNum;

@end

NS_ASSUME_NONNULL_END
