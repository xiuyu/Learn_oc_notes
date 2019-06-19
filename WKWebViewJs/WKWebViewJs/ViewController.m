//
//  ViewController.m
//  WKWebViewJs
//
//  Created by xiuyu on 2019/6/17.
//  Copyright © 2019 xiuyu. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "MyJSObject.h"


@interface ViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler,UIWebViewDelegate>

@property (strong, nonatomic) WKWebView *wkwebView;

@property (strong,nonatomic) UIWebView *webView;

@property (strong,nonatomic) JSContext *context;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //-------- wkwebView ------//
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.wkwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100) configuration:configuration];
    //注册JS方法
    [configuration.userContentController addScriptMessageHandler:self name:@"js_oc"];
    
    self.wkwebView.UIDelegate = self;
    self.wkwebView.navigationDelegate = self;
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"indexIos" withExtension:@"html"];
    [self.wkwebView loadRequest:[NSURLRequest requestWithURL:path]];
    [self.view addSubview:self.wkwebView];
    
    
    //-------- webView ------//
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
    self.webView.delegate = self;
    
    NSURL *path2 = [[NSBundle mainBundle] URLForResource:@"webView" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:path2]];
    self.webView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.webView];
    
}

#pragma WKScriptMessageHandler delegate
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


#pragma UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSLog(@"context=%@",context);
    self.context = context;
   // 为js增加log方法
    context[@"log"] = ^(NSString *str){
        NSLog(@"log:%@",str);
    };
    
    // 为js增加obj对象 遵循该协议jsExport
    MyJSObject *obj = [[MyJSObject alloc] init];
    context[@"obj"] = obj;
  
    
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"异常%@",exception);
    };
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.wkwebView.configuration.userContentController removeScriptMessageHandlerForName:@"js_oc"];
}


@end
