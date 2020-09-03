//
//  WKWebViewCacheViewController.m
//  WKWebViewJs
//
//  Created by 丘秀玉 on 2020/3/18.
//  Copyright © 2020 xiuyu. All rights reserved.
//

#import "WKWebViewCacheViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewCacheViewController () <WKUIDelegate, WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *wkWebView;

@property (strong, nonatomic) NSString *lastModified;

@property (strong, nonatomic) NSString *url;

@end

@implementation WKWebViewCacheViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.url = @"https://juejin.im/post/5d76162bf265da03b120738d";

    self.lastModified = [[NSUserDefaults standardUserDefaults] objectForKey:@"Last-Modified"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];

    if (self.lastModified)
    {
        [request setValue:self.lastModified forHTTPHeaderField:@"If-Modified-Since"];
    }

    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.wkWebView loadRequest:request];

    [self.view addSubview:self.wkWebView];

//    [self example];

    
}

- (void)clear
{
    //清除cookie
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];

    for (NSHTTPCookie *cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }

    //清除cache
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"start");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"finish");
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"redirect");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//    navigationAction.request.URL.absoluteString;
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;

    NSLog(@"%@", response);

    self.lastModified = response.allHeaderFields[@"Last-Modified"];

    [[NSUserDefaults standardUserDefaults] setValue:self.lastModified forKey:@"Last-Modified"];

    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)example
{
    NSURL *url = [[NSURL alloc] initWithString:@"http://via.placeholder.com/50x50.jpg"];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    request.cachePolicy = NSURLRequestReloadRevalidatingCacheData;

    self.lastModified = [[NSUserDefaults standardUserDefaults] objectForKey:@"Last-Modified"];

    if (self.lastModified)
    {
        [request setValue:self.lastModified forHTTPHeaderField:@"If-Modified-Since"];
    }

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        if (error)
        {
            NSLog(@"error warning : %@", error);
        }
        else
        {
            NSData *temp = data;
//            NSString *responseStr = [[NSString alloc] initWithData:temp encoding:NSUTF8StringEncoding];

            NSLog(@"2::%@", response);

            [[NSUserDefaults standardUserDefaults] setValue:self.lastModified forKey:@"Last-Modified"];
            self.lastModified = [(NSHTTPURLResponse *) response allHeaderFields][@"Last-Modified"];
        }
    }] resume];
}

@end
