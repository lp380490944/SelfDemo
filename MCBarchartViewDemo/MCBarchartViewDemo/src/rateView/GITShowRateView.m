//
//  GITShowRateView.m
//  TigerWit
//
//  Created by TigerWit on 16/5/5.
//  Copyright © 2016年 TigerWit. All rights reserved.
//

#import "GITShowRateView.h"
#import "UIView+Utils.h"
#import "UIColor+Theme.h"
#define NOTRIANGLE 50             //无三角
#define TRIANGLE 55               //有三角
#define LINECHART_Y 45            //linechart Y值
#define NODRAWWIDTH self.lineChartWidth/6.0 //左右未绘制曲线图部分
#define YUANWIDTH 7.5
@implementation GITShowRateView
- (instancetype)initWithLineChartWidth:(CGFloat)width lineChartHeight:(CGFloat)height trianglePoint:(CGPoint)point rate:(CGFloat)rate
{
    self = [super init];
    if (self) {
        self.lineChartWidth = width;
        self.lineChartHeight = height;
        self.trianglePoint = point;
        self.rate = rate;
        [self creatRateLabel];
        [self settriangleOrientation];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)creatRateLabel
{
    _rateNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(-50, 0, self.width , 12)];
    _rateNameLabel.text = @"收益率";
    _rateNameLabel.textColor = [UIColor blackColor];
    _rateNameLabel.textAlignment = NSTextAlignmentCenter;
    _rateNameLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_rateNameLabel];
    
    _rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_rateNameLabel.origin.x, CGRectGetMaxY(_rateNameLabel.frame), self.width, 12)];
    _rateLabel.text = [NSString stringWithFormat:@"%.2f%%",self.rate];
    _rateLabel.textAlignment = NSTextAlignmentCenter;
    _rateLabel.textColor = [UIColor blackColor];
    _rateLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_rateLabel];
}
#pragma mark 三角显示状态及方向
- (void)settriangleOrientation
{

    if (LINECHART_Y + self.trianglePoint.y>= TRIANGLE + 7.5) {
        self.frame = CGRectMake(0, 0, NOTRIANGLE, TRIANGLE);
        self.triangleOrientation = TriangleOrientationBottom;
        _rateNameLabel.frame = CGRectMake(0, 10, self.width, 15);
    }
    else if (self.lineChartHeight - self.trianglePoint.y>= TRIANGLE + 7.5) {
        self.frame = CGRectMake(0, 0, NOTRIANGLE, TRIANGLE);
        self.triangleOrientation = TriangleOrientationTop;
        _rateNameLabel.frame = CGRectMake(5, 10, self.width - 5, 15);

    }
    else if (self.trianglePoint.x >= TRIANGLE + 5 ) {
        self.frame = CGRectMake(0, 0,TRIANGLE , NOTRIANGLE);
        self.triangleOrientation = TriangleOrientationRight;
        _rateNameLabel.frame = CGRectMake(5, 5, self.width - 5, 15);

    }
    else if (self.lineChartWidth - self.trianglePoint.x - 5 >TRIANGLE) {
        self.frame = CGRectMake(0, 0,TRIANGLE , NOTRIANGLE);
        self.triangleOrientation = TriangleOrientationLeft;
        _rateNameLabel.frame = CGRectMake(10, 5, self.width - 5, 15);

    }
    else {
        self.frame = CGRectMake(0, 0,NOTRIANGLE , NOTRIANGLE);
        self.triangleOrientation = TriangleOrientationNone;
        _rateNameLabel.frame = CGRectMake(5, 5, self.width - 5, 15);

    }
    _rateLabel.text = [NSString stringWithFormat:@"%.2f%%",self.rate];
    _rateLabel.frame = CGRectMake(_rateNameLabel.left, _rateNameLabel.bottom, self.width, 15);

}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    switch (self.triangleOrientation) {
        case TriangleOrientationNone:
            [self drawRectNone];
            break;
        case TriangleOrientationTop:
            [self drawTop];
            break;
        case TriangleOrientationLeft:
            [self drawLeft];
            break;
        case TriangleOrientationBottom:
            [self drawBottom];
            break;
        case TriangleOrientationRight:
            [self drawRight];
            break;
        default:
            break;
    }
}
- (void)drawBottom
{

    CGFloat piancha =0;
    if (self.trianglePoint.x < self.width/2.0) {
        piancha = self.trianglePoint.x - self.width/2.0;
    }
    if (self.lineChartWidth - self.trianglePoint.x < self.width/2.0) {
        piancha = self.width/2.0 - (self.lineChartWidth - self.trianglePoint.x);
    }
    if (piancha > NOTRIANGLE/2.0 - 7) {
        piancha = NOTRIANGLE/2.0 - 7;
    }

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(1, self.height - 5)];
    [path addLineToPoint:CGPointMake(self.width/2.0 + piancha - 5, self.height - 5)];
    [path addLineToPoint:CGPointMake(self.width/2.0 + piancha, self.height - 1 )];
    [path addLineToPoint:CGPointMake(self.width/2.0 + piancha + 5, self.height - 5)];
    
    
    [path addLineToPoint:CGPointMake(self.width -1 , self.height - 5)];
    [path addLineToPoint:CGPointMake(self.width -1, 1)];
    [path addLineToPoint:CGPointMake(1, 1)];
    [path addLineToPoint:CGPointMake(1, self.height - 5)];
    [path setLineWidth:1];
    [[UIColor whiteColor] setFill];
    [GITCOLOR_TEXT_BLUE setStroke];
    [path fill];
    [path stroke];
    

    self.frame = CGRectMake(self.trianglePoint.x - NOTRIANGLE/2.0 - piancha, self.trianglePoint.y - self.height - YUANWIDTH,self.width ,self.height );

}
- (void)drawRectNone
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(1, 1)];
    [path addLineToPoint:CGPointMake(self.width - 1, 1)];
    [path addLineToPoint:CGPointMake(self.width - 1, self.height - 1)];
    [path addLineToPoint:CGPointMake(1, self.height - 1)];
    [path addLineToPoint:CGPointMake(1, 1)];
    [path setLineWidth:1];
    [GITCOLOR_TEXT_BLUE setStroke];
    [path stroke];
    self.center = CGPointMake(self.lineChartWidth/2.0, self.lineChartHeight/2.0 - 5);
}
- (void)drawTop
{
    CGFloat piancha =0;
    if (self.trianglePoint.x < NOTRIANGLE/2.0) {
        piancha = self.trianglePoint.x - NOTRIANGLE/2.0;
    }
    if (self.lineChartWidth - self.trianglePoint.x < NOTRIANGLE/2.0) {
        piancha = NOTRIANGLE/2.0 - (self.lineChartWidth - self.trianglePoint.x);
    }
    if (piancha > NOTRIANGLE/2.0 - 7) {
        piancha = NOTRIANGLE/2.0 - 7;
    }

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(1, 5)];
    [path addLineToPoint:CGPointMake(NOTRIANGLE/2.0 + piancha - 5, 5)];
    [path addLineToPoint:CGPointMake(NOTRIANGLE/2.0 + piancha, 0)];
    [path addLineToPoint:CGPointMake(NOTRIANGLE/2.0 + piancha + 5, 5)];


    [path addLineToPoint:CGPointMake(self.width -1 , 5)];
    [path addLineToPoint:CGPointMake(self.width -1, self.height -1)];
    [path addLineToPoint:CGPointMake(1, self.height -1)];
    [path addLineToPoint:CGPointMake(1, 5)];
    
    [path setLineWidth:1];
    [GITCOLOR_TEXT_BLUE setStroke];
    [path stroke];

    self.frame = CGRectMake(self.trianglePoint.x - NOTRIANGLE/2.0 - piancha, self.trianglePoint.y + YUANWIDTH,NOTRIANGLE ,TRIANGLE );
}

