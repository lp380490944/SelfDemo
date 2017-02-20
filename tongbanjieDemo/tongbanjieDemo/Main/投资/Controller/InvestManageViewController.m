//
//  InvestManageViewController.m
//  tongbanjieDemo
//
//  Created by apple on 2017/2/6.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "InvestManageViewController.h"
#import "HMSegmentedControl.h"

@interface InvestManageViewController ()
@property(nonatomic,strong)HMSegmentedControl * segmentedControl;
@property(nonatomic,assign)NSInteger selectedIndex;
@end

@implementation InvestManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNaviBar];
}

- (void)customNaviBar
{
    
    self.navigationItem.titleView = self.segmentedControl;
    
    
}
- (HMSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        NSArray * sectionTitles= @[@"交易记录",@"高手跟单",@"我的账单"];
        
        _segmentedControl = [HMSegmentedControl new];
        _segmentedControl.type = HMSegmentedControlTypeText;
        
        _segmentedControl.sectionTitles = sectionTitles;
        
        
        _segmentedControl.backgroundColor = [UIColor clearColor];
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithString:@"#12b7f5"] };
        _segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
        _segmentedControl.selectionIndicatorColor =[UIColor colorWithString:@"#12b7f5"];
        _segmentedControl.selectionIndicatorHeight = 2.0;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        
        _segmentedControl.selectedSegmentIndex =self.selectedIndex;
        __weak typeof(self) weakSelf = self;
        CGFloat viewWidth = CGRectGetWidth(self.view.frame);
        [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
            weakSelf.selectedIndex = index;
        }];
        
    }
    
    return  _segmentedControl;
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
