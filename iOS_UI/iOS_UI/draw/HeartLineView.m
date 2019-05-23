//
//  HeartLineView.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2019/5/23.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "HeartLineView.h"

@implementation HeartLineView

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
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    
    CGFloat startX = 0;
    CGFloat startY = 0;
    
    [bezier moveToPoint:CGPointMake(startX, startY)];
    
    for (int i = 0; i < 4; i++)
    {
        [bezier addLineToPoint:CGPointMake(startX + 10, startY)];
        [bezier addLineToPoint:CGPointMake(startX + 12, startY)];
        [bezier addLineToPoint:CGPointMake(startX + 17, startY - 4)];
        [bezier addLineToPoint:CGPointMake(startX + 20, startY)];
        [bezier addLineToPoint:CGPointMake(startX + 27, startY)];
        [bezier addLineToPoint:CGPointMake(startX + 30, startY + 7)];
        [bezier addLineToPoint:CGPointMake(startX + 36, startY - 30)];
        [bezier addLineToPoint:CGPointMake(startX + 40, startY + 30)];
        [bezier addLineToPoint:CGPointMake(startX + 45, startY)];
        [bezier addLineToPoint:CGPointMake(startX + 50, startY)];
        [bezier addLineToPoint:CGPointMake(startX + 55, startY - 5)];
        [bezier addLineToPoint:CGPointMake(startX + 60, startY)];
        
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
