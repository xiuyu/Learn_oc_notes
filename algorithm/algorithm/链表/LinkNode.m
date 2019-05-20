//
//  LinkNode.m
//  algorithm
//
//  Created by xiuyu on 2019/5/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "LinkNode.h"

@interface LinkNode ()
{
    id value;
    LinkNode *next;
}

@end

@implementation LinkNode

+ (instancetype)addNode:(nullable LinkNode *)p value:(id)value
{
    if (p == nil)
    {
        p = [[LinkNode alloc] init];
        p->value = value;
        p->next = nil;
    }
    else
    {
        p->next = [LinkNode addNode:p->next value:value];
    }
    return p;
}

+ (void)traverseList:(LinkNode *)head block:(void (^)(NSInteger))block
{
    if (head->next == nil)
    {
        if (block)
        {
            block([head->value integerValue]);
        }
        return;
    }
    else
    {
        if (block)
        {
            block([head->value integerValue]);
        }
    }
    
    [LinkNode traverseList:head->next block:block];
}

@end
