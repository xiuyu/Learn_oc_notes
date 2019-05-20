//
//  MsgTransViewController.m
//  runtime
//
//  Created by xiuyu on 2019/4/15.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "MsgTransViewController.h"
#import "People.h"

@interface MsgTransViewController ()

@end

@implementation MsgTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    People *p = [[People alloc] init];
    [p performSelector:@selector(game) withObject:nil];
    [p performSelector:@selector(learn) withObject:nil];
    [p performSelector:@selector(swim) withObject:nil];
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
