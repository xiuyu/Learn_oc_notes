//
//  PayView.m
//  iOS_UI
//
//  Created by xiuyu on 2019/5/20.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "PayView.h"
#import "masonry.h"
#import "MyTextField.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PayView () <MyTextFieldDelegate, UITextFieldDelegate>
{
    NSInteger _resPay;
}

@property (strong, nonatomic) MyTextField *tempPayTextField;

@property (strong, nonatomic) NSMutableArray *mytxtArray;

@property (strong, nonatomic) NSString *pwd;

@property (copy, nonatomic) PayViewResultBlock payViewResultBlock;

@end

@implementation PayView

+ (instancetype)showPayViewWithTitle:(NSString *)title buttonClickBolck:(PayViewResultBlock)block
{
    PayView *payView = [[PayView alloc] initPayViewWithTitle:title buttonClickBolck:block];
    
    [[UIApplication sharedApplication].delegate.window addSubview:payView];
    
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(payView.superview);
    }];
    
    return payView;
}

- (instancetype)initPayViewWithTitle:(NSString *)title buttonClickBolck:(PayViewResultBlock)block
{
    if (self = [super init])
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.payViewResultBlock = block;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMbView:)];
        [self addGestureRecognizer:tap];
        
        self.tempPayTextField = [[MyTextField alloc] init];
        self.tempPayTextField.delegate = self;
        self.tempPayTextField.myCustomDelegate = self;
        self.tempPayTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.tempPayTextField];
       
        
        self.tempPayTextField.inputAccessoryView = [self accessoryView];
        [self.tempPayTextField becomeFirstResponder];
    }
    
    return self;
}

- (UIView *)accessoryView
{
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 133)];
    accessoryView.backgroundColor = [UIColor whiteColor];
    
    //--------- title ----------//
    UILabel *titleLab = [[UILabel alloc] init];
    
    titleLab.text = @"输入支付密码";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:17];
    [accessoryView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(11);
        make.centerX.equalTo(accessoryView);
    }];
    
    //--------- close ----------//
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [accessoryView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.right.equalTo(@(-18));
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    //--------- line ----------//
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [accessoryView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(titleLab.mas_bottom).offset(11);
        make.width.equalTo(accessoryView);
        make.height.mas_equalTo(0.5);
    }];
    
    //--------- 输入框 ----------//
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.spacing = 10;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [accessoryView addSubview:stackView];
    
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(25);
        make.left.mas_offset(37);
        make.right.mas_offset(-37);
    }];
    
    self.mytxtArray = [[NSMutableArray alloc] initWithCapacity:6];
    
    for (int i = 0; i < 6; i++)
    {
        MyTextField *text = [[MyTextField alloc] init];
        text.layer.borderWidth = 1;
        text.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        text.layer.cornerRadius = 4;
        text.keyboardType = UIKeyboardTypeNumberPad;
        text.returnKeyType = UIReturnKeyDone;
        text.tintColor = [UIColor clearColor];
        text.textAlignment = NSTextAlignmentCenter;
        text.secureTextEntry = YES;
        text.font = [UIFont systemFontOfSize:30];
        [stackView addArrangedSubview:text];
        [self.mytxtArray addObject:text];
        
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(text.mas_width);
        }];
    }
    
    return accessoryView;
}

#pragma textFieldDelegate
- (void)textFieldDidDelete:(MyTextField *)textField withString:(NSString *)string
{
    NSLog(@"did success delete [%@]", string);
    NSLog(@"temp33:::%@", self.tempPayTextField.text);
    
    MyTextField *txt = self.mytxtArray[self.tempPayTextField.text.length];
    txt.text = @"";
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (![textField isEqual:self.tempPayTextField])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *result = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSLog(@"result:::%@", result);
    
    if ([textField isEqual:self.tempPayTextField])
    {
        if (![string isEqualToString:@""])
        {
            if (string.length == 1)
            {
                MyTextField *txt = self.mytxtArray[result.length - 1];
                txt.text = string;
                
                if (result.length == 6)
                {
                    if (_resPay == 0)
                    {
                        _resPay = 1;
                        self.pwd = result;
                        [self performSelector:@selector(pay) withObject:nil afterDelay:0.2];
                    }
                    
                    return NO;
                }
            }
            else
            {
                return NO;
            }
        }
    }
    
    return YES;
}

- (void)pay
{
    !self.payViewResultBlock ? : self.payViewResultBlock(1, self.pwd);
    
    [self endEditing:YES];
    [self removeFromSuperview];
}

- (void)closeBtnClick:(UIButton *)sender
{
    !self.payViewResultBlock ? : self.payViewResultBlock(0, @"");
    
    [self endEditing:YES];
    [self removeFromSuperview];
}

- (void)tapMbView:(UITapGestureRecognizer *)tap
{
    !self.payViewResultBlock ? : self.payViewResultBlock(0, @"");
    
    [self endEditing:YES];
    
    [self removeFromSuperview];
}

- (void)dealloc
{
    NSLog(@"pay delloc");
}

@end
