//
//  PriorityViewController.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/2.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "PriorityViewController.h"
#import "Masonry.h"

@interface PriorityViewController ()

@property (strong, nonatomic) UIButton *redBtn;
@property (strong, nonatomic) UIButton *greenBtn;
@property (strong, nonatomic) UIButton *orangeBtn;

@end

@implementation PriorityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [self lablePriority];

    [self buttonPriority];
}

- (void)buttonPriority
{
    self.redBtn = [[UIButton alloc] init];
    self.redBtn.backgroundColor = [UIColor redColor];
    [self.redBtn addTarget:self action:@selector(removeRed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.redBtn];

    [self.redBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@160);
        make.height.width.equalTo(@100);
        make.left.equalTo(@10);
    }];

    self.greenBtn = [[UIButton alloc] init];
    self.greenBtn.backgroundColor = [UIColor greenColor];
    [self.greenBtn addTarget:self action:@selector(removeGreenBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.greenBtn];

    [self.greenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.redBtn);
        make.height.width.equalTo(self.redBtn);
        make.left.equalTo(self.redBtn.mas_right).offset(10);
    }];

    self.orangeBtn = [[UIButton alloc] init];
    self.orangeBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.orangeBtn];

    [self.orangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.redBtn);
        make.height.width.equalTo(self.redBtn);
        make.left.equalTo(self.greenBtn.mas_right).offset(10).priorityHigh();
        make.left.equalTo(self.redBtn.mas_right).offset(10).priorityLow();
        make.left.equalTo(@10).priorityLow();
        make.top.equalTo(@160).priorityLow();
    }];
}

- (void)removeGreenBtn
{
    [self.greenBtn removeFromSuperview];
//    self.greenBtn.hidden = YES;
}

-(void)removeRed
{
    [self.redBtn removeFromSuperview];
}

- (void)lablePriority
{
    UILabel *leftLab = [[UILabel alloc] init];

    leftLab.text = @"我可以被压缩我可以被压缩我可以被压缩";
    [self.view addSubview:leftLab];

    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@100);
    }];

    UILabel *rightLab = [[UILabel alloc] init];
    rightLab.text = @"我不可以被压缩";
    [self.view addSubview:rightLab];

    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftLab);
        make.left.equalTo(leftLab.mas_right).offset(15);
        make.right.equalTo(self.view).offset(-10);
    }];

    [leftLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [rightLab setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

@end
