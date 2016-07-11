//
//  CuponViewController.m
//  HotpepperAPIApp
//
//  Created by Minami Kyohei on 2016/07/11.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "CuponViewController.h"
#import <WebKit/WebKit.h>

@interface CuponViewController () <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
@end

@implementation CuponViewController

- (void)loadView {
    [super viewDidLoad];
    
    [super loadView];
    
    // WKWebView インスタンスの生成
    self.webView = [WKWebView new];
    
    // Auto Layout の設定
    // 画面いっぱいに WKWebView を表示するようにする
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:self.webView
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1.0
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:self.webView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.0
                                                              constant:0]
                                ]];
    
    // デリゲートにこのビューコントローラを設定する
    self.webView.navigationDelegate = self;
    
    // フリップでの戻る・進むを有効にする
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    // WKWebView インスタンスを画面に配置する
    [self.view insertSubview:self.webView atIndex:0];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // WKWebView インスタンスのプロパティの変更を監視する
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    
    // 初回画面表示時にIntialURLで指定した Web ページを読み込む
    NSURL *url = [NSURL URLWithString: self.cuponStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
