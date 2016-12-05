//
//  UIView+Untill.m
//  QRcodeDemo2
//
//  Created by apple on 2016/12/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+Untill.h"

@implementation UIView (Untill)
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
@end
