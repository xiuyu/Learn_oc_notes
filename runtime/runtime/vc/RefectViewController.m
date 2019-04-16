//
//  RefectViewController.m
//  runtime
//
//  Created by 丘秀玉 on 2019/4/15.
//  Copyright © 2019 丘秀玉. All rights reserved.
//

#import "RefectViewController.h"

@interface RefectViewController ()

@end

@implementation RefectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton new];
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"点击跳转"forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnHander:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnHander:(UIButton *)sender
{
    NSDictionary *params = @{
                             @"className" : @"RViewController",
                             @"pros" : @{@"name" : @"xiuyu"},
                             @"method" : @"userInfo"
                             };
    
    Class cls = NSClassFromString(params[@"className"]);
    UIViewController *vc = [[cls alloc] init];
    
    NSDictionary *pros = params[@"pros"];
    [pros enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop) {
        //防止后台数据导致的异常
        if ([vc respondsToSelector:NSSelectorFromString(key)])
        {
            //kvc赋值
            [vc setValue:obj forKeyPath:key];
        }
    }];
    
    //执行方法
    SEL sel = NSSelectorFromString(params[@"method"]);
    
    [vc performSelector:sel withObject:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 #pragma mark - Navigation
 *
 *  // In a storyboard-based application, you will often want to do a little preparation before navigation
 *  - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 *   // Get the new view controller using [segue destinationViewController].
 *   // Pass the selected object to the new view controller.
 *  }
 */

@end
