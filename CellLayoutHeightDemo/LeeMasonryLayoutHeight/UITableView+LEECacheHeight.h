//
//  UITableView+LEECacheHeight.h
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (LEECacheHeight)


/**
 缓存Cell高度
 */
@property(nonatomic,strong,readonly)NSMutableDictionary * lee_CacheCellHeightDic;

/**
 保持一个Cell
 */
@property(nonatomic,strong,readonly)NSMutableDictionary * lee_reuserCells;

@end
