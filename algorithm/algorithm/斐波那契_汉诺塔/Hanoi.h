//
//  Hanoi.h
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/11.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hanoi : NSObject


/**
 斐波那契数列

 @param n 第N项
 @return 第N项数列
 */
+ (NSInteger)fibRecursive:(NSInteger)n;

+ (NSInteger)fib:(NSInteger)n;

/**
 * 思路：无论有多少个盘子，都以为只有二个盘子，上面的所有盘子和最下面的那个盘子
 *
 * @param n    有N个盘子
 * @param from 开始柱子
 * @param mid   中间柱子
 * @param to   目标柱子
 */
+ (void)hanoi:(NSInteger)n form:(char)from mid:(char)mid to:(char)to;

@end

NS_ASSUME_NONNULL_END
