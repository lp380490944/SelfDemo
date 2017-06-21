//
//  GITShowRateView.h
//  TigerWit
//
//  Created by TigerWit on 16/5/5.
//  Copyright © 2016年 TigerWit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GITShowRateView : UIView


typedef enum : NSUInteger {
    TriangleOrientationNone,  //无
    TriangleOrientationTop,   //上
    TriangleOrientationLeft,  //左
    TriangleOrientationBottom,//下
    TriangleOrientationRight, //右

} TriangleOrientation;  //箭头朝向
/**
 *  整体宽度（lineChart的）
 */
@property (nonatomic,assign)CGFloat lineChartWidth;
/**
 *  整体高度（lineChart的）
 */
@property (nonatomic,assign)CGFloat lineChartHeight;
/**
 *  点击的点
 */
@property (nonatomic,assign)CGPoint trianglePoint;
/**
 *  三角朝向
 */
@property (nonatomic,assign)TriangleOrientation triangleOrientation;
/**
 *  收益率名字
 */
@property (nonatomic,strong)UILabel *rateNameLabel;
/**
 *  收益率
 */
@property (nonatomic,strong)UILabel *rateLabel;

@property (nonatomic,assign)CGFloat rate;
/**
 *  三角显示状态及方向
 */
- (void)settriangleOrientation;
/**
 *  初始化方法
 *
 *  @param width  <#width description#>
 *  @param height <#height description#>
 *  @param point  <#point description#>
 *  @param rate   <#rate description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithLineChartWidth:(CGFloat)width lineChartHeight:(CGFloat)height trianglePoint:(CGPoint)point rate:(CGFloat)rate;

@end
