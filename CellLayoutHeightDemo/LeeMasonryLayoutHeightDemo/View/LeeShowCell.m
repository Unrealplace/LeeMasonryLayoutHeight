//
//  LeeShowCell.m
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "LeeShowCell.h"
#import "Masonry.h"
#import "LeeShowModel.h"
#import "UITableViewCell+LEEMasonryLayoutHeight.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation LeeShowCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

-(void)setup{

    contentImageView = [UIImageView new];
    contentLabel          = [UILabel new];
    titleLabel                = [UILabel new];
    countBtn                = [UIButton new];
    
    [self.contentView addSubview:contentImageView];
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:contentLabel];
    [self.contentView addSubview:countBtn];
    countBtn.backgroundColor = [UIColor redColor];
    [countBtn setTitle:@"点我试试" forState:UIControlStateNormal];
    [countBtn addTarget:self action:@selector(updateConstraintsCclik:) forControlEvents:UIControlEventTouchUpInside];
    titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
    }];
    contentLabel.numberOfLines = 0;
    contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
    }];
    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    [countBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.top.mas_equalTo(contentImageView.mas_bottom).offset(10);
    }];
    self.lee_bottomOffSetToCell = arc4random() % 50; //设置cell 距离底部距离随机，以观察效果
    self.isExpandedNow = YES;

}

-(void)configCellWith:(LeeShowModel *)model{

    titleLabel.text = model.title;
    contentLabel.text = model.content;
    contentImageView.image = model.contentImage;
    CGFloat H,W;
    H = contentImageView.image.size.height;
    W = contentImageView.image.size.width;
    contentLabel.numberOfLines = 0;
    contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 50;
    if (model.update != self.isExpandedNow) {
        self.isExpandedNow = model.update;
        if (self.isExpandedNow) {
            [contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.contentView).offset(10);
                make.right.mas_equalTo(self.contentView).offset(-10);
                make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
            }];
            
        } else {
            [contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_lessThanOrEqualTo(60);
            }];
        }
    }
    [contentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(W*0.4);
        make.height.mas_equalTo(H*0.4);
    }];
}

-(void)updateConstraintsCclik:(UIButton*)sender{
    
    if (self.expandBlock) {
        self.expandBlock(!self.isExpandedNow);
    }
}


@end
