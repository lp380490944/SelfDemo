//
//  TableViewCell.h
//  tableview的嵌套
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPListModel.h"

@interface TableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property(nonatomic,strong)NSMutableArray * commentLsit;//评论列表
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentTableViewHeight;//tableviewView的高度约束

- (void)configureCellWithModel:(LPListModel *)model withIndexpath:(NSIndexPath *)indexPath;
@end
