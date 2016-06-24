//
//  SectionModel.h
//  带扩展的tableView
//
//  Created by apple on 16/6/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject
@property(nonatomic,strong)NSString * sectionTitle;//区头的标题
@property(nonatomic,assign)BOOL isExpanded;//是否展开
@property(nonatomic,strong)NSMutableArray * cellModels;//存放cellmodel
@end


@interface CellModel : NSObject
@property(nonatomic,strong)NSString * cellTitle;//cell的标题
@end