//
//  PNChartViewController.h
//  PNchartDemo
//
//  Created by apple on 2017/4/7.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PNChart.h>

@interface PNChartViewController : UIViewController
@property(nonatomic,strong)PNLineChart * lineChart;//趋势图
@property(nonatomic,strong)PNBarChart * barChart;//柱状图
@property(nonatomic,strong)PNCircleChart * circleChart;//环形图
@property(nonatomic,strong)PNPieChart * pieChart;//饼状图
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
