//
//  SFFactory.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/19.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "SFFactory.h"

@implementation SFPerson

@end

@implementation SFPrimary

@end

@implementation SFUniversity

@end

@implementation SFFactory

+ (SFPerson *)createPersonWithType:(SFFactoryType)type
{
    switch (type)
    {
        case SFFactoryTypePrimary:
            return [[SFPrimary alloc] init];

            break;

        case SFFactoryTypeUniversity:
            return [[SFUniversity alloc] init];

        default:
            break;
    }
}

@end
