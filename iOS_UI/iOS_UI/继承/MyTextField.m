//
//  MyTextField.m
//  iOS_UI
//
//  Created by xiuyu on 2018/7/11.
//  Copyright © 2018年 xiuyu. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

// 禁止粘贴
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    if (menuController)
    {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    
    return NO;
}

- (void)deleteBackward
{
    NSString *stringBefore = self.text;
    
    [super deleteBackward];
    NSString *stringReplaced = [stringBefore stringByReplacingOccurrencesOfString:self.text withString:@""];

    [self.myCustomDelegate textFieldDidDelete:self withString:stringReplaced];
}

@end
