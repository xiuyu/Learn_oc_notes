//
//  LoginPresenter.m
//  MVP
//
//  Created by 丘秀玉 on 2020/3/12.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "LoginPresenter.h"

@implementation LoginPresenter

- (void)featchData
{
    [self.delegate showIndicator];
    sleep(3);
    [self.delegate hideIndicator];
    [self getData];
}

- (void)getData
{
    LoginModel *model = [[LoginModel alloc] init];

    model.name = @"tom";
    model.phoneNum = @"123456";

    [self.delegate userViewDataSource:model];
}

@end
