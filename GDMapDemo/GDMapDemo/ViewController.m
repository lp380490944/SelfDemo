//
//  ViewController.m
//  GDMapDemo
//
//  Created by apple on 2016/12/7.
//  Copyright © 2016年 bluceLiu. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
@interface ViewController ()
@property(nonatomic,strong)MAMapView * mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.mapType = MAMapTypeStandard;
    //是否显示实时路况
    _mapView.showTraffic = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    [self.view addSubview:_mapView];
    [self initNavSetting];
}

- (void)initNavSetting {
    /*
     MAMapTypeStandard = 0,  // 普通地图
     MAMapTypeSatellite,     // 卫星地图
     MAMapTypeStandardNight, // 夜间视图
     MAMapTypeNavi,          // 导航视图
     MAMapTypeBus            // 公交视图
     */
    UISegmentedControl * segmetedControll = [[UISegmentedControl alloc] initWithItems:@[@"标准",@"卫星",@"导航视图"]];
    segmetedControll.selectedSegmentIndex = 0;
    segmetedControll.frame = CGRectMake(0, 0, 100, 30);
    self.navigationItem.titleView = segmetedControll;
    [segmetedControll addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    //是否展示实时路况的开关.
    UISwitch * swic = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    swic.on = YES;
    [swic addTarget:self action:@selector(swichValueChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:swic];
}
- (void)swichValueChange:(UISwitch *)swic
{
    self.mapView.showTraffic = swic.isOn;
 
}
- (void)segmentedControlValueDidChange:(UISegmentedControl *)segmentedcontrol
{

    switch (segmentedcontrol.selectedSegmentIndex) {
        case 0:{
            self.mapView.mapType = MAMapTypeStandard;
            break;
        }
        case 1:{
            self.mapView.mapType = MAMapTypeSatellite;
            break;
        }
        case 2:{
            self.mapView.mapType = MAMapTypeNavi;
            break;
        }
        default:
            break;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
