//
//  Fibo.m
//  algorithm
//
//  Created by 丘秀玉 on 2019/7/2.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "Fibo.h"

@implementation Fibo

+ (int)fib1:(int)n
{
    if (n <= 1)
    {
        return n;
    }
    
    return [self fib1:n - 1] + [self fib1:n - 2];
}


/**         1 2 3 4 5 6 7 8 
 斐波那契数列 1 1 2 3 5 8 13 21
 */
+ (int)fib2:(int)n
{
    if (n <= 1)
    {
        return n;
    }
    
    int first = 0;
    int second = 1;
    
    for (int i = 1; i < n; i++)
    {
        second += first;
        first = second - first;
    }
    
    return second;
}

@end
