//
//  NonConcurrentOperation.m
//  thread
//
//  Created by 丘秀玉 on 2020/4/15.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "NonConcurrentOperation.h"

@implementation NonConcurrentOperation

- (void)main
{
    NSLog(@"call");

    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@", weakSelf);
    });
}

- (void)dealloc
{
    NSLog(@"delloc");
}

@end
