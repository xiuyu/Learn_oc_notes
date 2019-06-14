//
//  LoginViewModel.m
//  mvvm+rac
//
//  Created by xiuyu on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "LoginViewModel.h"
#import "Utils.h"
#import "Request.h"
#import <YYKit.h>

#define BUTTON_ENABLE_COLOR [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0]

#define BUTTON_NOMAL_COLOR  [UIColor colorWithRed:255 / 255.0 green:151 / 255.0 blue:0 / 255.0 alpha:1.0]

static const NSTimeInterval timeCountNum = 60;

@interface LoginViewModel ()
{
    NSInteger _timeCount;
}

@property (strong, nonatomic) RACDisposable *dispoable;

@end

@implementation LoginViewModel

- (instancetype)init
{
    if (self = [super init])
    {
        _timeCount = timeCountNum;
        
        self.codeBtnTitile = @"获取验证码";
        
        self.changeTitleSignal = [RACSubject subject];
        
        /**
         *  RAC(self, avatarURL) = [[RACObserve(self, username)
         *  map:^(NSString *username) {
         *  return [[OCTUser mrc_fetchUserWithRawLogin:username] avatarURL];
         *  }]
         *  distinctUntilChanged];
         */
        
        [self validCodeBtn];
        [self validLoginBtn];
        
        [self getCode];
        [self login];
    }
    return self;
}

/**
 *  登录按钮是否可点
 */
- (void)validLoginBtn
{
    @weakify(self)
    self.validLoginSignal = [[RACSignal
                              combineLatest:@[RACObserve(self, mobileNo), RACObserve(self, smsCode)]
                              reduce:^(NSString *mobileNo, NSString *smsCode) {
                                  @strongify(self)
                                  
                                  BOOL login = [Utils verifyPhoneNumber:mobileNo] && smsCode.length > 3;
                                  
                                  UIColor *color = login ?  BUTTON_NOMAL_COLOR : BUTTON_ENABLE_COLOR;
                                  self.loginBtnBackGroundColor = color;
                                  
                                  return @(login);
                              }] distinctUntilChanged];
}

/**
 *  验证码按钮是否可点
 */
- (void)validCodeBtn
{
    @weakify(self)
    self.validCodeSignal = [[RACSignal
                             combineLatest:@[RACObserve(self, mobileNo), RACObserve(self, codeBtnTitile)]
                             reduce:^(NSString *mobileNo, NSString *title) {
                                 @strongify(self)
                                 BOOL code = [Utils verifyPhoneNumber:mobileNo] && [title isEqualToString:@"获取验证码"];
                                 
                                 UIColor *color = code ?  BUTTON_NOMAL_COLOR : BUTTON_ENABLE_COLOR;
                                 self.codeBtnBackGroundColor = color;
                                 
                                 return @(code);
                             }] distinctUntilChanged];
}

/**
 *  获取验证码
 */
- (void)getCode
{
    @weakify(self)
    self.getCodeCommand = [[RACCommand  alloc] initWithSignalBlock:^RACSignal *_Nonnull (id _Nullable input) {
        return [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
            @strongify(self)
            
            [self timeHander];
            
            self.dispoable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate *_Nullable x) {
                [self timeHander];
            }];
            
            [subscriber sendNext:@{@"sms" : @"123456"}];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

/**
 *  登录
 */
- (void)login
{
    self.loginCommand = [[RACCommand  alloc] initWithSignalBlock:^RACSignal *_Nonnull (id _Nullable input) {
        return [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
            [Request loginSucess:^(NSDictionary *responseObject) {
                LoginModel *model = [LoginModel modelWithJSON:responseObject];
                
                NSLog(@"%@", model.message);
                
                [subscriber sendNext:model];
                [subscriber sendCompleted];
            } fail:^(NSDictionary *responseObject) {}];
            
            return nil;
        }];
    }];
}

- (void)timeHander
{
    _timeCount--;
    
    if (_timeCount > 0)
    {
        self.codeBtnTitile = [NSString stringWithFormat:@"%ld秒", _timeCount];
    }
    else
    {
        [self.dispoable dispose];
        self.codeBtnTitile = @"获取验证码";
        _timeCount = timeCountNum;
    }
    
    NSLog(@"%ld", _timeCount);
    
    [self.changeTitleSignal sendNext:self.codeBtnTitile];
}

@end
