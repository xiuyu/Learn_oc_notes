//
//  ViewController.m
//  mvvm+rac
//
//  Created by xiuyu on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#define  InputViewBackGroundColor [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0]

#import "LoginViewController.h"
#import "masonry.h"
#import "LoginViewModel.h"
#import "HomeViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) UITextField *phoneNumText;

@property (strong, nonatomic) UITextField *phonecodeText;

@property (strong, nonatomic) UIButton *codeBtn;

@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    [self bindViewModel];
}

- (void)bindViewModel
{
    @weakify(self)
    self.viewModel = [[LoginViewModel alloc] init];
    
    //RAC(对象，对象的属性) = (一个信号);
    RAC(self.viewModel, smsCode) = [RACSignal merge:@[RACObserve(self.phonecodeText, text), self.phonecodeText.rac_textSignal]];
    
    RAC(self.viewModel, mobileNo) = [RACSignal merge:@[RACObserve(self.phoneNumText, text), self.phoneNumText.rac_textSignal]];
    
    RAC(self.loginBtn, enabled) = self.viewModel.validLoginSignal;
    
    RAC(self.codeBtn, enabled) = self.viewModel.validCodeSignal;
    
    RAC(self.codeBtn, backgroundColor) = RACObserve(self.viewModel, codeBtnBackGroundColor);
    RAC(self.loginBtn, backgroundColor) = RACObserve(self.viewModel, loginBtnBackGroundColor);
    
    //    RAC(self.codeBtn, titleLabel.text) = RACObserve(self.viewModel, codeBtnTitile);
    
    [self.viewModel.changeTitleSignal subscribeNext:^(id _Nullable x) {
        [self.codeBtn setTitle:x forState:UIControlStateNormal | UIControlStateDisabled];
    }];
    
    /**
     *  [RACObserve(self.viewModel, avatarURL) subscribeNext:^(NSURL *avatarURL) {
     *  @strongify(self)
     *  [self.avatarButton sd_setImageWithURL:avatarURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default-avatar"]];
     *  }];
     */
    
    //获取验证码
    [[self.codeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl *_Nullable x) {
         @strongify(self)
         [self.viewModel.getCodeCommand execute: @{}];
     }];
    
    // 数据成功
    [self.viewModel.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    //登录
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl *_Nullable x) {
         @strongify(self)
         [self.viewModel.loginCommand execute: @{}];
     }];
    
    // 数据成功跳转
    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(LoginModel *model) {
        if (model.code == 0)
        {
            HomeViewController *vc = [[HomeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

- (void)setupUI
{
    UILabel *label = [[UILabel alloc] init];
    
    [self.view addSubview:label];
    label.text = @"短信登录";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:34];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(72));
        make.left.equalTo(@(20));
    }];
    
    //------------手机输入框---------//
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = InputViewBackGroundColor;
    view.layer.cornerRadius = 4;
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(37);
        make.right.equalTo(@(-20));
        make.left.equalTo(@(20));
        make.height.equalTo(@(48));
    }];
    
    UILabel *numLab = [[UILabel alloc] init];
    [view addSubview:numLab];
    numLab.font = [UIFont systemFontOfSize:15];
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.text = @"+86";
    numLab.textColor = [UIColor blackColor];
    
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(@(12));
        make.width.equalTo(@(34));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blackColor];
    [view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 18));
        make.centerY.equalTo(view);
        make.left.equalTo(numLab.mas_right).offset(12);
    }];
    
    //------ 手机号码 ------//
    self.phoneNumText = [[UITextField alloc] init];
    self.phoneNumText.font = [UIFont systemFontOfSize:15];
    self.phoneNumText.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumText.text = @"18718748418";
    [view addSubview:self.phoneNumText];
    self.phoneNumText.placeholder = @"请输入手机号码";
    self.phoneNumText.textColor = [UIColor blackColor];
    self.phoneNumText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *phoneTexbtn = [self.phoneNumText valueForKey:@"_clearButton"];
    [phoneTexbtn setImage:[UIImage imageNamed:@"txt_clear"] forState:UIControlStateNormal];
    
    [self.phoneNumText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(view);
        make.right.equalTo(@(-12));
        make.left.equalTo(line.mas_right).offset(12);
        make.centerY.equalTo(view);
    }];
    
    //----验证码框---//
    UIView *view2 = [[UIView alloc] init];
    view2.layer.cornerRadius = 4;
    view2.backgroundColor = InputViewBackGroundColor;
    [self.view addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(218, 48));
        make.left.equalTo(@(20));
        make.top.equalTo(view.mas_bottom).offset(12);
        make.right.equalTo(self.view).offset(-165);
    }];
    
    //------ 验证码按钮 ------//
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeBtn.layer.cornerRadius = 4;
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.codeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.codeBtn.backgroundColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
    [self.view addSubview:self.codeBtn];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 48));
        make.centerY.equalTo(view2);
        make.left.equalTo(view2.mas_right).offset(12);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    UILabel *codeLab = [[UILabel alloc] init];
    [view2 addSubview:codeLab];
    codeLab.font = [UIFont systemFontOfSize:15];
    codeLab.text = @"验证码";
    codeLab.textColor = [UIColor blackColor];
    
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2);
        make.left.equalTo(@(12));
    }];
    
    //------ 验证码 ------//
    self.phonecodeText = [[UITextField alloc] init];
    self.phonecodeText.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:self.phonecodeText];
    self.phonecodeText.keyboardType = UIKeyboardTypeNumberPad;
    self.phonecodeText.placeholder = @"输入验证码";
    self.phonecodeText.text = @"123456";
    self.phoneNumText.textColor = [UIColor blackColor];
    
    [self.phonecodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 21));
        make.left.equalTo(line.mas_right).offset(12);
        make.centerY.equalTo(view2);
    }];
    
    //------ 登录 ------//
    self.loginBtn = [[UIButton alloc] init];
    self.loginBtn.layer.cornerRadius = 4;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.loginBtn.backgroundColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
    [self.view addSubview:self.loginBtn];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom).offset(20);
        make.right.equalTo(@(-20));
        make.left.equalTo(@(20));
        make.height.equalTo(@(48));
    }];
}

@end
