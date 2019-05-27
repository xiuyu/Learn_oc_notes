//
//  DrawCurveView.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/22.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "DrawCurveView.h"

@implementation DrawCurveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self draw];
    }
    
    return self;
}

- (void)draw
{
    CGFloat startX = 0;
    CGFloat startY = self.center.y / 2;
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    
    [bezier moveToPoint:CGPointMake(startX, startY)];
    
    for (int i = 0; i < 3; i++)
    {
        [bezier addQuadCurveToPoint:CGPointMake(startX + 40, startY) controlPoint:CGPointMake(startX + 20, startY + 90)];
        [bezier addQuadCurveToPoint:CGPointMake(startX + 80, startY) controlPoint:CGPointMake(startX + 60, startY - 90)];
        startX = bezier.currentPoint.x;
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = bezier.CGPath;
    
    [self.layer addSublayer:layer];
}

@end
