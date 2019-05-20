//
//  NSObject+Pros.m
//  runtime
//
//  Created by xiuyu on 2019/4/16.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "NSObject+Pros.h"
#import <objc/runtime.h>

static const char *key = "name";

@implementation NSObject (Pros)

//分类中声明name系统只会声明set和get方法，而不会在.m中去实现set和get方法，因此导致了程序崩溃

- (void)setName:(NSString *)name
{
    /*  让这个字符串与当前对象产生联系
     *  _name = name;
     *  object:给哪个对象添加属性
     *  key:属性名称
     *  value:属性值
     *  policy:保存策略
     */
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, key);
}

@end
