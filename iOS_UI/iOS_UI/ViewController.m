//
//  ViewController.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ViewController.h"
#import "AlertView.h"
#import "masonry.h"
#import "SearchHistoryView.h"
#import "ScrollViewMenuItem.h"
#import "MarqueeView.h"
#import "AdjustImageButton.h"
#import "PayView.h"

@interface ViewController ()<SearchHistoryViewDelegate,ScrollViewMenuItemDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSLog(@"%.f",self.mas_bottomLayoutGuide);
//    NSLog(@"%.f",self.bottomLayoutGuide.length);
    
    
//    NSAssert(<#condition#>, <#desc, ...#>)
    
//    self.parentViewController
//    self.isBeingDismissed
    
//    self.isMovingFromParentViewController

    SearchHistoryView *h = [[SearchHistoryView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 500)];
    h.titleArray =@[@"账单",@"这是一条测试文案宽度的文案到底有多长呢",@"高度限定",@"emoji",@"这是一条测试文案宽度的文案，当文案超过一行显示的时候显示为",@"这是二条测试文案宽度的文案，当文案超过一行显示的时候显示为"];
    h.delegate = self;
    [self.view addSubview:h];
    
    ScrollViewMenuItem *i = [[ScrollViewMenuItem alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, 44)];
    i.titleArray = @[@"生活服务",@"政务服务",@"社区服务",@"健康服务",@"生活服务",@"政务服务",@"社区服务",@"健康服务"];
    [i scrollMenuItemIndex:2];
    i.menuDelegate = self;
    [self.view addSubview:i];
    
  
    
    MarqueeView *m = [[MarqueeView alloc] initWithFrame:CGRectMake(0, 500, ScreenWidth, 44)];
    m.titleArray = @[@"区住房建设局加大对商品房预售款监",@"番禺区青年学习宣传贯彻习近平新时",@"123",@"456"];
    [self.view addSubview:m];
    
    
 
    UIStackView *stackview = [[UIStackView alloc] initWithFrame:CGRectMake(0, 600, ScreenWidth, 44)];
    stackview.spacing = 10;
    stackview.axis = UILayoutConstraintAxisHorizontal;
    stackview.distribution = UIStackViewDistributionFillEqually;
    stackview.alignment = UIStackViewAlignmentCenter;
    [self.view addSubview:stackview];
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:[NSString stringWithFormat:@"button %d",i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [stackview addArrangedSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(button.mas_width);
        }];
    }

}

-(void)searchHistoryWiew:(SearchHistoryView *)searchView clickedButtonAtIndex:(NSInteger)index
{
    NSLog(@"点击的：%ld",index);
}

-(void)scrollViewMenuItem:(ScrollViewMenuItem *)menuItem clickButtonIndex:(NSInteger)index
{
    NSLog(@"scrollitem %ld",index);
}

- (void)click
{
    [AlertView showWithTitle:@"标题" content:@"内容" buttionTitles:@[@"确定",@"取消"] buttonClickBlock:nil];
}

@end
