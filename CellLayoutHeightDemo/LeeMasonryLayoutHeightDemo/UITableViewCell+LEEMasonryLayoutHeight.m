//
//  UITableViewCell+LEEMasonryLayoutHeight.m
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "UITableViewCell+LEEMasonryLayoutHeight.h"
#import "UITableView+LEECacheHeight.h"
#import <objc/runtime.h>

NSString * const kLEECacheUniqueKey           = @"kLEECacheUnipueKey";
NSString * const kLEECacheHeightKey            = @"kLEECacheHeightKey";
NSString * const kLEERecalcutateForStateKey = @"kLEERecalcutateForStateKey";
NSString * const kLEECacheForTableViewkey  =  @"kLEECacheForTableViewkey";

const void * lee_bottomOffSetToCellKey         = "lee_bottomOffSetToCellKey";

@implementation UITableViewCell (LEEMasonryLayoutHeight)

/**
 外部接口获取cell的行高

 @param tableView 外部传入的tableview
 @param configBlock 配置cell 的数据源
 @param cacheHeightBlock 缓存行高的block
 @return 返回对应的行高
 */
+(CGFloat)lee_getHeightForTableView:(UITableView *)tableView
                         cellConfig:(LeeCellConfigBlock)configBlock
                        cacheHeight:(LeeCacheHeight)cacheHeightBlock{

    NSAssert(tableView, @"tableview can't be nil");
    //有缓存的行高，直接返回
    if (cacheHeightBlock) {
        @try {
            NSDictionary * cacheKeys = cacheHeightBlock();
            NSString * uniqueKey       = cacheKeys[kLEECacheUniqueKey];//获取唯一标识的key
            NSString * heightKey        = cacheKeys[kLEECacheHeightKey];//获取高度的key
            NSString * shouldUpdate = cacheKeys[kLEECacheForTableViewkey];//获取是否要更新的key
            NSMutableDictionary * cacheDic = tableView.lee_CacheCellHeightDic[uniqueKey];//通过唯一标识获取缓存字典文件
            NSString * cacheHeight   = cacheDic[heightKey];//从缓存字典中读取高度
            //如果缓存的高度为空 或者缓存大的高度字典个数为0 或者需要从新更新布局 ： 就从新配置获取高度
            if (tableView.lee_CacheCellHeightDic.count == 0
                || cacheHeight == nil
                || shouldUpdate.boolValue) {
                //第一次计算获得高度：
                CGFloat height = [self lee_heightForTableView:tableView cellConfig:configBlock];
                if (cacheDic==nil) {//第一次每个唯一的cell 的高度缓存字典为空
                    cacheDic = [[NSMutableDictionary alloc] init];
                    tableView.lee_CacheCellHeightDic[uniqueKey] = cacheDic;//字典中没有这个健值对则创建
                }
                [cacheDic setObject:[NSString stringWithFormat:@"%f",height] forKey:heightKey];
                return height;
            }else if (tableView.lee_CacheCellHeightDic.count != 0
                      && cacheHeight != nil
                      && cacheHeight.integerValue != 0){
                NSLog(@"缓存高度:%@",cacheHeight);
                return cacheHeight.floatValue;
            }

        } @catch (NSException *exception) {
            NSLog(@"%@",exception);
        } @finally {
            
        }
    }
    //没有缓存行高，从新计算
  return   [self lee_heightForTableView:tableView cellConfig:configBlock];
    
}

/**
  计算行高的和重新配置数据的接口

 @param tableView tableview 对象
 @param configBlock 设置cell 的数据
 @return 返回计算的行高
 */
+(CGFloat)lee_heightForTableView:(UITableView *)tableView
                      cellConfig:(LeeCellConfigBlock)configBlock{
  //创建一个cell 对象 ，降低内存使用
    UITableViewCell * cell = [tableView.lee_reuserCells objectForKey:[[self class] description]];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    //继续回调从新配置数据
    if (configBlock) {
        configBlock(cell);
    }
    //配置完成后回调获得高度
    return [cell lee_private_heightForTableView];
    
}

/**
 私有方法计算得到的确切行高
 @return 返回计算得到的行高
 */
-(CGFloat)lee_private_heightForTableView{
  
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];//从新布局cell
    CGFloat rowHeight = 0.0;
    for (UIView *bottomView in self.contentView.subviews) { //遍历cell 上的所有的子控件 获得最大的高度
        if (rowHeight < CGRectGetMaxY(bottomView.frame)) {
            rowHeight = CGRectGetMaxY(bottomView.frame);
        }
    }
    rowHeight+=self.lee_bottomOffSetToCell;
    return rowHeight;
    
}

#pragma --设置距离底部偏移
-(void)setLee_bottomOffSetToCell:(CGFloat)lee_bottomOffSetToCell{

    objc_setAssociatedObject(self, lee_bottomOffSetToCellKey,
                             @(lee_bottomOffSetToCell),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
-(CGFloat)lee_bottomOffSetToCell{
    
    NSNumber * valueObject = objc_getAssociatedObject(self, lee_bottomOffSetToCellKey);
    if ([valueObject respondsToSelector:@selector(floatValue)]) {
        return valueObject.floatValue;
    }
    return 0.0;
}


@end
