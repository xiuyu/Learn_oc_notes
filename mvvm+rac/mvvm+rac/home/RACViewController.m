//
//  HomeViewController.m
//  mvvm+rac
//
//  Created by xiuyu on 2019/5/29.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveObjC.h>


@interface RACViewController ()

@property (strong, nonatomic) UITextField *userName;

@property (strong, nonatomic) UITextField *userPwd;

@property (strong, nonatomic) UIButton *login;

@property (strong, nonatomic) NSString *value;

@property (strong, nonatomic) NSString *value2;

@end

@implementation RACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"rac";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = NO;
    
    //    [self concat];
    
    //    [self combine];
    
    //    [self filter];
    
    //    [self delay];
    
    //    [self replay];
    
    //    [self inteval];
    
    //    [self timeOut];
    
    //    [self throttle];
    
    //    [self takeUitl];
    
    [self group];
    
    
    
}

/**
 *
 *  当signalA和signalB都至少sendNext过一次，
 *  接下来只要其中任意一个signal有了新的内容，doA:withB这个方法就会自动被触发
 *
 */
- (void)group
{
    RACSignal *sigalA = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"A"];
        });
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@"Another B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(updateUI:withB:) withSignals:sigalA, signalB, nil];

}

- (void)updateUI:(NSString *)data1 withB:(NSString *)data2
{
    NSLog(@"%@ %@", data1, data2);
}

/**
 *  条件(takeUntil方法，当给定的signal完成前一直取值
 */
- (void)takeUitl
{
    RACSignal *takeSignal = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate *_Nullable x) {
            [subscriber sendNext:@"send send"];
        }];
        
        return nil;
    }];
    
    RACSignal *conditionSignal = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"send complete");
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    [[takeSignal takeUntil:conditionSignal] subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];
}

/**
 *  节流 如果1s内发生多个,只通过最后一个
 */
- (void)throttle
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"a"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"b"];
            [subscriber sendNext:@"c"];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"e"];
            [subscriber sendNext:@"f"];
            [subscriber sendNext:@"g"];
            [subscriber sendNext:@"u"];
        });
        
        return nil;
    }];
    
    [[signal throttle:1] subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];

    
    
}

/**
 *  过滤
 */
- (void)filter
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@(10)];
        [subscriber sendNext:@(18)];
        [subscriber sendNext:@(1)];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [[signal filter:^BOOL (id _Nullable value) {
        return [value integerValue] >= 18;
    }] subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    
    

}

/**
 *  组合,只有两个信号都有值,才可以组合
 */
- (void)combine
{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    [[[RACSignal combineLatest:@[letters, numbers]
                        reduce:^(NSString *letters, NSString *numbers) {
                            return [letters stringByAppendingString:numbers];
                        }] distinctUntilChanged] subscribeNext:^(id _Nullable x) {
                            NSLog(@"%@", x);
                        }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"]; //打印B1
    [letters sendNext:@"C"]; //打印C1
    [numbers sendNext:@"2"]; //打印C2
}

/**
 *  并联,只要有一个管有东西,就可以打印
 */
- (void)merge
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"a"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"b"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [[RACSignal merge:@[signalA, signalB]] subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];

}

/**两个信号串联,两个管串联
 *  串联后的接收端处理 ,两个事件,走两次,第一个打印siggnalA的结果,第二次打印siganlB的结果
 */
- (void)concat
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"吃饭"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"吃的饱饱的,才可以睡觉的"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [[signalA concat:signalB] subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];

}

/**
 *  映射对信号进行改进
 */
- (void)map
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"唱歌"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    
    //当信号里面流的是唱歌.就改进为'跳舞'返还给self.value
    [[signal map:^id _Nullable (id _Nullable value) {
        if ([value isEqualToString:@"唱歌"])
        {
            return @"跳舞";
        }
        return @"";
    }] subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];
}

/**
 *  定时器
 */
- (void)inteval
{
    __block NSInteger time = 10;
    __block RACDisposable *dispose = nil;
    
    dispose = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]]
               subscribeNext:^(NSDate *_Nullable x) {
                   if (time > 0)
                   {
                       time -= 1;
                   }
                   else
                   {
                       [dispose dispose];
                   }
                   
                   NSLog(@"%ld", time);
               }];
    
}

/**
 *  超时
 */
- (void)timeOut
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"发送消息"];
        [subscriber sendCompleted];
        return nil;
    }] delay:20];
    
    [[signal timeout:10 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id _Nullable x) {
        NSLog(@"太慢了");
    }];
}

/**
 *  重复播放
 */
- (void)replay
{
    RACSignal *replaySiganl = [[RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"电影"];
        [subscriber sendCompleted];
        return nil;
    }] replay];
    
    [replaySiganl subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [replaySiganl subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];
}

/**
 *  延迟
 */
- (void)delay
{
    [[[RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
        [subscriber sendNext:@"等等我,我还有10s就到了"];
        [subscriber sendCompleted];
        return nil;
    }] delay:10] subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];
}

@end
