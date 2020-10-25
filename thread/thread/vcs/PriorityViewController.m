//
//  PriorityViewController.m
//  Thread
//
//  Created by xiuyu on 2019/4/22.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "PriorityViewController.h"

@interface PriorityViewController ()

@end

@implementation PriorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self priority];
    
}

-(void)priority
{
    //优先倒置 低优先级的任务会因为各种原因先于高优先级任务执行
    dispatch_queue_t queue = dispatch_queue_create("com.queue", DISPATCH_QUEUE_CONCURRENT);
    
    //变更队列的执行优先级
    dispatch_set_target_queue(queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0));
    
    dispatch_async(queue, ^{
        NSLog(@"low任务1");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"low任务2");
    });
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"default任务3");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       NSLog(@"defalut任务4");
    });
    
}


@end
