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

+(LinkNode *)addNode:(LinkNode *)p value:(id)value
{
    if (p == nil) {
        
        p = [[LinkNode alloc] init];
        p->value = value;
        p->next = nil;
    }else
    {
        p->next = [LinkNode addNode:p->next value:value];
    }
    
    return p;
}

+(void)traverseLink:(LinkNode *)p block:(void (^)(id _Nonnull))block
{
    if (p->next == nil) {
        
        !block?:block(p->value);
        return;
    }else
    {
        !block?:block(p->value);
    }
    
    [LinkNode traverseLink:p->next block:block];
}

@end
