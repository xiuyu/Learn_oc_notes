//
//  ViewController.m
//  MVP
//
//  Created by 丘秀玉 on 2020/3/12.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "ViewController.h"
#import "LoginPresenter.h"

@interface ViewController () <LoginProtocol>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    LoginPresenter *presenter = [[LoginPresenter alloc] init];
    presenter.delegate = self;

    [presenter featchData];
}

- (void)userViewDataSource:(LoginModel *)data
{
    NSLog(@"get user data");
}

- (void)showIndicator
{
    NSLog(@"showIndicator");
}

- (void)hideIndicator
{
    NSLog(@"hideIndicator");
}

- (void)showEmptyView {
    
}

@end
