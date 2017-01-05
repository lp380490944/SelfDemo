//
//  TableViewCell.m
//  tableview的嵌套
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TableViewCell.h"
#import <UIImageView+WebCache.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import "CommentCell.h"

@class LPListModel;

@implementation TableViewCell

- (void)awakeFromNib {

    //设置Label的最大宽度限定cell宽度。用来分行显示 。
    //值得注意的是如不设置该属性cell不会换行显示
    self.contentLabel.preferredMaxLayoutWidth = ScreenWidth - 20;
    self.commentTableView.scrollEnabled = NO;
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.commentTableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentMessages * comment = [[CommentMessages alloc] initWithDictionary:self.commentLsit[indexPath.row] error:nil];
    
    
    return [tableView fd_heightForCellWithIdentifier:@"commentCell" configuration:^(CommentCell  *cell) {
        
        [cell configureCellWithModel:comment indexPath:indexPath];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentLsit.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSError * error = nil;
    CommentMessages * comment = [[CommentMessages alloc] initWithDictionary:self.commentLsit[indexPath.row] error:&error];
    NSLog(@"%@",error);
    CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureCellWithModel:comment indexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)configureCellWithModel:(LPListModel *)model withIndexpath:(NSIndexPath *)indexPath
{
    
    self.commentLsit = [NSMutableArray arrayWithArray:model.commentMessages];
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    NSLog(@"%@",model.photo);
    self.commentTableView.dataSource = self;
    self.commentTableView.delegate = self;
    self.userName.text = model.userName;
    self.contentLabel.text = model.message;
    
    CGFloat commentTableviewHeight = 0;
    for (NSDictionary * dic in self.commentLsit) {
        
        CommentMessages * comment = [[CommentMessages alloc] initWithDictionary:dic error:nil];
        
     CGFloat  height = [self.commentTableView fd_heightForCellWithIdentifier:@"commentCell" configuration:^(CommentCell *cell) {
         
         [cell configureCellWithModel:comment indexPath:indexPath];
            
        }];
        
        commentTableviewHeight += height;
        
    }
    
    self.commentTableViewHeight.constant = commentTableviewHeight;
    [self.commentTableView reloadData];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
