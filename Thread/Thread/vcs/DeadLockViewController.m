//
//  DeadLockViewController.m
//  Thread
//
//  Created by 丘秀玉 on 2019/4/22.
//  Copyright © 2019 丘秀玉. All rights reserved.
//

#import "DeadLockViewController.h"

@interface DeadLockViewController ()

@end

@implementation DeadLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self sync_mian];
    
    [self sync_async];
}

-(void)sync_mian
{
    //1.主动列同步
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"死锁");
    });
    
    NSLog(@"end");
}

-(void)sync_async
{
    //同一个串行队列中进行异步、同步嵌套。会构成死锁
    dispatch_queue_t seralQueue = dispatch_queue_create("test", nil);
    
    dispatch_async(seralQueue, ^{
        
        dispatch_sync(seralQueue, ^{
            
             NSLog(@"死锁");
        });
        
    });
    
    NSLog(@"end");
    
}




@end
