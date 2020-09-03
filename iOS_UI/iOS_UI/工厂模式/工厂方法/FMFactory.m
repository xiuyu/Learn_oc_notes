//
//  FMFactory.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/19.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "FMFactory.h"

@implementation FMPerson

@end

@implementation FMPrimary

@end

@implementation FMUniversity

@end

@implementation FMFactory

+ (FMPerson *)createPerson
{
    return [[FMPerson alloc] init];
}

@end

@implementation FMPrimaryFactory

+ (FMPerson *)createPerson
{
    return [[FMPrimary alloc] init];
}

@end

@implementation FMUniversityFactory

+ (FMPerson *)createPerson
{
    return [[FMUniversity alloc] init];
}

@end
