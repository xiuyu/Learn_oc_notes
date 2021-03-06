//
//  BinaryTreeViewController.m
//  algorithm
//
//  Created by xiuyu on 2019/5/31.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "BinaryTreeViewController.h"
#import "BinaryTreeNode.h"
#import "BinarySortTreeList.h"

@interface BinaryTreeViewController ()

@end

@implementation BinaryTreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
//    NSArray *arr = [NSArray arrayWithObjects:@(7), @(6), @(3), @(2), @(1), @(9), @(10), @(12), @(14), @(4), @(14), nil];
//    BinaryTreeNode *tree = [BinaryTreeNode new];
//    tree = [BinaryTreeNode createTreeWithValues:arr];
//
//    NSMutableArray *orderArray = [NSMutableArray array];
//    [BinaryTreeNode preOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray addObject:@(treeNode.value)];
//    }];
//    NSLog(@"先序遍历结果：%@", [orderArray componentsJoinedByString:@","]);
//
//    NSMutableArray *orderArray1 = [NSMutableArray array];
//    [BinaryTreeNode inOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray1 addObject:@(treeNode.value)];
//    }];
//    NSLog(@"中序遍历结果：%@", [orderArray1 componentsJoinedByString:@","]);
//
//    NSMutableArray *orderArray2 = [NSMutableArray array];
//    [BinaryTreeNode postOrderTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray2 addObject:@(treeNode.value)];
//    }];
//    NSLog(@"后序遍历结果：%@", [orderArray2 componentsJoinedByString:@","]);
//
//    NSMutableArray *orderArray3 = [NSMutableArray array];
//    [BinaryTreeNode levelTraverseTree:tree handler:^(BinaryTreeNode *treeNode) {
//        [orderArray3 addObject:@(treeNode.value)];
//    }];
//    NSLog(@"层次遍历结果：%@", [orderArray3 componentsJoinedByString:@","]);
    
    [self list];
}

- (void)list
{
    BinarySortTreeList *l = [[BinarySortTreeList alloc] init];
    
    [l addTreeNode:7];
    [l addTreeNode:3];
    [l addTreeNode:4];
    [l addTreeNode:10];
    [l addTreeNode:1];
   
    
    [l deleteTree:3];
    [l preOrder];
}

@end
