//
//  ViewController.m
//  dateDemo
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:1493291062];//时间戳10位
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    
   NSLog(@"%@",[df stringFromDate:date]) ;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
