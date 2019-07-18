//
//  BinaryTreeList.h
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinarySortTreeList : NSObject

/**
 *  二叉排序树添加
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


/**
 * 删除节点
 * 一、删除节点没有子节点
 * 1.找到改节点；
 * 2.找到改节点的父节点，让父节点的左或右子树致空；
 * <p>
 * 二、删除节点有一个子节点
 * 1.找到改节点；
 * 2.找到父节点，判断要删除的节点是在父节点的左边还是右边；
 * 3.然后让父节点的左右节点等于删除节点的左右节点；
 * <p>
 * 三、删除的节点有左右子节点
 * 1.找到改节点；
 * 2.找到改节点左边最小的后继节点，然后删除该节点；
 * 3.让要删除的节点等于找到的最小的节点；
 *
 @param val 删除值
 @return 是否删除成功
 */
-(BOOL)deleteTree:(NSInteger)val;



@end

NS_ASSUME_NONNULL_END
