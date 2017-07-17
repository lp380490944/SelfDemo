//
//  ViewController.m
//  JianShuDemo
//
//  Created by apple on 2017/7/14.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import <Masonry.h>
#import <HMSegmentedControl.h>
#import <ReactiveCocoa.h>
#import "BaseScrollView.h"
#import "BaeTableView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet BaseScrollView *verticalScrollView;
@property (weak, nonatomic) IBOutlet UIView *verticalContainer;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *horizontalScrollView;
@property (weak, nonatomic) IBOutlet UIView *horizontalContainer;
@property(nonatomic,strong)NSArray * childVCs;
@property(nonatomic,strong)NSArray * includeViews;
@property(nonatomic,strong)HMSegmentedControl * segmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addElements];
    [self addSubViews];
    [self layoutSubViews];
    
}
- (void)addElements {
    
    TableViewController * tabVC1 = [[TableViewController alloc] init];
    TableViewController * tabVC2 = [[TableViewController alloc] init];
    TableViewController * tabVC3 = [[TableViewController alloc] init];
    self.childVCs = @[tabVC1,tabVC2,tabVC3];
    self.includeViews = @[tabVC1.view , tabVC2.view,tabVC3.view];
    
    

   [RACObserve(self.verticalScrollView, contentOffset) subscribeNext:^(id x) {
       
       NSLog(@"%f",[x CGPointValue].y);
       if ([x CGPointValue].y > 156 ) {
           self.verticalScrollView.contentOffset = CGPointMake(0, 156);
           self.verticalScrollView.scrollEnabled = NO;
           tabVC1.tableView.scrollEnabled = YES;
           tabVC2.tableView.scrollEnabled = YES;
           tabVC3.tableView.scrollEnabled = YES;
       }else{
           self.verticalScrollView.scrollEnabled = YES;
           tabVC1.tableView.scrollEnabled = NO;
           tabVC2.tableView.scrollEnabled = NO;
           tabVC3.tableView.scrollEnabled = NO;
       }
       
    }];
    
    [RACObserve(tabVC1.tableView, contentOffset) subscribeNext:^(id x) {
        
        if ([x CGPointValue].y > 0) {
            tabVC1.tableView.scrollEnabled = YES;
            
        }else{
            
            tabVC1.tableView.scrollEnabled = NO;
        }
        
    }];
    [RACObserve(tabVC2.tableView, contentOffset) subscribeNext:^(id x) {
        if ([x CGPointValue].y > 0) {
            
            tabVC2.tableView.scrollEnabled = YES;
            
        }else{
            
            tabVC2.tableView.scrollEnabled = NO;
        }
    }];
    [RACObserve(tabVC3.tableView, contentOffset) subscribeNext:^(id x) {
        if ([x CGPointValue].y > 0) {
            
            tabVC3.tableView.scrollEnabled = YES;
            
        }else{
            
            tabVC3.tableView.scrollEnabled = NO;
        }
        
    }];
    
    
}
- (void)addSubViews {
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"动态",@"文章",@"更多"]];
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;

    
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        
        [self.horizontalScrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, viewHeight) animated:YES];
    }];
    
    [self.headerView addSubview:self.segmentedControl];
    
    if (self.includeViews.count < 2) {
        return;
    }
    NSInteger count = self.includeViews.count;
    
    for (int i = 0; i < count; i++) {
        [self addChildViewController:self.childVCs[i]];
    }
    
    for (int i = 0; i < count; i++) {
        
        [self.horizontalContainer addSubview:self.includeViews[i]];
    }
    
    for (int i = 0; i < count; i++) {
        [self.childVCs[i] didMoveToParentViewController:self];
    }
}
- (void)layoutSubViews {
    
    if (self.includeViews.count < 3) {
        return;
    }
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.equalTo(@44);
    }];
    
    UIView * nowSuvView = nil;
    for (int i = 0 ; i < self.includeViews.count; i++) {
        
        nowSuvView = self.includeViews[i];
        [nowSuvView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.horizontalScrollView);
            make.top.bottom.equalTo(self.horizontalContainer);
            if (i == 0) {
                make.left.offset(0);
            }else if (i == self.includeViews.count - 1){
                make.right.equalTo(self.horizontalContainer);
                
            }else{
                 make.right.equalTo(((UIView *)self.includeViews[i + 1]).mas_left);
                
            }
            
            
            
        }];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.horizontalScrollView) {
        
        CGFloat viewWidth = self.view.frame.size.width;
        
        NSInteger index = self.horizontalScrollView.contentOffset.x/viewWidth;
        
        self.segmentedControl.selectedSegmentIndex = index;
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}


@end
