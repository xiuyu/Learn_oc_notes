//
//  People.m
//  runtime
//
//  Created by xiuyu on 2019/4/16.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>
#import "Fish.h"
#import "Student.h"

@implementation People

- (void)game
{
    NSLog(@"people play game");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(test))
    {
        //动态添加方法
        Method other = class_getInstanceMethod(self, @selector(game));

        /**
         *    第一个参数： cls:给哪个类添加方法
         *    第二个参数： SEL name:添加方法的名称
         *    第三个参数： IMP imp: 方法的实现，函数入口，函数名可与方法名不同（建议与方法名相同）
         *    第四个参数： types :方法类型，需要用特定符号，参考API
         */
        class_addMethod(self, sel, method_getImplementation(other), "V@:");
        
      
        
        return YES;
    }

    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    //询问其他对象处理sel
    Student *s = [[Student alloc] init];

    if ([s respondsToSelector:aSelector])
    {
        return s;
    }

    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(swim))
    {
        /**signatureWithObjCTypes
         *  void 返回值类型
         *  @ _cmd
         */
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }

    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if (anInvocation.selector == @selector(swim))
    {
        Fish *fish = [[Fish alloc] init];
        [anInvocation invokeWithTarget:fish];
    }
}



- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    [super doesNotRecognizeSelector:aSelector];
}

@end
