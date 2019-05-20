//
//  MyTextField.h
//  iOS_UI
//
//  Created by xiuyu on 2018/7/11.
//  Copyright © 2018年 xiuyu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MyTextField;

@protocol MyTextFieldDelegate <NSObject>

/**
 *  监听删除
 *  @param string 被删除的字符串
 */
- (void)textFieldDidDelete:(MyTextField *)textField withString:(NSString *)string;
@end


@interface MyTextField : UITextField

@property (nonatomic, weak) id <MyTextFieldDelegate> myCustomDelegate;

@end
