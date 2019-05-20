//
//  SearchHistoryView.h
//  iOS_UI
//
//  Created by xiuyu on 2019/5/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import <UIKit/UIKit.h>

@class SearchHistoryView;

@protocol SearchHistoryViewDelegate <NSObject>

/**
 点击历史事件

 @param searchView 历史view
 @param index 点击index
 */
- (void)searchHistoryWiew:(SearchHistoryView *)searchView clickedButtonAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SearchHistoryView : UIView

@property (strong, nonatomic) NSArray *titleArray;

@property (weak, nonatomic) id <SearchHistoryViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
