//
//  DiscoveryWebController.m
//  tongbanjieDemo
//
//  Created by apple on 2017/1/22.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "DiscoveryWebController.h"

@interface DiscoveryWebController ()
@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation DiscoveryWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webInit];
}
- (void)webInit {
    
    NSURL * url = [NSURL URLWithString:@"https://m.tongbanjie.com/universal/discovery/index.html?targetfrom=app"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    [self.web loadRequest:request];
    self.web.scalesPageToFit = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
