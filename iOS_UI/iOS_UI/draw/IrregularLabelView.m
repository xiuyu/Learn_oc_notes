//
//  IrregularLabelView.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/23.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "IrregularLabelView.h"

@interface IrregularLabelView ()

//遮罩
@property (strong, nonatomic) CAShapeLayer *layerView;
//路径
@property (strong, nonatomic) UIBezierPath *bezier;

@end

@implementation IrregularLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.bezier = [UIBezierPath bezierPath];
        self.layerView = [CAShapeLayer layer];
        
        [self.layer setMask:self.layerView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layerView.frame = self.bounds;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat startY = 5;
    CGFloat startX = 0;
    
    [self.bezier moveToPoint:CGPointMake(startX, startY)];
    
    //尖三角形
    [self.bezier addLineToPoint:CGPointMake(width / 2 - 5, startY)];
    [self.bezier addLineToPoint:CGPointMake(width / 2, startY - 5)];
    [self.bezier addLineToPoint:CGPointMake(width / 2 + 5, startY)];
    
    [self.bezier addLineToPoint:CGPointMake(width, startY)];
    
    [self.bezier addLineToPoint:CGPointMake(width, height - startY)];
    [self.bezier addLineToPoint:CGPointMake(0, height - startY)];
    [self.bezier addLineToPoint:CGPointMake(0, startY)];
    
    self.layerView.path = self.bezier.CGPath;
   
}

@end
