//
//  DrawMenuView.h
//  iOS_UI
//
//  Created by xiuyu on 2019/5/23.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DrawMenuView;

@protocol DrawMenuViewDelegate <NSObject>

/**
 *  点击菜单
 *
 *  @param menuView 菜单view
 *  @param index 点击菜单index
 */
- (void)drawMenuView:(DrawMenuView *)menuView clickMenuItem:(NSInteger)index;

@end

@interface DrawMenuView : UIView

//菜单数据数组
@property (strong, nonatomic) NSArray *itemArray;

@property (weak, nonatomic) id <DrawMenuViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
