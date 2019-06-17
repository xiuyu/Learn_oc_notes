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
    mobileNum = [mobileNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *pattern = @"^1\\d{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    return isMatch;
}

+ (BOOL)verifyIdentifyCard:(NSString *)idNum
{
    if (idNum.length < 18)
    {
        return NO;
    }
    
    NSMutableArray *idArray = [NSMutableArray array];
    
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [idNum substringWithRange:range];
        [idArray addObject:subString];
    }
    
    // 系数数组
    NSArray *coefficientArray = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @"2"];
    
    // 余数数组
    NSArray *remainderArray = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    
    for (int i = 0; i < 17; i++)
    {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [idArray[i] intValue];
        sum += coefficient * ID;
    }
    
    // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
    
    // 身份证号码最后一位
    NSString *string = [idNum substringFromIndex:17];
    
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    return [str isEqualToString:string];
}


+ (BOOL)verifyPasswordQualified:(NSString *)pwd
{
    NSString *pattern = @"^(?=.*?[0-9])(?=.*?[A-Za-z])([\\w!\"#$%&'()*+,\\\\/\\-.:;<=>?@\\[\\]^_`{|}~]{8,32})";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [pred evaluateWithObject:pwd];
    
    return isMatch;
}


+ (BOOL)verifyPaypwdQualified:(NSString *)pwd
{
    NSString *pattern = @"^\\d{6}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [pred evaluateWithObject:pwd];
    
    return isMatch;
}

@end
