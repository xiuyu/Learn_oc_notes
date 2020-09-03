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

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 30, 30)];
    [self.view addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.layer.cornerRadius = 15;
}

- (void)btnHandler
{
    NSLog(@"btn");

    if (@available(iOS 10.0, *))
    {
        UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:3 curve:UIViewAnimationCurveEaseIn animations:^{
            
            self.imageView.alpha = 0;
        }];

        [animator startAnimation];
    }
    else
    {
        // Fallback on earlier versions
    }

//    [self keyframe];
}

- (void)spring
{
    CASpringAnimation *animate = [CASpringAnimation animationWithKeyPath:@"position"];

    animate.mass = 10.0;      //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    animate.stiffness = 5000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快

    animate.damping = 100;       //阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    animate.initialVelocity = 5; //初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    animate.duration = animate.settlingDuration;
    animate.toValue = [NSValue valueWithCGRect:self.imageView.bounds];
    animate.removedOnCompletion = NO;
    animate.fillMode = kCAFillModeForwards;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.imageView.layer addAnimation:animate forKey:@"boundsAni"];
}

- (void)keyframe
{
    CAKeyframeAnimation *animate = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    //    NSValue *val1 = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    //    NSValue *val2 = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    //    NSValue *val3 = [NSValue valueWithCGPoint:CGPointMake(100, 400)];
    //    NSValue *val4 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    //
    //    animate.values = @[val1,val2,val3,val4];

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.imageView.bounds];

    animate.path = path.CGPath;
    animate.duration = 4;

    [self.imageView.layer addAnimation:animate forKey:nil];
}

/** 显式动画
 *  不会改变最终layer的属性值
 *  CALayer动画，动画后frame未发生改变
 */
- (void)baseAnimate
{
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"position.x"];

    animate.fromValue = [NSNumber numberWithFloat:self.imageView.center.x];
    animate.toValue = [NSNumber numberWithFloat:self.imageView.center.x + 200];

    animate.duration = 2;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    animate.repeatCount = 1;
    animate.removedOnCompletion = NO;
    animate.fillMode = kCAFillModeForwards;

    [self.imageView.layer addAnimation:animate forKey:nil];
}

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

/** 隐式动画
 *  会改变layer属性
 *  UIView动画，动画后frame发生改变
 *  动画过程中，view不相应用户交互
 */
- (void)viewAnimate
{
    [UIView animateWithDuration:2
                          delay:1
                        options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.imageView.frame = CGRectMake(200, 300, 100, 100);
    } completion:^(BOOL finished) {}];
}

@end
