//
//  BinaryTreeList.h
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreeList : NSObject

/**
 *  二叉树添加
 *
 *  @param val value
 */
- (void)addTreeNode:(NSInteger)val;

/**
 *  前序遍历
 */
- (void)preOrder;

/**
 *  中序遍历
 */
- (void)infixOrder;

/**
 *  后续遍历
 */
- (void)postOrder;


/**
 找到最大值
 
 @return 最大值
 */
- (NSInteger)findMin;
/**
 找到最大值
 
 @return 最大值
 */
- (NSInteger)findMax;

@end

NS_ASSUME_NONNULL_END
