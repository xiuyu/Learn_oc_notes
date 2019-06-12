//
//  NSArray+carsh.m
//  runtime
//
//  Created by xiuyu on 2019/4/16.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "NSArray+carsh.h"
#import <objc/runtime.h>

@implementation NSArray (carsh)

+ (void)load
{
    //类族
    Class cls = objc_getClass("__NSArrayI");
    
    Method originalMethod = class_getInstanceMethod(cls, @selector(objectAtIndex:));
    
    Method swizzelMethod = class_getInstanceMethod(cls, @selector(swizzle_objectAtIndex:));
    
    BOOL add = class_addMethod(cls, @selector(swizzle_objectAtIndex:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    
    if (add)
    {
        class_replaceMethod(cls, @selector(objectAtIndex:), method_getImplementation(swizzelMethod), method_getTypeEncoding(swizzelMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzelMethod);
    }
}

- (id)swizzle_objectAtIndex:(NSInteger)index
{
    if (self.count - 1 < index)
    {
        @try {
            return [self swizzle_objectAtIndex:index];
        } @catch(NSException *exception) {
            //打印崩溃信息
            NSLog(@"%s Crash Because Method %s", class_getName([self class]), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {}
    }
    else
    {
        return [self swizzle_objectAtIndex:index];
    }
}

@end
