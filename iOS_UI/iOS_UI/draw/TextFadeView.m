//
//  TextFadeView.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2019/5/22.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "TextFadeView.h"

@implementation TextFadeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initLabelWithFrame:self.bounds];
        [self initLayerViewWithFrame:self.bounds];
    }
    
    return self;
}

- (void)initLabelWithFrame:(CGRect)frame
{
    self.label = [[UILabel alloc] initWithFrame:frame];
    self.label.text = @"this is fade text";
    self.label.textColor = [UIColor redColor];
    self.label.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.label];
}

- (void)initLayerViewWithFrame:(CGRect)frame
{
    self.layerView = [[UIView alloc] initWithFrame:frame];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.layerView.bounds;
    gradient.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)[UIColor blackColor].CGColor];
    gradient.locations = @[@(0.01), @(0.99)];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    
    [self.layerView.layer addSublayer:gradient];
    [self addSubview:self.layerView];
    
    self.maskView = self.layerView;
}

- (void)fade
{
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = self.layerView.frame;
        frame.origin.x = frame.size.width;
        self.layerView.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGRect frame = self.layerView.frame;
            frame.origin.x -= frame.size.width;
            self.layerView.frame = frame;
        } completion:^(BOOL finished) {
            [self fade];
        }];
    }];
}

@end
