//
//  FFPeron.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/19.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "FFPeron.h"

@implementation FFPeron

- (void)eat
{
    NSLog(@"%s", __func__);
}

- (void)sleep
{
    NSLog(@"%s", __func__);
}

- (FFPeron *)eat2
{
    NSLog(@"%s", __func__);
    return self;
}

- (FFPeron *)sleep2
{
    NSLog(@"%s", __func__);
    return self;
}

- (FFPeron *_Nonnull (^)(void))eat3
{
    NSLog(@"%s", __func__);
    return ^{
               return self;
    };
}

- (FFPeron *_Nonnull (^)(void))sleep3
{
    NSLog(@"%s", __func__);
    return ^{
               return self;
    };
}

@end
