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
 * 手机号码是否正确
 */
+ (BOOL)verifyPhoneNumber:(NSString *)mobileNum;

/**
 *
 *  验证身份证号码是否正确的方法
 *  @param idNum 传进身份证号码字符串
 *  @return 返回YES或NO表示该身份证号码是否符合国家标准
 *
 */
+ (BOOL)verifyIdentifyCard:(NSString *)idNum;

/**
 *  正则匹配用户密码6-18位数字和字母组合
 *  @param pwd 传入需要检测的字符串
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)verifyPasswordQualified:(NSString *)pwd;

/**
 *  正则匹配用户密码0-6位数字组合
 *  @param pwd 传入需要检测的字符串
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)verifyPaypwdQualified:(NSString *)pwd;

@end

NS_ASSUME_NONNULL_END
