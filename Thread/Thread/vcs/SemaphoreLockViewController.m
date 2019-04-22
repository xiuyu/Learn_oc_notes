//
//  SemaphoreLockViewController.m
//  Thread
//
//  Created by 丘秀玉 on 2019/4/22.
//  Copyright © 2019 丘秀玉. All rights reserved.
//

#import "SemaphoreLockViewController.h"

@interface SemaphoreLockViewController ()
{
    NSInteger _tickets;
    
    dispatch_semaphore_t _semaphore;
}

@end

@implementation SemaphoreLockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tickets = 20;
    
    _semaphore = dispatch_semaphore_create(1); //创建一个Semaphore并初始化信号的总量
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        [self saleTickets];
    });
    
    dispatch_async(queue, ^{
        [self saleTickets];
    });
    
    [self semaphoreSync];
}

- (void)saleTickets
{
    while (1) {
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER); //可以使总信号量减1
        
        if (_tickets > 0)
        {
            _tickets--;
            NSLog(@"剩余票数= %ld, Thread:%@", _tickets, [NSThread currentThread]);
        }
        else
        {
            dispatch_semaphore_signal(_semaphore);
            NSLog(@"票卖完了  Thread:%@", [NSThread currentThread]);
            break;
        }
        
        dispatch_semaphore_signal(_semaphore); //发送一个信号，让信号总量加1
    }
}

/**
 * semaphore 线程同步
 */
- (void)semaphoreSync
{
    NSLog(@"semaphore---begin");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    __block int num = 10;
    
    dispatch_async(queue, ^{
        dispatch_semaphore_signal(semaphore);
        num = 100;
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    NSLog(@"semaphore end num = %d", num);
}

@end
