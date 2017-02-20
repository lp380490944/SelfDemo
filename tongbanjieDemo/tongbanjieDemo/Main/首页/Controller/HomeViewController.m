//
//  HomeViewController.m
//  tongbanjieDemo
//
//  Created by apple on 2017/1/22.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIView * container;//容器视图
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
    [self layoutSubviews];
}

- (void)addSubView {
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.container];
    
}
- (void)layoutSubviews
{
  [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.view);
  }];
  [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.scrollView);
      make.width.equalTo(self.scrollView);
  }];
    
    
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    
    return _scrollView;
}
- (UIView *)container
{
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    
    return _container;
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
