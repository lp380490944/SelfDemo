//
//  CustomAdView.h
//  tongbanjieDemo
//
//  Created by apple on 2017/1/21.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScrrenHeight  [UIScreen mainScreen].bounds.size.height

@interface CustomAdView : UIView

@property(nonatomic,copy)NSString * imageName;

- (void)show;
- (void)setIamgeName:(NSString *)imageName;
@end
