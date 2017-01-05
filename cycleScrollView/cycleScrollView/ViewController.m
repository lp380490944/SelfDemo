//
//  ViewController.m
//  cycleScrollView
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 bluceLiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *container;//容器视图
@property(nonatomic,strong)NSArray * imageNameArray;
@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)NSMutableArray * imageViewArray;
@end
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetting];
}
- (void)initSetting {
    
    self.imageNameArray = @[@"image1",@"image2",@"image3"];
    self.imageArray = [NSMutableArray array];
    for (NSString * imageName in self.imageNameArray) {
        UIImage * image = [UIImage imageNamed:imageName];
        [self.imageArray addObject:image];
    }
//     [self.imageArray addObject:self.imageArray[0] ];
//    [self.imageArray insertObject:self.imageArray.lastObject atIndex:0];
    self.imageViewArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0,kScreenWidth , kScreenHeight)];
        imageView.image = [self.imageArray objectAtIndex:i];
        [self.imageViewArray addObject:imageView];
        [self.container addSubview:imageView];
    }
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / kScreenWidth;
    if (index == self.imageArray.count - 1) {
        //最后一张
        [scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
        UIImageView * leftImageView = self.imageViewArray.firstObject;
        leftImageView.image = self.imageArray.lastObject;
        
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
