//
//  ViewController.m
//  MCBarchartViewDemo
//
//  Created by apple on 2017/4/17.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"
#import "MCBarChartView.h"
#import "GITShowRateView.h"
@interface ViewController ()<MCBarChartViewDelegate,MCBarChartViewDataSource>
@property (weak, nonatomic) IBOutlet MCBarChartView *mcBarChatView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet MCBarChartView *mcBarChartNegative;
@property(nonatomic,strong)GITShowRateView * showRateView;//收益率
@property(nonatomic,assign)CGFloat maxYvalue;//最大的数值
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray;
    self.mcBarChatView.maxYvalue = self.maxYvalue;
    self.mcBarChatView.delegate = self;
    self.mcBarChatView.dataSource = self;
    self.mcBarChatView.showXAxisDecorationElement = NO;
    self.mcBarChatView.showYAxisLabels = NO;
    self.mcBarChatView.barColor = [UIColor redColor];
   self.mcBarChatView.backBarColor = [[UIColor redColor] colorWithAlphaComponent:0.04];
    self.mcBarChatView.yAxisLabelHeightPercentage = 0.5;
    self.mcBarChatView.interBarSpace = 5;
    self.mcBarChatView.showXAxisLabels = NO;
    
    
    
    self.mcBarChartNegative.maxYvalue = self.maxYvalue;
    self.mcBarChartNegative.delegate = self;
    self.mcBarChartNegative.dataSource = self;
    self.mcBarChartNegative.showXAxisLabels = YES;
    self.mcBarChartNegative.showYAxisLabels = NO;
    self.mcBarChartNegative.showXAxisDecorationElement = NO;
    self.mcBarChartNegative.barColor = [UIColor greenColor];
    self.mcBarChartNegative.backBarColor= [[UIColor greenColor] colorWithAlphaComponent:0.1];
    self.mcBarChatView.interBarSpace = 5;
    
}
#pragma mark -- MCbarChartViewDataSource

/*
 Asks the data source to return the number of bars in the bar chart.
 */
- (NSInteger)numberOfBarsInBarChartView:(MCBarChartView*)barChartView
{
    
    return  self.dataArray.count;
}

/*
 Asks the data source the value of each bar in the bar chart.
 */

- (CGFloat)barCharView:(MCBarChartView*)barChartView valueForBarAtIndex:(NSInteger)index
{
    
    if (barChartView == self.mcBarChatView&&[self.dataArray[index] floatValue]>0) {
         return [self.dataArray[index] floatValue];
    }else if (barChartView == self.mcBarChartNegative&&[self.dataArray[index]floatValue]<0){
          return  [self.dataArray[index] floatValue];
    }
    
    return 0;
}

- (UIColor *)barCharView:(MCBarChartView *)barChartView colorForBarAtIndex:(NSInteger)index
{
    if ([self.dataArray[index] floatValue]>0&&barChartView == self.mcBarChatView) {
        return [UIColor redColor];
    }
    
    if ([self.dataArray[index] floatValue]<0&&barChartView == self.mcBarChartNegative) {
        return [UIColor greenColor];
    }
    
    return nil;
}


#pragma mark -- MCBarChartDelegate

- (void)barChartView:(MCBarChartView*)barChartView didSelectBarAtIndex:(NSInteger)index{
    
    NSLog(@"点击了第%ld个柱状图收益率是%.f",index,[self.dataArray[index] floatValue]);
    
    CGFloat width = barChartView.frame.size.width;
    CGFloat height = barChartView.frame.size.height;
    CGFloat everyWidth = width/12;
    CGFloat LEFTWIDTH = 15;
    CGFloat y = height- 12;
        if (_showRateView == nil) {
        _showRateView = [[GITShowRateView alloc]initWithLineChartWidth:width lineChartHeight:height trianglePoint:CGPointMake(index * everyWidth + LEFTWIDTH, y) rate:[self.dataArray[index] floatValue]];
        _showRateView.backgroundColor = [UIColor clearColor];
        _showRateView.layer.cornerRadius = 1;
        _showRateView.layer.masksToBounds = YES;
        
    }
    else{
        _showRateView.lineChartWidth = width;
        _showRateView.lineChartHeight = height;
        _showRateView.rate = [self.dataArray[index] floatValue];
        _showRateView.trianglePoint = CGPointMake(index * everyWidth + LEFTWIDTH, y);
        [_showRateView settriangleOrientation];
        [_showRateView setNeedsDisplay];
        

    }
    [self.mcBarChatView addSubview:_showRateView];

}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [@[@(-6),@(0.6),@(0.25),@(-0.27),@(-89.2),@(4.92),@(-0.12),@(2.76),@(-1.81),@(0),@(1),@(0.25)]mutableCopy];
        self.maxYvalue = 89.2;
    }
    
    return _dataArray;
}
@end
