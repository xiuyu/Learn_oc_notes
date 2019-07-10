//
//  Fibo.h
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/2.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Fibo : NSObject
/**
 *  斐波那契数列
 *
 *  @param n 第N个数列
 *  @return n 第N个数列
 */
+ (int)fib1:(int)n;


+ (int)fib2:(int)n;

@end

NS_ASSUME_NONNULL_END
