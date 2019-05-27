//
//  UIView+PlaceholderView.h
//  iOS_UI
//
//  Created by xiuyu on 2019/5/21.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PlaceholderViewButtonClickBlock)(void);

typedef NS_ENUM (NSUInteger, PlaceholderViewType)
{
    PlaceholderViewNoSearchResult,
    PlaceholderViewNoNetWork,
    PlaceholderViewNoRecord,
};

@interface UIView (PlaceholderView)


/**
 显示无网络 无搜索结果 无记录

 @param type 类型
 @param block 点击按钮回调
 */
- (void)showPlaceholderWithType:(PlaceholderViewType)type buttonClickBlock:(PlaceholderViewButtonClickBlock)block;

@end

NS_ASSUME_NONNULL_END
