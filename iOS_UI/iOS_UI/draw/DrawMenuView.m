//
//  DrawMenuView.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/23.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "DrawMenuView.h"
#import "masonry.h"
#import <YYKit.h>

@implementation DrawMenuView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)setItemArray:(NSArray *)itemArray
{
    _itemArray = itemArray;
    
    for (UIView *subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    
    //七点 圆弧
    [bezier moveToPoint:CGPointMake(0, 5)];
    [bezier addQuadCurveToPoint:CGPointMake(5, 0) controlPoint:CGPointMake(0, 0)];
    
    //尖三角形
    [bezier addLineToPoint:CGPointMake(width / 2 - 5 + 20, 0)];
    [bezier addLineToPoint:CGPointMake(width / 2 + 20, -5)];
    [bezier addLineToPoint:CGPointMake(width / 2 + 20 + 5, 0)];
    
    //圆弧
    [bezier addLineToPoint:CGPointMake(width - 5, 0)];
    [bezier addQuadCurveToPoint:CGPointMake(width, 5) controlPoint:CGPointMake(width, 0)];
    
    //右下方圆弧
    [bezier addLineToPoint:CGPointMake(width, height - 5)];
    [bezier addQuadCurveToPoint:CGPointMake(width - 5, height) controlPoint:CGPointMake(width, height)];
    
    //左下方圆弧
    [bezier addLineToPoint:CGPointMake(5, height)];
    [bezier addQuadCurveToPoint:CGPointMake(0, height - 5) controlPoint:CGPointMake(0, height)];
    
    [bezier addLineToPoint:CGPointMake(0, 5)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 1;
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.fillColor = [UIColor orangeColor].CGColor;
    layer.path = bezier.CGPath;
    [self.layer addSublayer:layer];
    
  
    // item view
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 1;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.alignment = UIStackViewAlignmentCenter;
    [self addSubview:stackView];
    
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.width.equalTo(self);
    }];
    
    for (int i = 0; i < self.itemArray.count; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:self.itemArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i ;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(37);
            make.width.mas_equalTo(width);
        }];
        
        [stackView addArrangedSubview:button];
        
        if (i < self.itemArray.count - 1)
        {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
            [button addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.5);
                make.left.mas_equalTo(20);
                make.right.mas_equalTo(-30);
                make.top.equalTo(button.mas_bottom).offset(0.5);
            }];
        }
    }
}

-(void)buttonClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(drawMenuView:clickMenuItem:)]) {
        [self.delegate drawMenuView:self clickMenuItem:sender.tag];
    }
}

-(void)dealloc
{
    NSLog(@"menu view delloc");
}


@end
