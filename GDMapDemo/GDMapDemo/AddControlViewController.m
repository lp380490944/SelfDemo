//
//  AddControlViewController.m
//  GDMapDemo
//
//  Created by apple on 2016/12/8.
//  Copyright © 2016年 bluceLiu. All rights reserved.
//

#import "AddControlViewController.h"

@interface AddControlViewController ()<MAMapViewDelegate>
@property(nonatomic,strong)MAMapView * mapView;
@property(nonatomic,strong)UIButton * gpsBtn;
@end

@implementation AddControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    [self addZoomViewAndUserLocationBtn];
}
- (void)addZoomViewAndUserLocationBtn {
    
    self.gpsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    
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
