//
//  Request.m
//  mvvm+rac
//
//  Created by 丘秀玉 on 2019/5/28.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "Request.h"

@implementation Request

+ (void)loginSucess:(void (^)(NSDictionary *))sucess fail:(void (^)(NSDictionary *))fail
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"login" ofType:@"json"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    !sucess ? : sucess(response);
}

@end
