//
//  PNChartViewController.m
//  PNchartDemo
//
//  Created by apple on 2017/4/7.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "PNChartViewController.h"

@interface PNChartViewController ()<PNChartDelegate>

@end

@implementation PNChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.title isEqualToString:@"LineChart"]) {
        
        self.titleLabel.text = @"Line Chart";
        self.lineChart.backgroundColor = [UIColor whiteColor];
        self.lineChart.yGridLinesColor = [UIColor grayColor];
        [self.lineChart.chartData enumerateObjectsUsingBlock:^(PNLineChartData *obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            obj.pointLabelColor = [UIColor blackColor];
            
        }];
        self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135,SCREEN_WIDTH,200)];
        self.lineChart.showCoordinateAxis = YES;
        self.lineChart.yLabelFormat = @"%1.1f";
        self.lineChart.xLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:8.0];
        [self.lineChart setXLabels:@[@"STEP 1",@"STEP 2",@"STEP 3",@"STEP 4",@"STEP 5",@"STEP 6"]];
        self.lineChart.yLabelColor = [UIColor blackColor];
        self.lineChart.xLabelColor = [UIColor blackColor];
        
        self.lineChart.showGenYLabels = NO;
        self.lineChart.showYGridLines = YES;
        
        self.lineChart.yFixedValueMax = 300;
        self.lineChart.yFixedValueMin = 0;
        [self.lineChart setYLabels:@[
                                     @"0 min",
                                     @"50 min",
                                     @"100 min",
                                     @"150 min",
                                     @"200 min",
                                     @"250 min",
                                     @"300 min"
                                     
                                     ]];
        
        //line chart
        NSArray * data1Array = @[@15.1,@60.1,@118.5,@10.8,@186.2,@197.8,@276.2];
        data1Array = [[data1Array reverseObjectEnumerator] allObjects];
        PNLineChartData * lineData = [[PNLineChartData alloc] init];

        lineData.color = PNFreshGreen;
        lineData.lineWidth = 2;
        lineData.itemCount = self.lineChart.xLabels.count;
        lineData.dataTitle = @"Alpha";
        lineData.color = PNFreshGreen;
        lineData.pointLabelColor = [UIColor blackColor];
        lineData.alpha = 0.3f;
        lineData.showPointLabel = YES;
        lineData.pointLabelFont = [UIFont fontWithName:@"Helvetica-Light" size:9.0];
        lineData.itemCount = data1Array.count;
        lineData.inflexionPointColor = PNRed;
        lineData.inflexionPointStyle = PNLineChartPointStyleTriangle;
        lineData.getData = ^PNLineChartDataItem *(NSUInteger index) {
            
            CGFloat yValue = [data1Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
            
        };
        
        // Line Chart No.2
        NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
        PNLineChartData *data02 = [PNLineChartData new];
        data02.color = PNTwitterColor;
        data02.itemCount = self.lineChart.xLabels.count;
        data02.dataTitle = @"Beta";
        data02.pointLabelColor = [UIColor blackColor];
        data02.color = PNTwitterColor;
        data02.alpha = 0.5f;
        data02.itemCount = data02Array.count;
        data02.inflexionPointStyle = PNLineChartPointStyleCircle;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        self.lineChart.delegate = self;
        self.lineChart.chartData = @[lineData,data02];
        [self.lineChart strokeChart];
        
        [self.view addSubview:self.lineChart];
        self.lineChart.legendStyle = PNLegendItemStyleStacked;
        self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
        self.lineChart.legendFontColor = [UIColor redColor];
        
        UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
        [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
        [self.view addSubview:legend];
    }
    
    if ([self.title isEqualToString:@"BarChart"]) {
        static NSNumberFormatter * barChartNumberFormatter;
        if (!barChartNumberFormatter) {
            barChartNumberFormatter = [[NSNumberFormatter alloc] init];
            barChartNumberFormatter.numberStyle = kCFNumberFormatterPercentStyle;
            barChartNumberFormatter.allowsFloats = YES;
            barChartNumberFormatter.maximumFractionDigits = 0;
        }
        self.titleLabel.text = @"BarChart";
        self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
        //设置柱状图的数字格式
        self.barChart.yLabelFormatter = ^NSString *(CGFloat yLabelValue) {
          
            return [barChartNumberFormatter stringFromNumber:@(yLabelValue)];
        };
        self.barChart.yMinValue = -20;
        
        self.barChart.yChartLabelWidth = 20;//设置柱状图之间的建个margin
        self.barChart.chartMarginLeft = 30.0;//设置左侧间隔
        self.barChart.chartMarginRight = 10;//设置右侧间隔
        self.barChart.chartMarginTop = 5.0;//设置顶部间隔
        self.barChart.chartMarginTop = 10.0; //
        
        self.barChart.labelMarginTop = 5.0;
        self.barChart.showChartBorder = YES;
        [self.barChart setXLabels:@[@"2",@"3",@"4",@"5",@"2",@"3",@"4",@"5"]];
        
        [self.barChart setYValues:@[@(-10.82),@1.55,@22.2,@45.22,@33.22,@45.11,@12.3,@19.9]];
        [self.barChart setStrokeColors:@[PNGreen,PNRed,PNBlue,PNGreen,PNGreen,PNGreen,PNRed,PNRed]];
        self.barChart.isGradientShow = NO;
        self.barChart.isShowNumbers = YES;
        
        [self.barChart strokeChart];
        
        self.barChart.delegate = self;
        
        [self.view addSubview:self.barChart];
        
    }
    
    if ([self.title isEqualToString:@"CycleChart"]) {
        
        self.titleLabel.text = @"Circle Chart";
        
//        self.circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 155.0, SCREEN_WIDTH, 100) total:@100 current:@65 clockwise:YES];
        self.circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 155.0, SCREEN_WIDTH, 100) total:@100 current:@75 clockwise:YES shadow:YES shadowColor:[UIColor grayColor] displayCountingLabel:YES];
        self.circleChart.backgroundColor = [UIColor whiteColor];
        
        [self.circleChart setStrokeColor:[UIColor redColor]];//进度条颜色
