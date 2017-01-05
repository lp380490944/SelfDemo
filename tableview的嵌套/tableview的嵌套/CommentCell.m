//
//  CommentCell.m
//  tableview的嵌套
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    //  code
    self.comment.preferredMaxLayoutWidth = ScreenWidth - 30;
}
- (void)configureCellWithModel:(CommentMessages *)comment indexPath:(NSIndexPath *)indexPath
{
    
    self.comment.text = comment.commentText;
    NSLog(@"%@",comment.commentText);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
