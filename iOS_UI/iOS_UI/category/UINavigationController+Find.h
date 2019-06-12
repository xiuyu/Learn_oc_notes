//
//  UINavigationController+Find.h
//  iOS_UI
//
//  Created by 丘秀玉 on 2019/6/12.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Find)


/**
 查找当前vc是否存在

 @param cls 查找cls
 @return 返回查找的vc
 */
- (UIViewController *)find:(Class)cls;

@end

NS_ASSUME_NONNULL_END
