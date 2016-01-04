//
//  BaseVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/2.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseVC.h"

#define topHeight 20

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIEventSubtypeNone;
    //修改状态栏颜色,状态栏时导航栏的一部分
//    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
//    statusBarView.backgroundColor=[UIColor blackColor];
//    [self.navigationController.navigationBar addSubview:statusBarView];
    
    self.tableView = [UITableView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self showContext];
    
    
}

- (void)showContext {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
