//
//  ConcurrentOperation.m
//  thread
//
//  Created by 丘秀玉 on 2020/4/15.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "ConcurrentOperation.h"

typedef NS_ENUM (NSInteger, ConcurrentOperationStats)
{
    ConcurrentOperationReady,
    ConcurrentOperationExcuting,
    ConcurrentOperationFinish
};

@interface ConcurrentOperation ()

@property (assign, nonatomic) ConcurrentOperationStats status;

@end

@implementation ConcurrentOperation

- (BOOL)isReady
{
    return self.status == ConcurrentOperationReady;
}

- (BOOL)isExecuting
{
    return self.status == ConcurrentOperationExcuting;
}

- (BOOL)isFinished
{
    return self.status == ConcurrentOperationFinish;
}

- (void)start
{
    NSLog(@"call");

    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //kvo：结束
        [weakSelf willChangeValueForKey:@"isFinished"];
        weakSelf.status = ConcurrentOperationFinish;
        [weakSelf didChangeValueForKey:@"isFinished"];

        NSLog(@"finished :%@", weakSelf);
    });

    //kvo：正在执行
    [self willChangeValueForKey:@"isExecuting"];
    self.status = ConcurrentOperationExcuting;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)dealloc
{
    NSLog(@"delloc");
}

@end
