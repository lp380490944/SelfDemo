//
//  ViewController.m
//  核心动画demo
//
//  Created by apple on 2017/1/12.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [UIImage imageNamed:@"close"];
    self.layerView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
