//
//  BarrierViewController.m
//  Thread
//
//  Created by xiuyu on 2019/4/22.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "BarrierViewController.h"

@interface BarrierViewController ()
{
    dispatch_queue_t queue;
}

@property (copy, nonatomic) NSString *name;

@end

static NSString *_name;

@implementation BarrierViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    queue = dispatch_queue_create("changeName", DISPATCH_QUEUE_CONCURRENT);

    [self barrier];
}

//在写的过程中不能被读，以免数据不对
- (void)setName:(NSString *)name
{
    dispatch_barrier_async(queue, ^{
        _name = name;
    });
}

- (NSString *)name
{
    __block NSString *tempName;

    dispatch_sync(queue, ^{
        tempName = _name;
    });
    return tempName;
}

/**
 *  在使用栅栏函数时.使用自定义队列才有意义,
 *  如果用的是串行队列或者系统提供的全局并发队列,
 *  这个栅栏函数的作用等同于一个同步函数的作用
 */
- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"任务1%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"任务11%@", [NSThread currentThread]);
    });

    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"barrier任务2%@", [NSThread currentThread]);
    });

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"任务3%@", [NSThread currentThread]);
    });
}

@end
