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

static const NSTimeInterval timeCountNum = 20;

@interface LoginViewModel ()
{
    NSInteger _timeCount;
}

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) RACSignal *dispoable;

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
        
        
        @weakify(self)
        //登录按钮是否可点
        self.validLoginSignal = [[RACSignal
                                  combineLatest:@[RACObserve(self, mobileNo), RACObserve(self, smsCode)]
                                  reduce:^(NSString *mobileNo, NSString *smsCode) {
                                      @strongify(self)
                                      
                                      BOOL login = [Utils verifyPhoneNumber:mobileNo] && smsCode.length > 5;
                                      
                                      UIColor *textColor = login ?[UIColor colorWithRed:255 / 255.0 green:151 / 255.0 blue:0 / 255.0 alpha:1.0] :[UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
                                      self.loginBtnBackGroundColor = textColor;
                                      
                                      return @(login);
                                  }] distinctUntilChanged];
        
        //验证码按钮是否可点
        self.validCodeSignal = [[RACSignal
                                 combineLatest:@[RACObserve(self, mobileNo),RACObserve(self, codeBtnTitile)]
                                 reduce:^(NSString *mobileNo,NSString *title) {
                                     @strongify(self)
                                     BOOL code = [Utils verifyPhoneNumber:mobileNo] && [title isEqualToString:@"获取验证码"];
                                     
                                     UIColor *textColor = code ?[UIColor colorWithRed:255 / 255.0 green:151 / 255.0 blue:0 / 255.0 alpha:1.0] :[UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
                                     self.codeBtnBackGroundColor = textColor;
                                     
                                     return @(code);
                                 }] distinctUntilChanged];
        
        //获取验证码
        self.getCodeCommand = [[RACCommand  alloc] initWithSignalBlock:^RACSignal *_Nonnull (id _Nullable input) {
            return [RACSignal createSignal:^RACDisposable *_Nullable (id <RACSubscriber> _Nonnull subscriber) {
                @strongify(self)
                
                [self timeHander];
                //倒计时
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *_Nonnull timer) {
                    [self timeHander];
                }];
                
                [subscriber sendNext:@{@"sms" : @"123456"}];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        
        //登录
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
    return self;
}

- (void)timeHander
{
    _timeCount--;
    
    if (_timeCount > 0)
    {
        self.codeBtnTitile = [NSString stringWithFormat:@"%ld秒", _timeCount];
//        NSLog(@"%@ %@",[NSThread currentThread], self.codeBtnTitile);
    }
    else
    {
        [self.timer invalidate];
        self.timer = nil;
        self.codeBtnTitile = @"获取验证码";
        _timeCount = timeCountNum;
    }
    
    [self.changeTitleSignal sendNext:self.codeBtnTitile];
}

@end
