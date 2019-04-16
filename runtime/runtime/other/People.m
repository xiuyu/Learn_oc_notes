//
//  People.m
//  runtime
//
//  Created by 丘秀玉 on 2019/4/16.
//  Copyright © 2019 丘秀玉. All rights reserved.
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
    if (sel == @selector(game))
    {
        //动态添加方法
        class_addMethod(self, @selector(game), [self methodForSelector:sel], "V@:");
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

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if (anInvocation.selector == @selector(swim))
    {
        Fish *fish = [[Fish alloc] init];
        [anInvocation invokeWithTarget:fish];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if (aSelector == @selector(swim))
    {
        /**signatureWithObjCTypes
         void 返回值类型
         @ _cmd
         */
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    [super doesNotRecognizeSelector:aSelector];
}

@end
