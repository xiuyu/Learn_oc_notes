//
//  ThreadCancelViewController.m
//  thread
//
//  Created by xiuyu on 2019/5/16.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ThreadCancelViewController.h"

@interface ThreadCancelViewController ()

@end

static BOOL shouldCancel = NO;

@implementation ThreadCancelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self dispatch_create_cancel];
    
    [self dispatch_cancel];
    
}

/**
 *  dispatch 取消
 */
- (void)dispatch_cancel
{
    dispatch_queue_t queue = dispatch_queue_create("dispatch_2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"任务开始");
        
        for (int i = 0; i < 10; i++)
        {
            if (shouldCancel)
            {
                NSLog(@"在i=%d的时候已经取消了", i);
                break;
            }
            NSLog(@"i=%d", i);
            
            [NSThread sleepForTimeInterval:1];
        }
    });
    
    [self performSelector:@selector(GCD_shouldCancel) withObject:nil afterDelay:5];
}

- (void)GCD_shouldCancel
{
    shouldCancel = YES;
}

/**
 *  多线程取消 dispatch_block_cancel
 */
- (void)dispatch_create_cancel
{
    dispatch_queue_t queue = dispatch_queue_create("dispatch_1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t block1 = dispatch_block_create(0, ^{
        NSLog(@"1");
    });
    
    dispatch_block_t block2 = dispatch_block_create(0, ^{
        NSLog(@"2");
    });
    
    dispatch_block_t block3 = dispatch_block_create(0, ^{
        NSLog(@"3");
    });
    
    dispatch_async(queue, block1);
    dispatch_async(queue, block2);
    dispatch_async(queue, block3);
    
    dispatch_block_cancel(block2);
    
//    dispatch_block_cancel(<#^(void)block#>)
    
//    dispatch_resume(<#dispatch_object_t  _Nonnull object#>)
    
//    dispatch_suspend(<#dispatch_object_t  _Nonnull object#>)
}

@end
