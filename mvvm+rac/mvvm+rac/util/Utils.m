//
//  Utils.m
//  mvvm+rac
//
//  Created by xiuyu on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (BOOL)verifyPhoneNumber:(NSString *)mobileNum
{
    NSString *pattern = @"^1\\d{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    return isMatch;
}

@end
