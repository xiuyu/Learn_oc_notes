//
//  AFFactory.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/19.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "AFFactory.h"

@implementation AFPerson

@end

@implementation AFPrimary

@end

@implementation AFUniversity

@end

@implementation AFFactory
+ (AFPerson *)createPerson
{
    return [[AFPerson alloc] init];
}

+ (AFPerson *)createPersonWithType:(AFFactoryType)type
{
    switch (type)
    {
        case AFFactoryTypePriMary:
            return [AFPrimaryFactory createPerson];

            break;

        case AFFactoryTypeUniversity:
            return [AFUniversityFactory createPerson];

            break;

        default:
            break;
    }
}

@end

@implementation AFPrimaryFactory

+ (AFPerson *)createPerson
{
    return [[AFPrimary alloc] init];
}

@end

@implementation AFUniversityFactory

+ (AFPerson *)createPerson
{
    return [[AFUniversity alloc] init];
}

@end