//        [self.circleChart setStrokeColorGradientStart:[UIColor redColor]];//设置渐变色开始绘制的颜色
        [self.circleChart strokeChart];
        [self.view addSubview:self.circleChart];
        
    }
    
    if ([self.title isEqualToString:@"PieChart"]) {
        self.titleLabel.text = @"Pie Chart";
        NSArray * items = @[[PNPieChartDataItem dataItemWithValue:10.5 color:PNLightGreen description:@"WWDC"],[PNPieChartDataItem dataItemWithValue:25 color:PNFreshGreen description:@"GOOGLE I/O"],[PNPieChartDataItem dataItemWithValue:55 color:PNDeepGreen]];
        self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0 -100, 135.0, 200, 200) items:items];
        self.pieChart.descriptionTextColor = [UIColor whiteColor];
        self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Avebir-Medium" size:11.0];
        self.pieChart.descriptionTextShadowColor = [UIColor clearColor];//设置字体阴影
        self.pieChart.showAbsoluteValues = NO;
        self.pieChart.showOnlyValues = YES;
        [self.pieChart strokeChart];
        self.pieChart.legendStyle = PNLegendItemStyleStacked;
        self.pieChart.legendFont = [UIFont systemFontOfSize:12.0f];
        UIView * legend = [self.pieChart getLegendWithMaxWidth:200];//刻印文字
        [legend setFrame:CGRectMake(130, 350, legend.frame.size.width, legend.frame.size.height)];
        [self.view addSubview:legend];
        [self.view addSubview:self.pieChart];
        
    }
    
    
    
    
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex
{
    
    
}

/**
 * Callback method that gets invoked when the user taps on a chart line key point.
 */
- (void)userClickedOnLineKeyPoint:(CGPoint)point
                        lineIndex:(NSInteger)lineIndex
                       pointIndex:(NSInteger)pointIndex
{
    
    
    
}

/**
 * Callback method that gets invoked when the user taps on a chart bar.
 */
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex
{
    
    
    
}


- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex
{
    
    
    
}
- (void)didUnselectPieItem
{
    
    
    
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
