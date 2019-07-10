//
//  LinkList.m
//  algorithm
//
//  Created by xiuyu on 2019/7/10.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "LinkedList.h"

static const NSInteger ELEMENT_NO_FOND = -1;

@interface Nodes <ObjectType>: NSObject

@property (strong, nonatomic) Nodes *next;

@property (strong, nonatomic) ObjectType element;

@property (strong, nonatomic) Nodes *prev;

@end

@implementation Nodes

- (instancetype)initWithNode:(nullable Nodes *)prev element:(id)element next:(nullable Nodes *)next
{
    if (self = [super init])
    {
        self.prev = prev;
        self.next = next;
        self.element = element;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"_%@_%@_%@", self.prev.element, self.element, self.next.element];
}

- (void)dealloc
{
    NSLog(@"双向链表node delloc");
}

@end

@interface LinkedList ()
{
    Nodes *_first;
    
    Nodes *_last;
    
    NSInteger _size;
}

@end

@implementation LinkedList

- (void)clear
{
    _size = 0;
    _first = nil; //断掉第一根线
    _last = nil;
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
    if (index == _size) //添加最后一个元素
    {
        //index = 0  size = 0
        if (_last == nil)
        {
            _last = [[Nodes alloc] initWithNode:_last element:element next:nil];
            _first = _last;
        }
        else
        {
            _last = [[Nodes alloc] initWithNode:_last element:element next:nil];
            _last.prev.next = _last;
        }
    }
    else
    {
        Nodes *next = [self getNode:index];
        Nodes *prev = next.prev;
        
        Nodes *node = [[Nodes alloc] initWithNode:prev element:element next:next];
        next.prev = node;
        
        if (prev == nil)
        {
            _first = node;
        }
        else
        {
            prev.next = node;
        }
    }
    
    _size++;
}

- (id)get:(NSInteger)index
{
    return [self getNode:index].element;
}

- (id)set:(NSInteger)index element:(id)element
{
    Nodes *node = [self getNode:index];
    
    [self getNode:index].element = element;
    return node.element;
}

- (id)remove:(NSInteger)index
{
    Nodes *node = [self getNode:index];
    Nodes *prev = node.prev;
    Nodes *next = node.next;
    
    if (prev == nil)
    {
        _first = next;
    }
    else
    {
        prev.next = next;
    }
    
    if (next == nil)
    {
        _last = prev;
    }
    else
    {
        next.prev = prev;
    }
    
    _size--;
    return [self getNode:index].element;
}

- (BOOL)contains:(id)element
{
    return [self indexOf:element] != ELEMENT_NO_FOND;
}

- (NSInteger)indexOf:(id)element
{
    Nodes *node = _first;
    
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
- (Nodes *)getNode:(NSInteger)index
{
    if (_size >> 1 <= index)
    {
        Nodes *node = _first;
        
        for (NSInteger i = 0; i < index; i++)
        {
            node = node.next;
        }
        
        return node;
    }
    else
    {
        Nodes *node = _last;
        
        for (NSInteger i = _size - 1; i > index; i--)
        {
            node = node.prev;
        }
        
        return node;
    }
}

- (NSString *)description
{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:10];
    
    [str appendFormat:@"size = %ld ", _size];
    [str appendString:@"["];
    
    Nodes *node = _first;
    
    for (NSInteger i = 0; i < _size; i++)
    {
        if (i != 0)
        {
            [str appendString:@","];
        }
        [str appendFormat:@"%@", node];
        node = node.next;
    }
    
    [str appendString:@"]"];
    return str;
}

@end
