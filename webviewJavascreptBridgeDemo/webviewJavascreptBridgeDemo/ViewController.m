//
//  ViewController.m
//  webviewJavascreptBridgeDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"
#import <WebViewJavascriptBridge.h>

@interface ViewController ()
{
    
    UIWebView * web;
}
@property(nonatomic,strong)WebViewJavascriptBridge * bridge;//桥
@property (weak, nonatomic) IBOutlet UIButton *callHanderBtn;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;
@property (weak, nonatomic) IBOutlet UIButton *disableSafetyTimeoutBtn;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    //允许bridge打印日志
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:web];
    
    //设置代理
    [_bridge setWebViewDelegate:self];
    
    //注册方法供js使用
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSLog(@"objectcFunction called :%@",data);
        responseCallback(@"h5调用成功的回调");
    }];
    
    [_bridge callHandler:@"testJavaScriptHandler" data:@{@"foo":@"哈哈哈哈哈"}];
    
    [self addsubViews];
    [self loadTestPage];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

- (void)addsubViews {
     //添加相关的功能按钮
     [self.view insertSubview:self.stackView aboveSubview:web];
}
- (IBAction)callHander:(id)sender {
    
    id data = @{@"greetingFromObjC":@"hi, JS"};
    
    //调用js方法 并且传递参数
    [self.bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id responseData) {
        NSLog(@"testJavascriptHandler responded: %@",responseData);
    }];
}
- (IBAction)reload:(id)sender {
    
    [web reload];
}
- (IBAction)disableSafetyTimeout:(id)sender {
    
    [self.bridge disableJavscriptAlertBoxSafetyTimeout];
}



- (void)loadTestPage {
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    
    NSString * htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSURL * url = [NSURL fileURLWithPath:path];
    
    [web loadHTMLString:htmlStr baseURL:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
