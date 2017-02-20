//
//  ViewController.m
//  block内存测试
//
//  Created by apple on 2017/1/10.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * testArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    __block NSInteger foo = 100;
    
    void (^testBlock)() = ^{
      
        [testArray addObject:@"99"];
        
        foo = 50;
    };
    testBlock();
    NSLog(@"%@",testArray);
    NSLog(@"%ld",foo);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
