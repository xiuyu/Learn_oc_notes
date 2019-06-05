//
//  BinaryTreeNode.h
//  algorithm
//
//  Created by 丘秀玉 on 2019/5/31.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreeNode : NSObject
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) BinaryTreeNode *leftNode;
@property (nonatomic, strong) BinaryTreeNode *rightNode;


//创建二叉树
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values;
//二叉树中某个位置的节点（按层次遍历）
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode;
//向二叉排序树节点添加一个节点
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value;
//翻转二叉树
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode;
// 非递归方式翻转
+ (BinaryTreeNode *)invertBinaryTreeNot:(BinaryTreeNode *)rootNode;
//先序遍历：先访问根，再遍历左子树，再遍历右子树。典型的递归思想。
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;
//中序遍历:先遍历左子树，再访问根，再遍历右子树
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;
//后序遍历:先遍历左子树，再遍历右子树，再访问根
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;
//层次遍历（广度优先)
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;
//二叉树的宽度
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode;
//二叉树的所有节点数
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode;
//二叉树某层中的节点数
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode;
//二叉树叶子节点数
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode;
//二叉树最大距离（直径）
+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode;


@end

NS_ASSUME_NONNULL_END
