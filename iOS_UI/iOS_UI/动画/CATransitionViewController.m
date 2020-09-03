//
//  CATransitionViewController.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/31.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "CAAnimateViewController.h"

@interface CAAnimateViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation CAAnimateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnHandler) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"no_net"];
    [self.view addSubview:self.imageView];
}

- (void)btnHandler
{}

- (void)transitionAnimate
{
    //@[@"fade", @"moveIn", @"push", @"reveal", @"cube"]
    self.imageView.image = [UIImage imageNamed:@"no_record"];

    CATransition *animate = [CATransition animation];
    animate.type = @"push";
    //    animate.subtype = kCATransitionFromRight;
    //    animate.duration = 2;
    [self.imageView.layer addAnimation:animate forKey:nil];
}

@end
