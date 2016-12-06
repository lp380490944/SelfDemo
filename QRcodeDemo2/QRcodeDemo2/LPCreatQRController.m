//
//  LPCreatQRController.m
//  QRcodeDemo2
//
//  Created by apple on 2016/12/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LPCreatQRController.h"

@interface LPCreatQRController ()
@property (weak, nonatomic) IBOutlet UIView *QRview;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LPCreatQRController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatQRcode];
}
- (IBAction)didClickedCreatBtn:(id)sender {
    if (!self.inputTextField.text.length) {
        return;
    }
    NSData * textData = [self.inputTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    //1、生成
    CIFilter * qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:textData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    UIColor * onColor = [UIColor redColor];
    UIColor *offColor = [UIColor greenColor];
    //2、上色
    CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"keysAndValues:@"inputImage",qrFilter.outputImage,@"inputColor0", [CIColor colorWithCGColor:onColor.CGColor]
,@"inputColor1",[CIColor colorWithCGColor:offColor.CGColor], nil];
    CIImage * qrImage = colorFilter.outputImage;
    
    //3、绘制
    CGSize  size = CGSizeMake(300, 300);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //为上下文设置插入文字质量
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //设置图片缩放
    CGContextScaleCTM(context, 1.0, -1.0);
    //画图
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage * codeImage =   UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    self.imageView.image = [self addSmallImageForQRImage:codeImage];
}

- (UIImage *)addSmallImageForQRImage:(UIImage *) qrImage
{
    UIGraphicsBeginImageContext(qrImage.size);
    [qrImage drawInRect:CGRectMake(0, 0, qrImage.size.width, qrImage.size.height)];
    UIImage * smallImage = [UIImage imageNamed:@"22"];
    CGFloat imageW = 50;
    CGFloat imageX = (qrImage.size.width - imageW)/2;
    CGFloat imageY = (qrImage.size.height - imageW)/2;
    [smallImage drawInRect:CGRectMake(imageX, imageY, imageW, imageW)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)creatQRcode {
    

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
