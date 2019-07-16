//
//  LinkNode.h
//  algorithm
//
//  Created by xiuyu on 2019/5/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListNode : NSObject

/**
 *  增加节点
 *
 *  @param p 节点
 *  @param value 值
 */
+ (ListNode *)addNode:(nullable ListNode *)p value:(id)value;


/**
 *  遍历单链表
 *
 *  @param p 节点
 *  @param block 回调
 */
+(void)traverseLink:(ListNode *)p block:(void (^)(id value))block;



/**
 链表反转

 @param head 头结点
 */
+ (ListNode *)reverse:(ListNode *)head;



/**
 链表反转
 
 @param head 头结点
 */
+ (ListNode *)reverse2:(ListNode *)head;

@end

NS_ASSUME_NONNULL_END
