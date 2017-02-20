//
//  UIViewController+StoryBoard.m
//  tongbanjieDemo
//
//  Created by apple on 2017/1/21.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "UIViewController+StoryBoard.h"

@implementation UIViewController (StoryBoard)
+(id)viewControllerWithStroyboardName:(NSString *)name controllerIdentifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}
+(id)viewControllerForMainStroyboardWithIdentifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}
+(id)viewControllerForHomeStroyboardWithIdentifier:(NSString *)identifier
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    
    return [storyBoard instantiateViewControllerWithIdentifier:identifier];
    
}
+(id)viewControllerForInvestStroyboardWithIdentifier:(NSString *)identifier
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Invest" bundle:[NSBundle mainBundle]];
    
    return [storyBoard instantiateViewControllerWithIdentifier:identifier];
    
}
+(id)viewControllerForMeStroyboardWithIdentifier:(NSString *)identifier
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Me" bundle:[NSBundle mainBundle]];
    
    return [storyBoard instantiateViewControllerWithIdentifier:identifier];
    
}
+(id)viewControllerForWealthStroyboardWithIdentifier:(NSString *)identifier
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Wealth" bundle:[NSBundle mainBundle]];
    
    return [storyBoard instantiateViewControllerWithIdentifier:identifier];
    
}
+(id)viewControllerForDiscoverStroyboardWithIdentifier:(NSString *)identifier
{
    
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Discovery" bundle:[NSBundle mainBundle]];
    
    return [storyBoard instantiateViewControllerWithIdentifier:identifier];
    
}
@end
