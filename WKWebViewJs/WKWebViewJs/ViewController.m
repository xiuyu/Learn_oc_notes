//
//  ViewController.m
//  WKWebViewJs
//
//  Created by xiuyu on 2019/6/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *wkwebView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.wkwebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    //注册JS方法
    [configuration.userContentController addScriptMessageHandler:self name:@"js_oc"];
    
    self.wkwebView.UIDelegate = self;
    self.wkwebView.navigationDelegate = self;
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"indexIos" withExtension:@"html"];
    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:path]];
    
    [self.view addSubview:self.wkwebView];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@", message.body);
    
    //要求必须在主线程执行JS
    if ([NSThread currentThread].isMainThread)
    {
        [self.wkwebView evaluateJavaScript:[NSString stringWithFormat:@"%@('%@')", @"oc_js", @"1"] completionHandler:nil];
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.wkwebView evaluateJavaScript:[NSString stringWithFormat:@"%@('%@')", @"oc_js", @"1"] completionHandler:nil];
        });
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.wkwebView.configuration.userContentController removeScriptMessageHandlerForName:@"js_oc"];
}

@end
