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
+ (LinkNode *)addNode:(nullable LinkNode *)p value:(id)value;


/**
 *  遍历单链表
 *
 *  @param p 节点
 *  @param block 回调
 */
+(void)traverseLink:(LinkNode *)p block:(void (^)(id value))block;
@end

NS_ASSUME_NONNULL_END
