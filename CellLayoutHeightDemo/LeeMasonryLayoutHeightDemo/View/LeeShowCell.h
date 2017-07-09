//
//  LeeShowCell.h
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeeShowModel;

typedef void(^LeeExpandBlock)(BOOL isExpand);
@interface LeeShowCell : UITableViewCell{

    @protected
    UIImageView * contentImageView;
    UILabel          * contentLabel;
    UILabel          * titleLabel;
    UIButton        * countBtn;
    
}

@property (nonatomic, copy) LeeExpandBlock expandBlock;
@property (nonatomic, assign) BOOL isExpandedNow;
-(void)configCellWith:(LeeShowModel*)model;


@end
