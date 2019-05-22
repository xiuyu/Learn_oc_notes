//
//  UIView+PlaceholderView.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2019/5/21.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "UIView+PlaceholderView.h"
#import <objc/runtime.h>
#import "masonry.h"

@interface UIView ()

@property (copy, nonatomic) PlaceholderViewButtonClickBlock buttonClickBlock;

@property (strong, nonatomic) UIView *bgView;

@end

static NSString *const button_block_key = @"button_block_key";
static NSString *const bgView_key = @"bgView_key";

@implementation UIView (PlaceholderView)

- (void)setButtonClickBlock:(PlaceholderViewButtonClickBlock)buttonClickBlock
{
    objc_setAssociatedObject(self, &button_block_key, buttonClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (PlaceholderViewButtonClickBlock)buttonClickBlock
{
    return objc_getAssociatedObject(self, &button_block_key);
}

- (void)setBgView:(UIView *)bgView
{
    objc_setAssociatedObject(self, &bgView_key, bgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)bgView
{
    return objc_getAssociatedObject(self, &bgView_key);
}

- (void)showPlaceholderWithType:(PlaceholderViewType)type buttonClickBlock:(PlaceholderViewButtonClickBlock)block
{
    self.buttonClickBlock = block;
    
    //------------ bg -----------//
    self.bgView = [[UIView alloc] initWithFrame:self.frame];
    self.bgView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.bgView];
    
    //------------ imageView -----------//
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.bgView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(68);
        make.centerX.equalTo(self.bgView);
    }];
    
    //------------ tip -----------//
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.font = [UIFont systemFontOfSize:20];
    tipLab.textColor = [UIColor blackColor];
    [self.bgView addSubview:tipLab];
    
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(24);
        make.centerX.equalTo(self.bgView);
    }];
    
    //------------ tip2 -----------//
    UILabel *tipLab2 = [[UILabel alloc] init];
    tipLab2.font = [UIFont systemFontOfSize:15];
    tipLab2.textColor = [UIColor grayColor];
    [self.bgView addSubview:tipLab2];
    
    [tipLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLab.mas_bottom).offset(20);
        make.centerX.equalTo(self.bgView);
    }];
    
    UIButton *freshButton = [[UIButton alloc] init];
    [freshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [freshButton setTitle:@"刷新" forState:UIControlStateNormal];
    freshButton.titleLabel.font = [UIFont systemFontOfSize:15];
    freshButton.backgroundColor = [UIColor orangeColor];
    freshButton.layer.cornerRadius = 4;
    [freshButton addTarget:self action:@selector(freshHander) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:freshButton];
    
    [freshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(48);
        make.top.equalTo(tipLab2.mas_bottom).offset(23);
    }];
    
    switch (type)
    {
        case PlaceholderViewNoRecord:
        {
            imageView.image = [UIImage imageNamed:@"no_record"];
            tipLab.text = @"无消费记录";
        }
            break;
            
        case PlaceholderViewNoNetWork:
        {
            imageView.image = [UIImage imageNamed:@"no_net"];
            tipLab.text = @"网络异常";
            tipLab2.text = @"人生无常，请试试刷新～";
        }
            break;
            
        case PlaceholderViewNoSearchResult:
        {
            imageView.image = [UIImage imageNamed:@"search_fail"];
            tipLab2.text = @"搜索不到与“吃饭”相关的内容";
        }
            break;
            
        default:
            break;
    }
}

- (void)freshHander
{
    !self.buttonClickBlock ? : self.buttonClickBlock();
    [self.bgView removeFromSuperview];
}

@end
