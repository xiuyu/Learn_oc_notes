//
//  UIImage+Circle.m
//  iOS_UI
//
//  Created by xiuyu on 2019/6/11.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "UIImage+Circle.h"

@implementation UIImage (Circle)

- (UIImage *)circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(ctx, rect);
    
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
