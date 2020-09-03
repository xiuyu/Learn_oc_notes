//
//  LoginPresenter.h
//  MVP
//
//  Created by 丘秀玉 on 2020/3/12.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LoginProtocol <NSObject>

- (void)userViewDataSource:(LoginModel *)data;

- (void)showIndicator;

- (void)hideIndicator;

- (void)showEmptyView;

@end

@interface LoginPresenter : NSObject

@property (weak, nonatomic)id <LoginProtocol> delegate;

- (void)featchData;

@end

NS_ASSUME_NONNULL_END
