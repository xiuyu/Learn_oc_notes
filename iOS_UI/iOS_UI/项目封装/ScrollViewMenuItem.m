//
//  ScrollViewMenuItem.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ScrollViewMenuItem.h"
#import "UIView+frameAdjust.h"

#define MIAN_BUTTON_COLOR    [UIColor orangeColor]
#define NORMAL_BUTTON_COLOR [UIColor blackColor]

@interface ScrollViewMenuItem ()

@property (strong, nonatomic) UIView *lineView;


@end

@implementation ScrollViewMenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    for (UIView *subView in self.subviews)
    {
        [subView removeFromSuperview];
    }
    
    CGFloat width = self.width / 4;
    CGFloat height = 42;
    CGFloat y = 0;
    
    for (int i = 0; i < _titleArray.count; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setTitleColor:MIAN_BUTTON_COLOR forState:UIControlStateSelected];
        [button setTitleColor:NORMAL_BUTTON_COLOR forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.frame = CGRectMake(i * width, y, width, height);
        
        if (i == 0)
        {
            button.selected = YES;
        }
        
    }
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = MIAN_BUTTON_COLOR;
    [self addSubview:self.lineView];
    
    self.lineView.frame = CGRectMake(0, 43, width, 1);
    
    
    self.contentSize = CGSizeMake(_titleArray.count * width, height);
    
    // 如果内容总宽度比较少
    if (self.contentSize.width < self.width)
    {
        int i = 0;
        
        for (UIButton *button in self.subviews)
        {
            if ([button isMemberOfClass:[UIButton class]])
            {
                button.width = self.width / _titleArray.count;
                button.x = i * button.width;
                button.titleLabel.adjustsFontSizeToFitWidth = YES; // 开启，防极端情况
                
                if (i == 0)
                {
                    self.lineView.centerX = button.centerX;
                    self.lineView.maxY = self.height;
                }
                i++;
            }
        }
    }
}

- (void)itemClick:(UIButton *)sender
{
    for (UIButton *button in self.subviews)
    {
        if ([button isMemberOfClass:[UIButton class]])
        {
            button.selected = NO;
        }
    }
    
    sender.selected = YES;
    
    [self scrollButton:sender];
    
    if ([self.menuDelegate respondsToSelector:@selector(scrollViewMenuItem:clickButtonIndex:)])
    {
        [self.menuDelegate scrollViewMenuItem:self clickButtonIndex:sender.tag];
    }
}

- (void)scrollMenuItemIndex:(NSInteger)index
{
    for (UIButton *button in self.subviews)
    {
        if ([button isMemberOfClass:[UIButton class]])
        {
            button.selected = NO;
        }
    }
    
    UIButton *button = (UIButton *)[self viewWithTag:index];
    button.selected = YES;
    
    [self scrollButton:button];
}

- (void)scrollButton:(UIButton *)sender
{
    //计算位置
    if (self.contentSize.width > self.width)
    {
        if (sender.x >= self.width / 2 && sender.centerX <= self.contentSize.width - self.width / 2)
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(sender.centerX - self.width / 2, 0);
            }];
        }
        else if (sender.frame.origin.x < self.width / 2)
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(0, 0);
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.contentOffset = CGPointMake(self.contentSize.width - self.width, 0);
            }];
        }
    }
    
    // 改变下横线的位置和宽度
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.centerX = sender.centerX;
    }];
}

-(void)dealloc
{
    NSLog(@"scroll item delloc");
}

@end
