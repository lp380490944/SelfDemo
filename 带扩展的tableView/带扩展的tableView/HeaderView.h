//
//  HeaderView.h
//  带扩展的tableView
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionModel.h"

typedef void(^expandCallBack)(BOOL isExpanded);

@interface HeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *expandImgView;
@property(nonatomic,strong)SectionModel * model;//
@property(nonatomic,copy)expandCallBack expandCallBack;
@end
