//
//  BinaryTreeNode.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/5/31.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode

/**
 *  创建二叉排序树
 *  二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
 *
 *  @param values 数组
 *
 *  @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values
{
    BinaryTreeNode *root = nil;
    
    for (NSInteger i = 0; i < values.count; i++)
    {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [BinaryTreeNode addTreeNode:root value:value];
    }
    
    return root;
}

/**
 *  向二叉排序树节点添加一个节点
 *
 *  @param treeNode 根节点
 *  @param value    值
 *
 *  @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value
{
    //根节点不存在，创建节点
    if (!treeNode)
    {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
        NSLog(@"node:%@", @(value));
    }
    else if (value <= treeNode.value)
    {
        NSLog(@"to left");
        //值小于根节点，则插入到左子树
        treeNode.leftNode = [BinaryTreeNode addTreeNode:treeNode.leftNode value:value];
    }
    else
    {
        NSLog(@"to right");
        //值大于根节点，则插入到右子树
        treeNode.rightNode = [BinaryTreeNode addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

/**
 * 翻转二叉树（又叫：二叉树的镜像）
 *
 * @param rootNode 根节点
 *
 * @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode)
    {
        return nil;
    }
    
    if (!rootNode.leftNode && !rootNode.rightNode)
    {
        return rootNode;
    }
    [BinaryTreeNode invertBinaryTree:rootNode.leftNode];
    [BinaryTreeNode invertBinaryTree:rootNode.rightNode];
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    return rootNode;
}

/**
 *    非递归方式翻转
 */
+ (BinaryTreeNode *)invertBinaryTreeNot:(BinaryTreeNode *)rootNode
{
    if (!rootNode)
    {
        return nil;
    }
    
    if (!rootNode.leftNode && !rootNode.rightNode)
    {
        return rootNode;
    }
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode];                     //压入根节点
    
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        
        BinaryTreeNode *pLeft = node.leftNode;
        node.leftNode = node.rightNode;
        node.rightNode = pLeft;
        
        if (node.leftNode)
        {
            [queueArray addObject:node.leftNode];
        }
        
        if (node.rightNode)
        {
            [queueArray addObject:node.rightNode];
        }
    }
    
    return rootNode;
}

