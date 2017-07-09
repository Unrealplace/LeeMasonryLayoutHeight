//
//  LeeShowModel.h
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LeeShowModel : NSObject

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,strong)UIImage * contentImage;
@property(nonatomic,assign)BOOL update;
@end
