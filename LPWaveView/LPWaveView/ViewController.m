//
//  ViewController.m
//  LPWaveView
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"
#import "LPWaterWaveView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LPWaterWaveView *lpWaterWave;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lpWaterWave.waveAmlitude = 20.f;
    self.lpWaterWave.waveSpeed = 5.f;
    [self.lpWaterWave wave];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
