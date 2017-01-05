//
//  CommentCell.h
//  tableview的嵌套
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPListModel.h"
@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *comment;

- (void)configureCellWithModel:(CommentMessages *)comment indexPath:(NSIndexPath *)indexPath;

@end
