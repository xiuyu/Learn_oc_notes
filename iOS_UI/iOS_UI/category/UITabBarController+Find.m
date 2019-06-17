//
//  UITabBarController+Find.m
//  iOS_UI
//
//  Created by xiuyu on 2019/6/12.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "UITabBarController+Find.h"

@implementation UITabBarController (Find)

- (UIViewController *)find:(Class)cls
{
    UIViewController *result = nil;
    
    UINavigationController *nav = (UINavigationController *)self.selectedViewController;
    
    for (UIViewController *vc in nav.viewControllers)
    {
        if ([vc isMemberOfClass:cls])
        {
            result = vc;
        }
    }
    
    return result;
}

@end