/**
 *  二叉树中某个位置的节点（按层次遍历）
 *
 *  @param index    按层次遍历树时的位置(从0开始算)
 *  @param rootNode 树根节点
 *
 *  @return 节点
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode
{
    //按层次遍历
    if (!rootNode || index < 0)
    {
        return nil;
    }
    //数组当成队列
    NSMutableArray *queueArray = [NSMutableArray array];
    //压入根节点
    [queueArray addObject:rootNode];
    
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        
        if (index == 0)
        {
            return node;
        }
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        //移除节点，index减少
        index--;
        
        if (node.leftNode)
        {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        
        if (node.rightNode)
        {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    }
    
    //层次遍历完，仍然没有找到位置，返回nil
    return nil;
}

/**
 *  先序遍历：先访问根，再遍历左子树，再遍历右子树。典型的递归思想。
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))handler
{
    if (rootNode)
    {
        if (handler)
        {
            handler(rootNode);
        }
        
        [BinaryTreeNode preOrderTraverseTree:rootNode.leftNode handler:handler];
        [BinaryTreeNode preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 *  中序遍历
 *  先遍历左子树，再访问根，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^)  (BinaryTreeNode *treeNode))handler
{
    if (rootNode)
    {
        [BinaryTreeNode inOrderTraverseTree:rootNode.leftNode handler:handler];
        
        if (handler)
        {
            handler(rootNode);
        }
        
        [BinaryTreeNode inOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

/**
 *  后序遍历
 *  先遍历左子树，再遍历右子树，再访问根
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))handler
{
    if (rootNode)
    {
        [BinaryTreeNode postOrderTraverseTree:rootNode.leftNode handler:handler];
        [BinaryTreeNode postOrderTraverseTree:rootNode.rightNode handler:handler];
        
        if (handler)
        {
            handler(rootNode);
        }
    }
}

/**
 *  层次遍历（广度优先）
 *
 *  @param rootNode 二叉树根节点
 *  @param handler  访问节点处理函数
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void (^)(BinaryTreeNode *treeNode))handler
{
    if (!rootNode)
    {
        return;
    }
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode];                     //压入根节点
    
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        
        if (handler)
        {
            handler(node);
        }
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先 出原则
        
        if (node.leftNode)
        {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        
        if (node.rightNode)
        {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    }
}

/**
 *  二叉树的深度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode)
    {
        return 0;
    }
    
    if (!rootNode.leftNode && !rootNode.rightNode)
    {
        return 1;
    }
    
    //左子树深度
    NSInteger leftDepth = [BinaryTreeNode depthOfTree:rootNode.leftNode];
    //右子树深度
    NSInteger rightDepth = [BinaryTreeNode depthOfTree:rootNode.rightNode];
    
    return MAX(leftDepth, rightDepth) + 1;
}

/**
 *  二叉树的宽度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树宽度
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode)
    {
        return 0;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode];                     //压入根节点
    NSInteger maxWidth = 1;                              //最大的宽度，初始化为1（因为已经有根节点）
    NSInteger curWidth = 0;                              //当前层的宽度
    
    while (queueArray.count > 0) {
        curWidth = queueArray.count;
        
        //依次弹出当前层的节点
        for (NSInteger i = 0; i < curWidth; i++)
        {
            BinaryTreeNode *node = [queueArray firstObject];
            [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
            
            //压入子节点
            if (node.leftNode)
            {
                [queueArray addObject:node.leftNode];
            }
            
            if (node.rightNode)
            {
                [queueArray addObject:node.rightNode];
            }
        }
        
        //宽度 = 当前层节点数
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    
    return maxWidth;
}

/**
 *  二叉树的所有节点数
 *
 *  @param rootNode 根节点
 *
 *  @return 所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode)
    {
        return 0;
    }
    //节点数=左子树节点数+右子树节点数+1（根节点）
    return [BinaryTreeNode numberOfNodesInTree:rootNode.leftNode] + [BinaryTreeNode numberOfNodesInTree:rootNode.rightNode] + 1;
}

/**
 *  二叉树某层中的节点数
 *
 *  @param level    层
 *  @param rootNode 根节点
 *
 *  @return 层中的节点数
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode || level < 1) //根节点不存在或者level<0
    {
        return 0;
    }
    
    if (level == 1) //level=1，返回1（根节点）
    {
        return 1;
    }
    //递归：level层节点数 = 左子树level-1层节点数+右子树level-1层节点数
    return [BinaryTreeNode numberOfNodesOnLevel:level - 1 inTree:rootNode.leftNode] + [BinaryTreeNode numberOfNodesOnLevel:level - 1 inTree:rootNode.rightNode];
}

/**
 *  二叉树叶子节点数
 *
 *  @param rootNode 根节点
 *
 *  @return 叶子节点数
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode)
    {
        return 0;
    }
    
    //左子树和右子树都是空，说明是叶子节点
    if (!rootNode.leftNode && !rootNode.rightNode)
    {
        return 1;
    }
    //递归：叶子数 = 左子树叶子数 + 右子树叶子数
    return [BinaryTreeNode numberOfLeafsInTree:rootNode.leftNode] + [BinaryTreeNode numberOfLeafsInTree:rootNode.rightNode];
}

/**
 *  二叉树最大距离（直径）
 *
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */
+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode)
    {
        return 0;
    }
    //    方案一：（递归次数较多，效率较低）
    //分3种情况：
    //1、最远距离经过根节点：距离 = 左子树深度 + 右子树深度
    NSInteger distance = [BinaryTreeNode depthOfTree:rootNode.leftNode] + [BinaryTreeNode depthOfTree:rootNode.rightNode];
    //2、最远距离在根节点左子树上，即计算左子树最远距离
    NSInteger disLeft = [BinaryTreeNode maxDistanceOfTree:rootNode.leftNode];
    //3、最远距离在根节点右子树上，即计算右子树最远距离
    NSInteger disRight = [BinaryTreeNode maxDistanceOfTree:rootNode.rightNode];
    
    return MAX(MAX(disLeft, disRight), distance);
}

@end
