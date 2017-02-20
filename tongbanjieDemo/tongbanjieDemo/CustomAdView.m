//
//  CustomAdView.m
//  tongbanjieDemo
//
//  Created by apple on 2017/1/21.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "CustomAdView.h"

@interface CustomAdView ()

@property(nonatomic,strong)UIImageView * adimageView;//广告图
@property(nonatomic,strong)UIButton * countDownBtn;//倒计时按钮
@property(nonatomic,strong)NSTimer * countTimer;//计时器
@property(nonatomic,assign)NSInteger count;

@end

static  int const showTime = 3;

@implementation CustomAdView

- (NSTimer *)countTimer {
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(coutDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //1、添加广告图片
        _adimageView = [[UIImageView alloc] initWithFrame:frame];
        _adimageView.userInteractionEnabled = YES;
        _adimageView.contentMode = UIViewContentModeScaleAspectFill;
        _adimageView.clipsToBounds = YES;
       
        //2、跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countDownBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - btnW - 24, btnH,btnW, btnH)];
        [_countDownBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countDownBtn setTitle:@"跳过%d" forState:UIControlStateNormal];
        _countDownBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countDownBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        
        _countDownBtn.layer.cornerRadius = 4;
        [self addSubview:_adimageView];
        [self addSubview:_countDownBtn];
    
    }
    
    return  self;
    
}
- (void)setIamgeName:(NSString *)imageName
{
    _imageName = imageName;
    _adimageView.image = [UIImage imageNamed:imageName];
}

- (void)coutDown {
    
    _count --;
    [_countDownBtn setTitle:[NSString stringWithFormat:@"跳过%ld",_count] forState:UIControlStateNormal];
    
    if (_count == 0) {
        [self dismiss];
    }
    
}

- (void)show {
    
    //倒计时GCD
     [self startCoundown];
//    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    
}
- (void)startCoundown {
    __block int timeout = showTime + 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, NSEC_PER_SEC * NSEC_PER_SEC);//每一秒执行
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {//倒计时结束关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countDownBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            
            timeout--;
        }
        
    });
    dispatch_resume(timer);
    
}
- (void)startTimer {
    
    _count = showTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}
- (void)dismiss {
    
    [self.countTimer invalidate];
    self.countTimer = nil;
    [UIView animateWithDuration:0.3f animations:^{
       
        self.alpha = 0;
    }completion:^(BOOL finished) {
       
        [self removeFromSuperview];
    }];
}

@end
