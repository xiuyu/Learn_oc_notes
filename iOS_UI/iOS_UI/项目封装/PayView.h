//
//  PayView.h
//  iOS_UI
//
//  Created by xiuyu on 2019/5/20.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PayViewResultBlock)(NSInteger index, NSString * _Nullable pwd);

NS_ASSUME_NONNULL_BEGIN

@interface PayView : UIView

/**
 显示支付密码输入框

 @param title 标题
 @param block 结果回调
 @return 返回密码框实例
 */
+ (instancetype)showPayViewWithTitle:(nullable NSString *)title buttonClickBolck:(PayViewResultBlock)block;

@end

NS_ASSUME_NONNULL_END
