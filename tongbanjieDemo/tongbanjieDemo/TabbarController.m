//
//  TabbarController.m
//  tongbanjieDemo
//
//  Created by apple on 2017/1/21.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "TabbarController.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addchildViewController];
    [self customTabbar];
}

- (void)addchildViewController {
    
    
    UINavigationController * homeNav = [UIViewController viewControllerForHomeStroyboardWithIdentifier:@"home"];
     UINavigationController * investNav = [UIViewController viewControllerForInvestStroyboardWithIdentifier:@"Invest"];
     UINavigationController * wealthNav = [UIViewController viewControllerForHomeStroyboardWithIdentifier:@"home"];
     UINavigationController * discoveryNav = [UIViewController viewControllerForDiscoverStroyboardWithIdentifier:@"discovery"];
     UINavigationController * meNav = [UIViewController viewControllerForMeStroyboardWithIdentifier:@"Me"];
    
    self.viewControllers = @[homeNav,investNav,wealthNav,discoveryNav,meNav];
    
}
#pragma mark -- 绘制tabbar

- (void)customTabbar {
    
    NSArray * titleArr = @[@"首页",@"投资",@"财富",@"发现",@"我"];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        
        vc.title = nil;
        //  vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
    }];
    
    NSInteger index = 0;
    for (UITabBarItem *item in [[self tabBar] items]) {
        
        
                [self setTabBarItem:item imageName:[NSString stringWithFormat:@"tab_bar_normal_%ld_32x32_",index] selectedImageName:[NSString stringWithFormat:@"tab_bar_selected_%ld_32x32_",index] title:titleArr[index]];
        
        index ++;
    }

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithString:@"#7d848f"],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithString:@"#f0594e"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
}
- (void)setTabBarItem:(UITabBarItem *)item  imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title
{
    
    [item setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setTitle:title];
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
