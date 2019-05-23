//
//  DrawViewController.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2019/5/23.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "DrawViewController.h"
#import "TextFadeView.h"
#import "DrawCurveView.h"
#import "DrawLineView.h"
#import "IrregularLabelView.h"
#import "HeartLineView.h"
#import "IncisionAnimate.h"
#import "DrawMenuView.h"

@interface DrawViewController ()<DrawMenuViewDelegate>

@property (nonatomic, strong) DrawCurveView *currentCurveView;
@property (nonatomic, strong) DrawCurveView *nextCurveView;

@end

@implementation DrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    TextFadeView *textFade = [[TextFadeView alloc] initWithFrame:CGRectMake(100, 200, 200, 30)];
    //    [textFade fade];
    //    [self.view addSubview:textFade];
    
    [self initDraw];
    
    IrregularLabelView *label = [[IrregularLabelView alloc] initWithFrame:CGRectMake(100, 600, 300, 40)];
    label.text = @"不规则文本";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    
    //不规则文本动画
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animate.fromValue = @(1);
    animate.toValue = @(0.6);
    animate.duration = 0.2;
    animate.repeatCount = 2;
    animate.autoreverses = YES;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [label.layer addAnimation:animate forKey:nil];
    
    //彩色文字
    CAGradientLayer *gradient = [[CAGradientLayer alloc] init];
    gradient.frame = CGRectMake(100, 650, 150, 30);
    gradient.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    gradient.locations = @[@0, @1];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    [self.view.layer addSublayer:gradient];
    
    UILabel *text = [[UILabel alloc] init];
    text.frame = gradient.bounds;
    text.text = @"this is color text";
    text.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:text];
    gradient.mask = text.layer;
    
    
    DrawMenuView *menu = [[DrawMenuView alloc] initWithFrame:CGRectMake(100, 680, 120, 123)];
    menu.itemArray = @[@"服务协议",@"服务设置",@"使用帮助"];
    menu.delegate  = self;
    [self.view addSubview:menu];
 
}

-(void)drawMenuView:(DrawMenuView *)menuView clickMenuItem:(NSInteger)index
{
    NSLog(@"menu click index %ld",index);
}

- (void)initDraw
{
    //    DrawCurveView *view = [[DrawCurveView alloc] initWithFrame:CGRectMake(100, 100, 300, 200)];
    //    [self.view addSubview:view];
    
    [self switchToNextBreathView:YES];
    
    DrawLineView *lineView = [[DrawLineView alloc] initWithFrame:CGRectMake(100, 300, 300, 200)];
    [self.view addSubview:lineView];
    
    HeartLineView *heartView = [[HeartLineView alloc] initWithFrame:CGRectMake(100, 500, 300, 200)];
    [self.view addSubview:heartView];
}

- (void)switchToNextBreathView:(BOOL)active
{
    if (self.currentCurveView != nil)
    {
        [self.currentCurveView removeFromSuperview];
        self.currentCurveView = self.nextCurveView;
        self.nextCurveView = nil;
    }
    
    if (self.currentCurveView == nil)
    {
        //创建当前view
        DrawCurveView *currentView = [[DrawCurveView alloc] initWithFrame:CGRectMake(100, 100, 240, 300)];
        [self.view addSubview:currentView];
        self.currentCurveView = currentView;
    }
    
    //给当前view加动画
    IncisionAnimate *anima1 = [[IncisionAnimate alloc] initWithBaseview:self.currentCurveView space:10];
    anima1.repeat = YES;
    anima1.duration = 2.5;
    anima1.enableLeft = NO;
    [anima1 startWithComplete:^{
        //下一个循环
        [self switchToNextBreathView:YES];
    }];
    
    if (self.nextCurveView == nil)
    {
        //创建下一个view
        DrawCurveView *nextView = [[DrawCurveView alloc] initWithFrame:CGRectMake(100, 100, 240, 300)];
        [self.view addSubview:nextView];
        //给下一个view加动画
        IncisionAnimate *anima2 = [[IncisionAnimate alloc] initWithBaseview:nextView space:10];
        anima2.duration = 2.5;
        anima2.enableRight = NO;
        [anima2 start];
        
        self.nextCurveView = nextView;
    }
}

@end
