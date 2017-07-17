//
//  BaeTableView.m
//  JianShuDemo
//
//  Created by apple on 2017/7/14.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "BaeTableView.h"

@implementation BaeTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}



@end
