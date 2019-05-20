//
//  ScrollViewMenuItem.h
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ScrollViewMenuItem;
@protocol ScrollViewMenuItemDelegate <NSObject>

/**
 *  点击menu事件
 *
 *  @param menuItem itemView
 *  @param index 点击按钮
 */
- (void)scrollViewMenuItem:(ScrollViewMenuItem *)menuItem clickButtonIndex:(NSInteger)index;

@end

@interface ScrollViewMenuItem : UIScrollView

@property (strong, nonatomic) NSArray *titleArray;

@property (weak, nonatomic) id <ScrollViewMenuItemDelegate> menuDelegate;

/**
 滚动指定menu
 @param index 滚动index
 */
- (void)scrollMenuItemIndex:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
