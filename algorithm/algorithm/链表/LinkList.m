//
//  LinkList.m
//  algorithm
//
//  Created by xiuyu on 2019/7/10.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "LinkList.h"

static const NSInteger ELEMENT_NO_FOND = -1;

@interface Node <ObjectType>: NSObject

@property (strong, nonatomic) Node *next;

@property (strong, nonatomic) ObjectType element;

@end

@implementation Node

- (instancetype)initWithNode:(id)element next:(nullable Node *)next
{
    if (self = [super init])
    {
        self.next = next;
        self.element = element;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"单向链表node delloc");
}

@end

@interface LinkList ()
{
    Node *_first;
    
    NSInteger _size;
}

@end

@implementation LinkList

- (void)clear
{
    _size = 0;
    _first = nil; //断掉第一根线
}

- (BOOL)isEmpty
{
    return _size == 0;
}

- (NSInteger)size
{
    return _size;
}

- (void)add:(id)element
{
    [self add:_size element:element];
}

- (void)add:(NSInteger)index element:(id)element
{
    if (index == 0)
    {
        _first = [[Node alloc] initWithNode:element next:nil];
    }
    else
    {
        Node *prev = [self getNode:index - 1];
        Node *node = [[Node alloc] initWithNode:element next:prev.next];
        prev.next = node;
    }
    _size++;
}

- (id)get:(NSInteger)index
{
    return [self getNode:index].element;
}

- (id)set:(NSInteger)index element:(id)element
{
    Node *node = [self getNode:index];
    
    [self getNode:index].element = element;
    return node.element;
}

- (id)remove:(NSInteger)index
{
    Node *node = [self getNode:index];
    
    if (index == 0)
    {
        _first = node.next;
    }
    else
    {
        Node *prev = [self getNode:index - 1];
        prev.next = node.next;
    }
    _size--;
    return node;
}

- (BOOL)contains:(id)element
{
    return [self indexOf:element] != ELEMENT_NO_FOND;
}

- (NSInteger)indexOf:(id)element
{
    Node *node = _first;
    
    for (NSInteger i = 0; i < _size; i++)
    {
        if ([node.element isEqual:element])
        {
            return i;
        }
        node = node.next;
    }
    
    return ELEMENT_NO_FOND;
}

/*返回当前node*/
- (Node *)getNode:(NSInteger)index
{
    Node *node = _first;
    
    for (NSInteger i = 0; i < index; i++)
    {
        node = node.next;
    }
    
    return node;
}

- (void)reverse
{
    if (_first == nil || _first.next == nil)
    {
        return;
    }
    
    Node *newHead = nil;
    
    while (_first != nil) {
        Node *tmp = _first.next;
        _first.next = newHead;
        newHead = _first;
        _first = tmp;
    }
    
    _first = newHead;
}

- (NSString *)description
{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:10];
    
    [str appendFormat:@"size = %ld ", _size];
    [str appendString:@"["];
    
    Node *node = _first;
    
    for (NSInteger i = 0; i < _size; i++)
    {
        if (i != 0)
        {
            [str appendString:@","];
        }
        [str appendFormat:@"%@", node.element];
        node = node.next;
    }
    
    [str appendString:@"]"];
    return str;
}

@end
