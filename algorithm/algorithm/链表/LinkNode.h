//
//  LinkNode.h
//  algorithm
//
//  Created by xiuyu on 2019/5/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkNode : NSObject

/**
 *  增加节点
 *
 *  @param p 节点
 *  @param value 值
 */
+ (instancetype)addNode:(nullable LinkNode *)p value:(id)value;

/**
 *  遍历单链表
 *
 *  @param head 节点
 *  @param block 回调
 */
+ (void)traverseList:(LinkNode *)head block:(void (^)(NSInteger value))block;

@end

NS_ASSUME_NONNULL_END
