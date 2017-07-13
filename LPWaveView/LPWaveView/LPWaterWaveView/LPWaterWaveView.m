//
//  LPWaterWaveView.m
//  LPWaveView
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "LPWaterWaveView.h"

@interface LPWaterWaveView ()<UICollisionBehaviorDelegate>
@property(nonatomic,strong)UIImageView * fish;

@end

@implementation LPWaterWaveView{
    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;
    
    CADisplayLink * waveDisplayLink;
    CAShapeLayer * waveShapeLayer;
    UIBezierPath * waveBoundaryPath;
    
    UIImageView * boot;
    UIDynamicAnimator * animator;
    UIPushBehavior * push;
    UIGravityBehavior * grav;
    UICollisionBehavior * collision;
    NSTimer * timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        waterWaveHeight = frame.size.height/2.0;
        waterWaveWidth = frame.size.width;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self .backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        waterWaveHeight = self.frame.size.height/2;
        waterWaveWidth = self.frame.size.width;
    }
    return self;
    
}
#pragma mark --  public interface

- (void)wave {
    //创建贝塞尔曲线路径
    waveBoundaryPath = [UIBezierPath bezierPath];
    
    //给view添加绘制层
    waveShapeLayer = [CAShapeLayer layer];
    waveShapeLayer.fillColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1].CGColor;
    [self.layer addSublayer:waveShapeLayer];
    
    //屏幕刷新定时器 DisplayLink 可以实现不停的重绘。
    waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    //跟NStimer一样DisplayLink 也需要添加到 runloop中
    [waveDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    
    //创建小船
    boot = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 20, 20)];
    boot.backgroundColor = [UIColor clearColor];
    boot.image = [UIImage imageNamed:@"ship"];
    [self addSubview:boot];
    
    //创建动画器 animator  Reference ： 提及、涉及
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    //创建一个需要添加重力效果的条目数组
    //Initializes a gravity behavior with an array of dynamic items.
    NSArray * items = @[boot];
    grav = [[UIGravityBehavior alloc] initWithItems:items];
    //重力行为添加到动画器上
    [animator addBehavior:grav];
    
    //添加碰撞效果
    collision = [[UICollisionBehavior alloc] initWithItems:items];
    //设置碰撞行为的代理
    collision.collisionDelegate = self;
    [animator addBehavior:collision];
    
    //设置小鱼跳跃的定时器
   timer =  [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(fishJum) userInfo:nil repeats:YES];
}
//停止动画
- (void)stop {
    //停止和释放定时器
    [waveDisplayLink invalidate];
    [timer invalidate];
    waveDisplayLink = nil;
    timer = nil;
}

- (void)fishJum {
    
    
    
}
- (void)getCurrentWave:(CADisplayLink *)displayLink {
    //从碰撞行为中删除所有先前指定的碰撞边界
    [collision removeAllBoundaries];
    
    offsetX += self.waveSpeed;
    waveBoundaryPath = [self getCurrentWavePath];
    
    waveShapeLayer.path = waveBoundaryPath.CGPath;
    
    [collision addBoundaryWithIdentifier:@"waveBoundary" forPath:waveBoundaryPath];

    
    
    
}
//获取当前路径
- (UIBezierPath *)getCurrentWavePath {
    
    UIBezierPath * currentPath = [UIBezierPath bezierPath];
    //创建一个可变图形路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,0, waterWaveHeight);
    
    CGFloat y = 0.0f;
    /*此处计算较为复杂 特此注释： sinf()求正弦值
    360/waterWaveWidth:表示把一个圆平分成了 wataterWaveWidth份 也就是 每1°对应的宽度 :perDegreeWidth
     
     perDegreeWidth*x 就是 当前宽度对应的
     
   */
    for (float x = 0.0f; x <= waterWaveWidth; x++) {
        y = self.waveAmlitude * sinf((360/waterWaveWidth) * (x * M_PI/180) - offsetX*M_PI/180) + waterWaveHeight;
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    CGPathAddLineToPoint(path, NULL, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, NULL, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    currentPath.CGPath = path;
    CGPathRelease(path);
    return currentPath;
}


@end
