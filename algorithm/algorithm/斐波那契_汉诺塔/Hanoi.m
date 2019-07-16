//
//  Hanoi.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/11.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "Hanoi.h"

@implementation Hanoi

+ (NSInteger)fibRecursive:(NSInteger)n
{
    if (n <= 1)
    {
        return n;
    }
    
    return [self fibRecursive:n - 1] + [self fibRecursive:n - 2];
}

+ (NSInteger)fib:(NSInteger)n
{
    if (n <= 1)
    {
        return n;
    }
    else
    {
        NSInteger first = 0;
        NSInteger second = 1;
        
        for (NSInteger i = 1; i < n; i++)
        {
            second += first;
            first = second - first;
        }
        
        return second;
    }
}

+ (void)hanoi:(NSInteger)n form:(char)from mid:(char)mid to:(char)to
{
    if (n <= 1)
    {
        NSString *str = [NSString stringWithFormat:@"第%ld盘子从%c移到%c", n, from, to];
        NSLog(@"%@", str);
    }
    else
    {
        //移动上面的柱子到中间位置
        [self hanoi:n - 1 form:from mid:to to:mid];
        //移动最后一个盘子
        NSString *str = [NSString stringWithFormat:@"第%ld盘子从%c移到%c", n, from, to];
        NSLog(@"%@", str);
        
        //中间位置的盘子移动到目标柱子
        [self hanoi:n - 1 form:mid mid:from to:to];
    }
}

@end
