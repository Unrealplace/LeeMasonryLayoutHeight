//
//  UITableViewCell+LEEMasonryLayoutHeight.h
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^LeeCellConfigBlock)(UITableViewCell*sourceCell);
typedef NSDictionary *(^LeeCacheHeight)(void);

FOUNDATION_EXTERN NSString * const kLEECacheUniqueKey;
FOUNDATION_EXTERN NSString * const kLEECacheHeightKey;
FOUNDATION_EXTERN NSString * const kLEERecalcutateForStateKey;
FOUNDATION_EXTERN NSString * const kLEECacheForTableViewkey;


@interface UITableViewCell (LEEMasonryLayoutHeight)


/**
 距离底部的cell 偏移，不写默认为0,此处一般根据UI 需求来改动
 注意  :
 cell 布局中要加入这句话 ，不然有时计算的高度有问题
 contentLabel.numberOfLines = 0;
 contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
 // 应该始终要加上这一句
 // 不然在6/6plus上就不准确了
 // 原因：cell中的多行UILabel，如果其width不是固定的话（比如屏幕尺寸不同，width不同），
 要手动设置其preferredMaxLayoutWidth。 因为计算UILabel的intrinsicContentSize需要预先确定其width才行
 */
@property(nonatomic,assign)CGFloat lee_bottomOffSetToCell;


/**
 外部调用接口获取行高接口
 
 @param tableView 布局的tableview
 @param configBlock 配置cell 的block
 @param cacheHeightBlock 缓存cell 高度的block
 @return 返回cell 的高度
 */
+(CGFloat)lee_getHeightForTableView:(UITableView*)tableView
                         cellConfig:(LeeCellConfigBlock)configBlock
                        cacheHeight:(LeeCacheHeight)cacheHeightBlock;


@end
