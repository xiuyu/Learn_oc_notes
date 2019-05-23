//
//  DrawMenuView.h
//  iOS_UI
//
//  Created by 丘秀玉 on 2019/5/23.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DrawMenuView;

@protocol DrawMenuViewDelegate <NSObject>

- (void)drawMenuView:(DrawMenuView *)menuView clickMenuItem:(NSInteger)index;

@end

@interface DrawMenuView : UIView

@property (strong, nonatomic) NSArray *itemArray;

@property (weak, nonatomic)id<DrawMenuViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
