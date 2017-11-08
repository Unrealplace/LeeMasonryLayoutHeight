//
//  ViewController.m
//  CellLayoutHeightDemo
//
//  Created by LiYang on 2017/7/9.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MasnoryViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UIButton * masonryBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _masonryBtn= [UIButton new];
    _masonryBtn.backgroundColor = [UIColor redColor];
    [_masonryBtn setTitle:@"leeMasonryLayoutHeight" forState:UIControlStateNormal];
    [self.view addSubview:_masonryBtn];
    [self.view addSubview:_masonryBtn];
    NSLog(@"test dev");
    NSLog(@"test dev");
    NSLog(@"test dev");
    NSLog(@"test dev");
    NSLog(@"test dev");
    NSLog(@"test dev");

    [_masonryBtn addTarget:self action:@selector(manroyClick:) forControlEvents:UIControlEventTouchUpInside];
    [_masonryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(100);
    }];
    
    
}

- (void)manroyClick:(id)sender {
    
    [self.navigationController pushViewController:[MasnoryViewController new] animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
