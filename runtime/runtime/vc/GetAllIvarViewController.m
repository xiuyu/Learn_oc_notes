//
//  GetAllIvarViewController.m
//  runtime
//
//  Created by 丘秀玉 on 2019/4/15.
//  Copyright © 2019 丘秀玉. All rights reserved.
//

#import "GetAllIvarViewController.h"
#import <objc/runtime.h>

@interface GetAllIvarViewController ()

@end

@implementation GetAllIvarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 250, 50)];
    text.placeholder = @"改变placeholder的颜色为蓝色";
    [text setValue:[UIColor blueColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:text];
    
    [self getAllIvars];
    
    [self getAllMethods];
}

- (void)getAllIvars
{
    unsigned int count = 0;
    //获取所有的属性(包括私有的)
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i < count; i++)
    {
        Ivar ivar = ivars[i];
        
        NSString *name = [NSString stringWithFormat:@"%s", ivar_getName(ivar)];
        
        NSString *type = [NSString stringWithFormat:@"%s", ivar_getTypeEncoding(ivar)];
        
        NSLog(@"ivar name=%@ type=%@", name, type);
    }
}

-(void)getAllMethods
{
    unsigned int count  = 0 ;
    
    //获取所有的方法(包括私有的)
    Method *methods = class_copyMethodList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        
        Method method = methods[i];
        
        SEL sel = method_getName(method);
        
        NSString *name  = [NSString stringWithCString:sel_getName(sel) encoding:NSUTF8StringEncoding];

        NSLog(@"method name=%@",name);
    }
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
