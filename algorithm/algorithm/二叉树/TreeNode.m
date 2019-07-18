//
//  TreeNode.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "TreeNode.h"

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
