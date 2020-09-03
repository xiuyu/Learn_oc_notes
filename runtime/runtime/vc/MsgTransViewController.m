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
    [p performSelector:@selector(test) withObject:nil];
    [p performSelector:@selector(learn) withObject:nil];
    [p performSelector:@selector(swim) withObject:nil];
}



@end
