//
//  BinaryTreeList.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "BinaryTreeList.h"

@interface TreeNode <ObjectType>: NSObject

@property (strong, nonatomic) TreeNode *leftNode;

@property (strong, nonatomic) TreeNode *rightNode;

@property (assign, nonatomic) NSInteger val;

@end

@implementation TreeNode

- (instancetype)initWithNode:(NSInteger)val
{
    if (self = [super init])
    {
        self.val = val;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"tree node delloc");
}

@end

@interface BinaryTreeList ()
{
    TreeNode *_root;
}

@end

@implementation BinaryTreeList

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
    
    NSLog(@"%@", _root);
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

@end


