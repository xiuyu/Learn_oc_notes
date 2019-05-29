//
//  LoginViewModel.h
//  mvvm+rac
//
//  Created by xiuyu on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "LoginModel.h"


NS_ASSUME_NONNULL_BEGIN

/**
 *  {
 *  "data": {
 *  "mobileNo": "13912345678",
 *  "type": 0,
 *  "loginPwd": "12345678",
 *  "smsCode": "123456",
 *  "systemPlatform": "iOS",
 *  "deviceBrand": "HUAWEI",
 *  "pushInfo": [{
 *  "platform": "XG"
 *  "deviceId": "5874265826592865428"
 *  },{
 *  "platform": "UMENG"
 *  "deviceId": "5874265826592865428"
 *  }]
 *  }
 *  }*/

@interface LoginViewModel : NSObject

// 手机号
@property (strong, nonatomic) NSString *mobileNo;

// 验证码
@property (strong, nonatomic) NSString *smsCode;

//验证码title
@property (strong, nonatomic) NSString *codeBtnTitile;

@property (strong,nonatomic) RACSubject *changeTitleSignal;

//验证码按钮背景颜色
@property (strong, nonatomic) UIColor *codeBtnBackGroundColor;
//登录按钮背景颜色
@property (strong, nonatomic) UIColor *loginBtnBackGroundColor;

// 按钮能否点击
@property (strong, nonatomic) RACSignal *validCodeSignal;
@property (strong, nonatomic) RACSignal *validLoginSignal;

@property (strong, nonatomic) RACCommand *getCodeCommand;

@property (strong, nonatomic) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
