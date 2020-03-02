//
//  BaseViewController.m
//  Thread
//
//  Created by xiuyu on 2019/4/22.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self once];
    [self once];

    [self group];

    [self time_after];

    [self apply];
}

- (void)group
{
    dispatch_group_t group = dispatch_group_create();

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_group_async(group, queue, ^{
        NSLog(@"任务1%@", [NSThread currentThread]);

        [NSThread sleepForTimeInterval:1];
    });

    dispatch_group_async(group, queue, ^{
        NSLog(@"任务2%@", [NSThread currentThread]);

        [NSThread sleepForTimeInterval:1];
    });

    dispatch_group_notify(group, queue, ^{
        NSLog(@"任务完成%@", [NSThread currentThread]);
    });

    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程） 但是，使用dispatch_group_wait 会阻塞当前线程。
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

    NSLog(@"group--end");

    //    从dispatch_group_enter、dispatch_group_leave相关代码运行结果中可以看出：当所有任务执行完成之后，才执行 dispatch_group_notify 中的任务。这里的dispatch_group_enter、dispatch_group_leave组合，其实等同于dispatch_group_async。
}

- (void)time_after
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)3 * NSEC_PER_SEC);

    dispatch_after(time, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"dispatch after 3");
    });
    
  
}

- (void)once
{
    dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        NSLog(@"once");
    });
}

- (void)apply
{
    dispatch_apply(6, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"dispatch applay index = %zu", index);
    });
}

@end
