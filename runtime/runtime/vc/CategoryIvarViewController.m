//
//  CategoryIvarViewController.m
//  runtime
//
//  Created by xiuyu on 2019/4/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "CategoryIvarViewController.h"
#import "NSObject+Pros.h"

@interface CategoryIvarViewController ()

@end

@implementation CategoryIvarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSObject *obj = [[NSObject alloc] init];
    obj.name = @"xiuyu";
    
    NSLog(@"name=%@",obj.name);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
