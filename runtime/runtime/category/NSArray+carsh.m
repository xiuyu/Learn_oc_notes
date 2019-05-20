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
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(swizzle_objectAtIndex:));
    
    method_exchangeImplementations(fromMethod, toMethod);
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
