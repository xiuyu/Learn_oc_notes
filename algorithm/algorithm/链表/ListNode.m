//
//  LinkNode.m
//  algorithm
//
//  Created by xiuyu on 2019/5/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ListNode.h"

@interface ListNode ()
{
    id value;
    ListNode *next;
}

@end

@implementation ListNode

+ (ListNode *)addNode:(ListNode *)p value:(id)value
{
    if (p == nil)
    {
        p = [[ListNode alloc] init];
        p->value = value;
        p->next = nil;
    }
    else
    {
        p->next = [ListNode addNode:p->next value:value];
    }
    
    return p;
}

+ (void)traverseLink:(ListNode *)p block:(void (^)(id _Nonnull))block
{
    if (p->next == nil)
    {
        !block ? : block(p->value);
        return;
    }
    else
    {
        !block ? : block(p->value);
    }
    
    [ListNode traverseLink:p->next block:block];
}

//1,2,3,4,
+ (ListNode *)reverse:(ListNode *)head
{
    if (head == nil || head->next == nil)
    {
        return head;
    }
    
    ListNode *newHead = [self reverse:head->next];
    
    head->next->next = head;
    head->next = nil;
    
    return newHead;
}

+ (ListNode *)reverse2:(ListNode *)head
{
    if (head == nil || head->next == nil)
    {
        return head;
    }
    
    ListNode *newHead = nil;
    
    while (head != nil) {
        ListNode *tmp = head->next;
        head->next = newHead;
        newHead = head;
        head = tmp;
    }
    
    return newHead;
}

@end
