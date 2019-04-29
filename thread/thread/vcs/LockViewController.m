//
//  LockViewController.m
//  Thread
//
//  Created by 丘秀玉 on 2019/4/22.
//  Copyright © 2019 丘秀玉. All rights reserved.
//

#import "LockViewController.h"

@interface LockViewController ()
{
    NSInteger _tickets;
    
    NSLock *_mutexLock;//NSLock在内部封装了一个 pthread_mutex，属性为 PTHREAD_MUTEX_ERRORCHECK。
}

@end

@implementation LockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tickets = 20;
    _mutexLock = [[NSLock alloc] init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        [self saleTicket];
    });
    
    dispatch_async(queue, ^{
        [self saleTicket];
    });
}

- (void)saleTicket
{
    while (1) {
        
        [_mutexLock lock];
        [NSThread sleepForTimeInterval:1];
        
        if (_tickets > 0)
        {
            _tickets--;
            NSLog(@"剩余票数= %ld, Thread:%@", _tickets, [NSThread currentThread]);
        }
        else
        {
            NSLog(@"票卖完了  Thread:%@", [NSThread currentThread]);
            [_mutexLock unlock];
            break;
        }
        
        [_mutexLock unlock];
    }
}

@end
