//
//  UIViewController+StoryBoard.h
//  tongbanjieDemo
//
//  Created by apple on 2017/1/21.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (StoryBoard)

/*
 
 从storyBoard中创建ViewController
 
 */

+(id)viewControllerWithStoryBoardName:(NSString *)name controllerIdenfifier:(NSString *)identifer;
+(id)viewControllerForMainStroyboardWithIdentifier:(NSString *)identifier;
+(id)viewControllerForHomeStroyboardWithIdentifier:(NSString *)identifier;
+(id)viewControllerForInvestStroyboardWithIdentifier:(NSString *)identifier;
+(id)viewControllerForMeStroyboardWithIdentifier:(NSString *)identifier;
+(id)viewControllerForWealthStroyboardWithIdentifier:(NSString *)identifier;
+(id)viewControllerForDiscoverStroyboardWithIdentifier:(NSString *)identifier;


@end
