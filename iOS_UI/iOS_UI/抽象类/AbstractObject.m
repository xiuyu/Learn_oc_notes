//
//  AbstractObjec.m
//  iOS_UI
//
//  Created by 丘秀玉 on 2020/3/12.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "AbstractObject.h"

@implementation AbstractObject

- (instancetype)init
{
    if ([self isMemberOfClass:[AbstractObject class]])
    {
        [self doesNotRecognizeSelector:_cmd];
        return nil;
    }
    else
    {
        return [super init];
    }
}

- (id)abstractObject:(id)obj
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
