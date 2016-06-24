//
//  MyTableViewCell.m
//  Masonry与FDTemplateLayoutCell
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyTableViewCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface MyTableViewCell ()

@property(strong,nonatomic)UIImageView * imgeView;
@property(strong,nonatomic)UILabel * label;

@end

@implementation MyTableViewCell

 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        
        self.imgeView = [UIImageView new];
        self.label = [UILabel new];
        self.label.numberOfLines = 0;
        [self.contentView addSubview:self.imgeView];
        [self.contentView addSubview:_label];
        [self.imgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.right.equalTo(self.label.mas_left);
            make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom);
        }];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgeView.mas_right);
            make.top.equalTo(self.imgeView);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView);
            make.bottom.offset(-8);
        }];
        
        
    }
    
    
    
    return self;
}

- (void)setModel:(MyModel *)model
{
    _model = model;

    [self.imgeView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.label.text = model.intro;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
