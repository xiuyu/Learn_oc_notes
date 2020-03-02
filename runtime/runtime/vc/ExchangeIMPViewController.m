//
//  ExchangeIMPViewController.m
//  runtime
//
//  Created by xiuyu on 2019/4/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ExchangeIMPViewController.h"
#import <objc/runtime.h>
#import "NSArray+carsh.h"

@interface ExchangeIMPViewController ()

@end

@implementation ExchangeIMPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[@1, @5, @7];
    
    [array objectAtIndex:2];
    
    [array objectAtIndex:4];
}

+ (void)load
{
    swizzleMethod([self class], @selector(viewWillAppear:), @selector(swizzle_viewWillAppear:));
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzleSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);
    
    /**添加方法
     *  Class cls: 将要给添加方法的类，传的类型 ［类名  class］
     *  SEL name: 将要添加的方法名，传的类型   @selector(方法名)
     *  IMP imp：实现这个方法的函数 ，C语言写法：（IMP）方法名  class_getMethodImplementation(self,@selector(方法名：))
     *  const char *types：表示我们要添加的方法的返回值和参数 "v@:@"：v：是添加方法无返回值    @表示是id(也就是要添加的类) ：表示添加的方法类型  @表示：参数类型
     **/
    
    
    /**
        我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
        而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
        所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
        */
    BOOL add = class_addMethod(class, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    

    
    
    //如果有替換
    if (add)
    {
        class_replaceMethod(class, swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%s%@", __func__, NSStringFromSelector(_cmd));
}

- (void)swizzle_viewWillAppear:(BOOL)animated
{
    //調用原方法
    [self swizzle_viewWillAppear:animated];
    
    NSLog(@"%s%@", __func__, NSStringFromSelector(_cmd));
}

@end
