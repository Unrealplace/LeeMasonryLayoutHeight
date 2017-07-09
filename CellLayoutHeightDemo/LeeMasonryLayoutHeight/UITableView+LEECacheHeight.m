//
//  UITableView+LEECacheHeight.m
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "UITableView+LEECacheHeight.h"
#import <objc/runtime.h>

const void * lee_cacheHeight_key = "lee_cacheHeight_key";
const void * lee_reuseCells_key     = "lee_reuseCells_key";

@implementation UITableView (LEECacheHeight)

-(NSMutableDictionary*)lee_CacheCellHeightDic{

    NSMutableDictionary * dic = objc_getAssociatedObject(self, lee_cacheHeight_key);
    if (dic == nil) {
        dic = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, lee_cacheHeight_key, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
    
}
-(NSMutableDictionary*)lee_reuserCells{
    NSMutableDictionary * dic = objc_getAssociatedObject(self, lee_reuseCells_key);
    if (dic == nil) {
        dic = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, lee_reuseCells_key, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

@end
