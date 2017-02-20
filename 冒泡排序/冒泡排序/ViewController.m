//
//  ViewController.m
//  冒泡排序
//
//  Created by apple on 2017/2/13.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray * array = @[@100,@44,@99,@88,@75,@30].mutableCopy;
    
    for (int i = 0; i < array.count; i++) {
        
        for (int j = 0; j < array.count - i - 1; j++) {
            
            if ([array[j] integerValue] > [array[j+1] integerValue]) {
                
                NSInteger temp = [array[j+1] integerValue];
                [array replaceObjectAtIndex:j+1 withObject:[array objectAtIndex:j]];
                [array replaceObjectAtIndex:j withObject:@(temp)];
                
            }
            
        }
    }
    
    NSLog(@"%@",array);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
