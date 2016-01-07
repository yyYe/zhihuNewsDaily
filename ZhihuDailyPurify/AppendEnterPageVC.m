//
//  AppendEnterPageVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/5.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AppendEnterPageVC.h"
#import "StoriesCell.h"
#import "SettingPageVC.h"
#import "DetailsPageVC.h"
#import "EditorsModel.h"

#import <AFNetworking/AFNetworking.h>

#define customViewHeight 50.0

@implementation AppendEnterPageVC

- (void)showContext {
    [self navigationsController];
    
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.view addSubview:self.tableView];

    [GetNetworkData getDetailsDataWithBlock:^(NSDictionary *dict) {
        webDict = dict;
        [self.tableView reloadData];
    }];
    
    [self.tableView registerClass:[StoriesCell class] forCellReuseIdentifier:@"StoriesCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:self.kJsonString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            self.dataArray = [responseObject valueForKey:@"stories"];
            detailsArray = [responseObject valueForKey:@"editors"];
            
            [self headerTableViewContent:responseObject];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)headerTableViewContent:(NSDictionary *)dict {
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, 0, headerTableView);
    [self.view addSubview:headerView];
    
    UIImageView *ivPhoto = [UIImageView new];
    [ivPhoto sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"image"]]];
    [headerView addSubview:ivPhoto];
    [ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];

    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = sizeFont(13.0);
    titleLabel.numberOfLines = 0;
    titleLabel.text = [dict valueForKey:@"description"];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(20);
        make.right.equalTo(headerView).offset(-20);
        make.bottom.equalTo(headerView).offset(-30);
    }];
    
    self.tableView.tableHeaderView = headerView;
}

- (void)navigationsController {
    //自定义左边导航栏按钮
    UIButton *leftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn1.frame = CGRectMake(0, 0, 22, 22);
    [leftBtn1 setBackgroundImage:[UIImage imageNamed:@"buyListRecipeButtonNormal"] forState:UIControlStateNormal];
    [leftBtn1 addTarget:self action:@selector(showLeftButtonContext) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn1Bar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn1];
    
    UIButton *leftBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn2.frame = CGRectMake(0, 0, 100, 22);
    leftBtn2.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
    [leftBtn2 setTitle:@"不许无聊" forState:UIControlStateNormal];
    UIBarButtonItem *leftBtn2Bar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn2];
    
    NSArray *leftBtn = [NSArray arrayWithObjects:leftBtn1Bar,leftBtn2Bar, nil];
    self.navigationItem.leftBarButtonItems = leftBtn;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return customViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    detailsArray = [NSArray yy_modelArrayWithClass:[EditorsModel class] json:detailsArray];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, customViewHeight)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor whiteColor];

    titleLabel.text = @"主编";
    titleLabel.font = sizeFont(13);
    titleLabel.frame = CGRectMake(10.0, 0, 30.0, customViewHeight);
    [customView addSubview:titleLabel];
    
    for (NSInteger i = 0; i < detailsArray.count; i++) {
        EditorsModel *editors = detailsArray[i];
        UIImageView *ivheadPortrait = [UIImageView new];
        ivheadPortrait.clipsToBounds = YES;
        ivheadPortrait.layer.cornerRadius = 15.0;
        ivheadPortrait.frame = CGRectMake(50 + i * 40, 10, 30, 30);
        [ivheadPortrait sd_setImageWithURL:[NSURL URLWithString:editors.avatar]];
        [customView addSubview:ivheadPortrait];
    }
    
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    StoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoriesCell"];
    
    cell.dictData = dict;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    NSNumber *idNumber = [dict valueForKey:@"id"];
    NSString *idString = [idNumber stringValue];
    //    long num = [idString longValue];
    NSString *webString = [webDict valueForKey:@"share_url"];
    //取出点击的cell的id，把它替换到取到的数据接口最后面， 就是需要显示的完整链接
    NSString *WEBString =[webString stringByReplacingOccurrencesOfString:@"3892357" withString:idString];
    DetailsPageVC *detailsVC = [DetailsPageVC new];
    detailsVC.request = [NSURLRequest requestWithURL:[NSURL URLWithString:WEBString]];
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (void)showLeftButtonContext {
    SettingPageVC *pageVC = [SettingPageVC new];
    [self.navigationController addChildViewController:pageVC];
    [self.navigationController.view addSubview:pageVC.view];
    
}

@end
