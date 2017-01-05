//
//  LPListModel.m
//  tableview的嵌套
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LPListModel.h"

@implementation LPListModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"height"]) return YES;
    return NO;
}
@end
@implementation CommentMessages

@end


