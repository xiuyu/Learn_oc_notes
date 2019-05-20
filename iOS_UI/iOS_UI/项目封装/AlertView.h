//
//  AlertView.h
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ButtonClickBlock)(NSInteger index);

@interface AlertView : UIView


/**
  弹窗调用方法

 @param title 标题
 @param content 内容
 @param buttonTitles 按钮title
 @param block 点击按钮回调
 */
+ (instancetype)showWithTitle:(nullable NSString *)title content:(NSString *)content buttionTitles:(NSArray *)buttonTitles buttonClickBlock:(nullable ButtonClickBlock)block;

@end

NS_ASSUME_NONNULL_END
