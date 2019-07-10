//
//  LinkList.h
//  单向链表
//
//  Created by xiuyu on 2019/7/10.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface LinkList<__covariant ObjectType>: NSObject

/**
 * 链表清空数组
 */
- (void)clear;

/**
 * 链表获取数组长度
 */
- (NSInteger)size;

/**
 * 链表是否空
 */
- (BOOL)isEmpty;

/**
 *  链表是否包含元素
 *
 *  @param element value
 *  @return bool
 */
- (BOOL)contains:(ObjectType)element;

/**
 *  获取链表index位置元素
 *
 *  @param index 位置
 *  @return value
 */
- (ObjectType)get:(NSInteger)index;

/**
 *  赋值index位置的元素
 *
 *  @param index 位置
 *  @param element value
 *  @return 旧value
 */
- (ObjectType)set:(NSInteger)index element:(ObjectType)element;

/**
 *  往size位置添加元素
 *
 *  @param element value
 */
- (void)add:(ObjectType)element;

/**
 *  添加元素
 *
 *  @param index 位置
 *  @param element value
 */
- (void)add:(NSInteger)index element:(ObjectType)element;

/**
 *  移除元素
 *
 *  @param index 位置
 *  @return 移除value
 */
- (id)remove:(NSInteger)index;

/**
 *  查找
 *
 *  @param element value
 *  @return index
 */
- (NSInteger)indexOf:(ObjectType)element;

@end

NS_ASSUME_NONNULL_END
