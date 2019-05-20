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
    
    queue = dispatch_get_global_queue(0, 0);
    
    [self barrier];
}

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

- (void)barrier
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
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
