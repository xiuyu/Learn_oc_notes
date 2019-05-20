//
//  AdjustImageButton.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/20.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "AdjustImageButton.h"
#import <UIImage+YYAdd.h>

@implementation AdjustImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        UIImage *image = [[UIImage imageNamed:@"wechat"] imageByResizeToSize:CGSizeMake(60, 60) contentMode:UIViewContentModeScaleAspectFill];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:image forState:UIControlStateNormal];
        [button setTitle:@"微信好友" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:button];
        
        CGSize imageSize = button.imageView.frame.size;
        CGSize titleSize = button.titleLabel.intrinsicContentSize;
        
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height , 0, 0, -titleSize.width);
    }
    
    return self;
}

@end
