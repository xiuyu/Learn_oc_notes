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
    
    NSArray *array = @[@1,@5,@7];
    
    [array objectAtIndex:2];
    
    [array objectAtIndex:4];
}

+(void)load
{
    swizzleMethod([self class], @selector(viewWillAppear:), @selector(swizzle_viewWillAppear:));
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzleSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);
    
    // 添加方法
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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"%s%@",__func__,NSStringFromSelector(_cmd));
}

-(void)swizzle_viewWillAppear:(BOOL)animated
{
    //調用原方法
    [self swizzle_viewWillAppear:animated];

    NSLog(@"%s%@",__func__,NSStringFromSelector(_cmd));
}

/*
 #pragma mark - Navigation
 *
 *  // In a storyboard-based application, you will often want to do a little preparation before navigation
 *  - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 *   // Get the new view controller using [segue destinationViewController].
 *   // Pass the selected object to the new view controller.
 *  }
 */

@end
