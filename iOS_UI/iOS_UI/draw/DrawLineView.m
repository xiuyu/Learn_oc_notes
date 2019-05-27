//
//  DrawLineView.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/22.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "DrawLineView.h"

@interface DrawLineView ()

@property (nonatomic, assign) NSInteger sectionCount;

@end

@implementation DrawLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.sectionCount = 20;
        
        [self draw];
    }
    
    return self;
}

- (void)draw
{
    UIBezierPath *bezier = [[UIBezierPath alloc] init];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat startX = 0;
    CGFloat startY = height / 2;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.sectionCount; i++)
    {
        [array addObject:@0];
    }
    
    for (int i = 0; i < self.sectionCount; i++)
    {
        int index = arc4random() % (self.sectionCount - 2) + 1;
        
        if (array[index] != nil && ![array[index] isEqual:@1])
        {
            array[index] = @1;
        }
    }
    
    CGFloat sectionWidth = 1.0 * width / self.sectionCount;
    
    [bezier moveToPoint:CGPointMake(0, startY)];
    
    for (int i = 0; i < self.sectionCount; i++)
    {
        NSNumber *num = array[i];
        
        if ([num isEqual:@0])
        {
            [bezier addLineToPoint:CGPointMake(startX + sectionWidth * (i + 1), startY)];
        }
        else
        {
            if (i > 0 && ![array[i - 1] isEqual:@1])
            {
                [bezier addLineToPoint:CGPointMake(startX + bezier.currentPoint.x, startY - 80)];
            }
            
            [bezier addLineToPoint:CGPointMake(startX + sectionWidth * (i + 1), startY - 80)];
            
            if (i < self.sectionCount && ![array[i + 1] isEqual:@1])
            {
                [bezier addLineToPoint:CGPointMake(startX + sectionWidth * (i + 1), startY)];
            }
        }
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = bezier.CGPath;
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
}

@end
