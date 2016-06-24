//
//  HeaderView.m
//  带扩展的tableView
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor purpleColor];
    self.backgroundColor = [UIColor purpleColor];
    
}
- (IBAction)btnDidCilicked:(id)sender {
    
    self.model.isExpanded = !self.model.isExpanded;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (self.model.isExpanded) {
            
            self.expandImgView.transform = CGAffineTransformIdentity;
        }else{
            self.expandImgView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }];
    
    if (self.expandCallBack) {
        
        self.expandCallBack(self.model.isExpanded);
    }
    
}

- (void)setModel:(SectionModel *)model
{
    
    if (_model != model) {
        _model = model;
        self.titleLabel.text = model.sectionTitle;
    }
    
    
    if (model.isExpanded) {
        self.expandImgView.transform = CGAffineTransformIdentity;
    } else {
        self.expandImgView.transform = CGAffineTransformMakeRotation(M_PI);
    }

    
}

@end
