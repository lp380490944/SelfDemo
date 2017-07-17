//
//  BaseScrollView.m
//  JianShuDemo
//
//  Created by apple on 2017/7/14.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import "BaseScrollView.h"

@implementation BaseScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//-(BOOL)touchesShouldCancelInContentView:(UIView *)view
//{
//    
//    if ([view isKindOfClass:[UITableView class]])
//    {
//        return NO;
//    }
//    
//    return YES;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if ([self panBack:gestureRecognizer]) {
        return YES;
    }
    return NO;
    
}


- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state || UIGestureRecognizerStatePossible == state) {

            
            if (self.contentOffset.y == 156) {
                return NO;
            }
            
                }
        
                }
                return YES;
                
        }

@end
