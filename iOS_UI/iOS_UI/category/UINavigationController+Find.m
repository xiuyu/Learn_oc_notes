//
//  UINavigationController+Find.m
//  iOS_UI
//
//  Created by xiuyu on 2019/6/12.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "UINavigationController+Find.h"

@implementation UINavigationController (Find)

- (UIViewController *)find:(Class)cls
{
    UIViewController *result = nil;
    
    for (UIViewController *vc in self.viewControllers)
    {
        if ([vc isMemberOfClass:cls])
        {
            result = vc;
        }
    }
    
    return result;
}

@end
