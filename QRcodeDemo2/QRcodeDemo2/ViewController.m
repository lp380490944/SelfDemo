//
//  ViewController.m
//  QRcodeDemo2
//
//  Created by apple on 2016/12/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Untill.h"


static const CGFloat kMragin = 30;
static const  CGFloat kBorderWidth = 100;
static const CGFloat kImageHeight = 18;
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UIView * scanView;
@property(nonatomic,strong)UIImageView * scanImageView;
@property(nonatomic,strong)AVCaptureSession * session;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMaskView];
    [self setupScanWindow];
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resumeAnimation];
}
- (void)startScan {
    
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc] init];
    //创建一个队列
    dispatch_queue_t  myqueue;
    myqueue = dispatch_queue_create("myqueue", NULL);
    //此处在主线程操作更新UI更方便
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置扫描的有效区域
    output.rectOfInterest = [self getScanCrop:self.scanView.bounds readerViewBounds:self.view.frame];
    [self.session addInput:input];
    [self.session addOutput:output];
//注意！此处必须先添加输入输出流后设置兼容的二维码格式否则会导致崩溃
    output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    //创建预览
    AVCaptureVideoPreviewLayer * preViewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preViewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:preViewLayer atIndex:0];
    [self.session startRunning];
}
#warning 此处扫描的有效范围需要特别注意
#pragma mark-> 获取扫描区域的比例关系
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{/*
  Specifies a rectangle of interest for limiting the search area for visual metadata.
  确切的长方形一个限定的感兴趣的搜索区域对于可见的元数据（也就是可扫描的区域）
  @discussion
  解释完全看不懂。但是搜索很多资料了解到 这个区域的大小是相对于设备而言的也就是相当于一个比例0~1
  默认的值(0,0,1,1)也就是整个屏幕
  这里需要格外注意 这个设置是相对于横屏下的。也就是竖屏下的设置是需要x<->y互换 width<->height互换的。
  下面计算
  */
    CGFloat x,y,width,height;
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    return CGRectMake(x, y, width, height);
}

- (void)setupMaskView {
    UIView * maskView =  [[UIView  alloc] init];
    maskView.bounds = CGRectMake(0, 0, self.view.width+2*kBorderWidth-2*kMragin,self.view.width+2*kBorderWidth-2*kMragin);
    maskView.center = CGPointMake(self.view.width *0.5, self.view.height*0.5);
    maskView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor;
    maskView.layer.borderWidth = 100;
    [self.view addSubview:maskView];
}
- (void)setupScanWindow {
    self.view.clipsToBounds = YES;
    self.scanView.bounds = CGRectMake(0,0,self.view.width-2*kMragin, self.view.width-2*kMragin);
    self.scanView.center = self.view.center;
//    self.scanView.backgroundColor = [UIColor blueColor];
    self.scanView.clipsToBounds = YES;
    [self.view addSubview:self.scanView];
    
    self.scanImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
      [self startScan];
}
//恢复动画
- (void)resumeAnimation
{
    CAAnimation * animation = [self.scanImageView.layer animationForKey:@"animationKey"];
    if (animation) {
        //将动画的时间偏移量作为暂停时的时间点
        CFTimeInterval pauseTime = self.scanImageView.layer.timeOffset;
        //根据媒体时间计算出准确的启动动画时间，对之前暂停的动画进行修正。
        CFTimeInterval  begainTime = CACurrentMediaTime() - pauseTime;
        //把偏移时间清零。
        [self.scanImageView.layer setTimeOffset:0.0];
        //设置图层开始动画时间
        [self.scanImageView.layer setBeginTime:begainTime];
        [self.scanImageView.layer setSpeed:1.0];
    }else{
        CGFloat scanImageH = 241;
        CGFloat scanImageW = self.scanView.width;
        CGFloat scanWindowH = self.view.width - 2*kMragin;
        self.scanImageView.frame = CGRectMake(0, -scanImageH, scanImageW,scanImageH );
        CABasicAnimation * basicAnia = [CABasicAnimation animation];
        basicAnia.keyPath = @"transform.translation.y";
        basicAnia.byValue = @(scanWindowH);
        basicAnia.duration = 1.0;
        basicAnia.repeatCount = CGFLOAT_MAX;
        [self.scanImageView.layer addAnimation:basicAnia forKey:@"animationKey"];
        [self.scanView addSubview:self.scanImageView];
    }
    
    
    
    
}

#pragma mark -- delegate 
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject * object = metadataObjects.firstObject;
        
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"" message:object.stringValue delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.session startRunning];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)scanView
{
    if (!_scanView) {
        _scanView = [[UIView alloc] init];
    }
    
    return _scanView;
}
- (AVCaptureSession *)session
{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
         [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    return _session;
}

@end
