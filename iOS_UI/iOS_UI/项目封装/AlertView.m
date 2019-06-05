//
//  AlertView.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "AlertView.h"
#import "masonry.h"

#define MIAN_BUTTON_COLOR [UIColor orangeColor]
#define MIAN_BUTTON_FONT  [UIFont systemFontOfSize:18]

static const NSInteger button_tag = 1000;

@interface AlertView ()

@property (copy, nonatomic) ButtonClickBlock buttonClickBlock;

@property (strong,nonatomic) UIView *contentView;

@end

@implementation AlertView

+ (instancetype)showWithTitle:(NSString *)title content:(NSString *)content buttionTitles:(NSArray *)buttonTitles buttonClickBlock:(nullable ButtonClickBlock)block
{
    AlertView *alertView = [[AlertView alloc] initWithTitle:title content:content buttionTitles:buttonTitles buttonClickBlock:block];
    
    [[UIApplication sharedApplication].delegate.window addSubview:alertView];
    
    // 入场动画
    alertView.alpha = 0;
    alertView.contentView.transform = CGAffineTransformScale(alertView.contentView.transform, 1.2, 1.2);
    [UIView animateWithDuration:0.2 animations:^{
        alertView.alpha = 1;
        alertView.contentView.transform = CGAffineTransformIdentity;
    }];
    
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(alertView.superview);
    }];
    
    return alertView;

}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content buttionTitles:(NSArray *)buttonTitles buttonClickBlock:(nullable ButtonClickBlock)block
{
    if (self = [super init])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.buttonClickBlock = block;
        
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;
        [self addSubview:self.contentView];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-60);
            make.center.mas_equalTo(self);
        }];
        
        //----------- title ---------//
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = title;
        titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_offset(12);
            make.right.mas_offset(-12);
        }];
        
        //----------- content ---------//
        UILabel *contentLab = [[UILabel alloc] init];
        contentLab.text = content;
        contentLab.textAlignment = NSTextAlignmentCenter;
        contentLab.numberOfLines = 0;
        [self.contentView addSubview:contentLab];
        
        [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleLab);
            make.top.equalTo(titleLab.mas_bottom).offset(9);
        }];
        
        //----------- line ---------//
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentLab.mas_bottom).offset(20);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.width.equalTo(self.contentView);
        }];
        
        //----------- buttons ---------//
        if (buttonTitles.count == 1)
        {
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:buttonTitles.firstObject forState:UIControlStateNormal];
            [button setTitleColor:MIAN_BUTTON_COLOR forState:UIControlStateNormal];
            button.tag = button_tag;
            [button.titleLabel setFont:MIAN_BUTTON_FONT];
            [self.contentView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(50);
                make.width.equalTo(self.contentView);
                make.top.equalTo(line.mas_bottom);
                make.left.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
            }];
        }
        else
        {
            NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithCapacity:buttonTitles.count];
            
            for (NSInteger i = 0; i < buttonTitles.count; i++)
            {
                UIButton *button = [[UIButton alloc] init];
                [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
                [button.titleLabel setFont:MIAN_BUTTON_FONT];
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = button_tag + i ;
                [self.contentView addSubview:button];
                [buttonArray addObject:button];
                
                if (i == (buttonTitles.count - 1))
                {
                    [button setTitleColor:MIAN_BUTTON_COLOR forState:UIControlStateNormal];
                }
                else
                {
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    UIView *line = [[UIView alloc] init];
                    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
                    [button addSubview:line];
                    
                    [line mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.equalTo(button);
                        make.width.mas_equalTo(0.5);
                        make.right.equalTo(button.mas_right).offset(0.5);
                    }];
                }
            }
            
            [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
            [buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(50);
                make.top.equalTo(line.mas_bottom);
                make.bottom.mas_equalTo(0);
            }];
        }
    }
    
    return self;
}

-(void)buttonClick:(UIButton *)sender
{
    !self.buttonClickBlock ?: self.buttonClickBlock(sender.tag);
    
    [self removeFromSuperview];
}

-(void)dealloc
{
    NSLog(@"alertView delloc");
}

@end