- (void)drawLeft
{
    CGFloat piancha = self.lineChartHeight - self.trianglePoint.y;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(5, 1)];
    [path addLineToPoint:CGPointMake(5, NOTRIANGLE - piancha - 5)];
    [path addLineToPoint:CGPointMake(0,NOTRIANGLE - piancha)];
    [path addLineToPoint:CGPointMake(5,NOTRIANGLE - piancha + 5)];
    
    [path addLineToPoint:CGPointMake(5,self.height -1)];
    [path addLineToPoint:CGPointMake(self.width -1,self.height -1)];
    [path addLineToPoint:CGPointMake(self.width -1,1)];
    [path addLineToPoint:CGPointMake(5,1)];
    
    [path setLineWidth:1];
    [GITCOLOR_TEXT_BLUE setStroke];
    [path stroke];
    
    self.frame = CGRectMake(self.trianglePoint.x + YUANWIDTH, self.lineChartHeight - NOTRIANGLE,TRIANGLE , NOTRIANGLE);
}
- (void)drawRight
{
    CGFloat piancha = self.lineChartHeight - self.trianglePoint.y;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.width - 5, 1)];
    [path addLineToPoint:CGPointMake(self.width - 5, NOTRIANGLE - piancha - 5)];
    [path addLineToPoint:CGPointMake(self.width,NOTRIANGLE - piancha)];
    [path addLineToPoint:CGPointMake(self.width - 5,NOTRIANGLE - piancha + 5)];
    
    [path addLineToPoint:CGPointMake(self.width - 5,self.height -1)];
    [path addLineToPoint:CGPointMake(1,self.height -1)];
    [path addLineToPoint:CGPointMake(1,1)];
    [path addLineToPoint:CGPointMake(self.width - 5,1)];
    
    [path setLineWidth:1];
    [GITCOLOR_TEXT_BLUE setStroke];
    [path stroke];
    
    self.frame = CGRectMake(self.trianglePoint.x - self.width - YUANWIDTH, self.lineChartHeight - NOTRIANGLE,TRIANGLE , NOTRIANGLE);
}
@end
