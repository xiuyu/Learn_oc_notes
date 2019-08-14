//
//  BinaryTreeList.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "BinarySortTreeList.h"

@interface BinarySortTreeList ()
{
    TreeNode *_root;
}

@end

@implementation BinarySortTreeList

- (void)addTreeNode:(NSInteger)val
{
    TreeNode *newNode = [[TreeNode alloc] initWithNode:val];
    
    if (_root == nil)
    {
        _root = newNode;
    }
    else
    {
        TreeNode *current = _root;
        TreeNode *parentNode = nil;
        
        while (current != nil) {
            parentNode = current;
            
            //当前值比插入值大，搜索左子节点
            if (current.val > val)
            {
                current = current.leftNode;
                
                if (current == nil)
                {
                    parentNode.leftNode = newNode;
                }
            }
            else
            {
                current = current.rightNode;
                
                if (current == nil)
                {
                    parentNode.rightNode = newNode;
                }
            }
        }
    }
    
}


- (NSInteger)findMin
{
    TreeNode *current = _root;
    
    while (current != nil) {
        TreeNode *parentNode = current;
        
        current = current.leftNode;
        
        if (current == nil)
        {
            return parentNode.val;
        }
    }
    
    return 0;
}

- (NSInteger)findMax
{
    TreeNode *current = _root;
    
    while (current != nil) {
        TreeNode *parentNode = current;
        current = current.rightNode;
        
        if (current == nil)
        {
            return parentNode.val;
        }
    }
    
    return 0;
}

- (void)infixOrder
{
    [self infixOrderWithRoot:_root];
}

- (void)preOrder
{
    [self preOrderWithRoot:_root];
}

- (void)postOrder
{
    [self postOrderWithRoot:_root];
}

- (void)preOrderWithRoot:(TreeNode *)current
{
    if (current != nil)
    {
        NSLog(@"%ld", current.val);
        [self preOrderWithRoot:current.leftNode];
        [self preOrderWithRoot:current.rightNode];
    }
}

- (void)infixOrderWithRoot:(TreeNode *)current
{
    if (current != nil)
    {
        [self infixOrderWithRoot:current.leftNode];
        NSLog(@"%ld", current.val);
        [self infixOrderWithRoot:current.rightNode];
    }
}

- (void)postOrderWithRoot:(TreeNode *)current
{
    if (current != nil)
    {
        [self postOrderWithRoot:current.leftNode];
        
        [self postOrderWithRoot:current.rightNode];
        NSLog(@"%ld", current.val);
    }
}


-(BOOL)deleteTree:(NSInteger)val
{
    TreeNode *current = _root;
    TreeNode *parent = nil; //父节点
    
    BOOL isLeft = NO; //该节点位置左还是右
    
    while (val != current.val) {
        parent = current;
        
        if (val < current.val)
        {
            current = current.leftNode;
            isLeft = YES;
        }
        else
        {
            current = current.rightNode;
            isLeft = NO;
        }
        
        if (current == nil)
        {
            return NO;
        }
    }
    
    if (current.leftNode == nil && current.rightNode == nil)
    {
        if (_root == parent)
        {
            _root = nil;
        }
        
        if (isLeft)
        {
            parent.leftNode = nil;
        }
        else
        {
            parent.rightNode = nil;
        }
    }
    else if (current.leftNode != nil && current.rightNode != nil)
    {
        NSInteger min = [self findMinWith:current.rightNode];
        current.val = min;
    }
    else
    {
        //子节点是在当前节点的子节点是左右边
        if (current.leftNode != nil)
        {
            if (isLeft)
            {
                parent.leftNode = current.leftNode;
            }
            else
            {
                parent.rightNode = current.leftNode;
            }
        }
        else
        {
            if (isLeft)
            {
                parent.leftNode = current.rightNode;
            }
            else
            {
                parent.rightNode = current.rightNode;
            }
        }
    }
    
    return YES;
}

- (NSInteger)findMinWith:(TreeNode *)node
{
    TreeNode *target = node;
    
    while (target.leftNode != nil) {
        target = target.leftNode;
    }
    
    [self deleteTree:target.val];
    return target.val;
}


-(NSInteger)minDiffInBST
{
    
    return 0;
}


@end


