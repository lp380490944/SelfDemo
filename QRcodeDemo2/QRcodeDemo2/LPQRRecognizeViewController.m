//
//  LPQRRecognizeViewController.m
//  QRcodeDemo2
//
//  Created by apple on 2016/12/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LPQRRecognizeViewController.h"

@interface LPQRRecognizeViewController ()<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LPQRRecognizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"从相册选取" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick:)];
}
- (void)rightBarButtonItemClick:(UIBarButtonItem *)btn
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        [self presentViewController:pickerController animated:YES completion:nil];
    }else{
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alter show];
        
    }
}

#pragma mark -- pickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage * image = info[UIImagePickerControllerOriginalImage];
        self.imageView.image = image;
        [self findQRfromImage:image];
    }];
}
- (void)findQRfromImage:(UIImage *)image
{
    //探测器
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray * features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage] ];
    if (features.count >= 1) {
        CIQRCodeFeature * feature = features.firstObject ;
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"" message:feature.messageString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alter show];
    }else{
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有发现二维码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alter show];
        
    }
    
    
}

- (IBAction)longPressHandle:(id)sender {
    UILongPressGestureRecognizer  * longPress = sender;
    if(longPress.state == UIGestureRecognizerStateBegan ) {
        
        [self findQRfromImage:self.imageView.image];
    }
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
