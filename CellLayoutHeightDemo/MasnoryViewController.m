//
//  MasnoryViewController.m
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "MasnoryViewController.h"
#import "Masonry.h"
#import "LeeShowCell.h"
#import "LeeShowModel.h"
#import "UITableViewCell+LEEMasonryLayoutHeight.h"

static NSString * CellId = @"cellid";

@interface MasnoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property(nonatomic,copy)NSString* randomTitle;
@property(nonatomic,copy)NSString* randomContent;
@property(nonatomic,strong)UIImage * randomImage;


@end

@implementation MasnoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _dataSource = [NSMutableArray arrayWithCapacity:0];
    [self setData];
    
    NSMutableDictionary * diccc = [NSMutableDictionary dictionary];
    diccc[@"name"] = @"oliver";
    NSLog(@"%@",diccc);
    
    
    
}

-(NSString*)randomTitle{

    return [@"大家好这是一个title：" stringByAppendingString:[NSString stringWithFormat:@"%d",arc4random()]];
}

-(NSString*)randomContent{

    return @"LeeMasonryLayoutHeight是基于Masonry第三方开源库而实现的，如想更深入了解Masonry，可直接到github上的官方文档阅读，或可以到作者的博客中阅读相关文章：http://www.baidu.com，如果阅读时有疑问，可直接联系作者（email或者QQ），最直接的方式就是在文章后面留言，作者会在收到反馈后的第一时间迅速查看，并给予相应的回复。欢迎留言，希望我们能成为朋友。";
}

-(UIImage*)randomImage{

    
    return [UIImage imageNamed:[NSString stringWithFormat:@"%d",arc4random() % 5]];

}

-(void)setData{

    for (int i = 0; i<50; i++) {
        LeeShowModel * model = [[LeeShowModel alloc] init];
        model.title = self.randomTitle;
        model.content = self.randomContent;
        model.contentImage = self.randomImage;
        [_dataSource addObject:model];
    }
    [self.tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    LeeShowModel * model = _dataSource[indexPath.row];
    NSString * cacheHeightKey = model.update == YES ?@"update":@"noupdate";
    CGFloat height = [LeeShowCell lee_getHeightForTableView:tableView
                                                 cellConfig:^(UITableViewCell *sourceCell) {
                                                     [(LeeShowCell*)sourceCell configCellWith:model];
                                                 } cacheHeight:^NSDictionary *{
                                                     return @{
                                                              kLEECacheUniqueKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]//设置每一个高度字典的唯一标识。
                                                              ,kLEECacheHeightKey:cacheHeightKey//设置不同状态的标识。比如某个cell 做了动画从新布局，高度要变化了。
                                                              ,kLEERecalcutateForStateKey:@(NO)//标识别是否重新计算，一般设置为NO 防止好性能。
                                                              };
                                                 }];
     return height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LeeShowCell * cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    LeeShowModel * model = _dataSource[indexPath.row];
    if (!cell) {
        cell = [[LeeShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    [cell configCellWith:model];
    cell.expandBlock = ^(BOOL isExpand) {
        model.update = isExpand;
        [tableView reloadRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
    
}

@end
