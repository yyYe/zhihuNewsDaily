//
//  SettingPageVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/1.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "SettingPageVC.h"
#import "HeadPortrait.h"
#import "HeaderPhotoCell.h"
#import "AppendNews.h"
#import "AppendNewsCell.h"

@implementation SettingPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *view = [UIView new];
    view.userInteractionEnabled = NO;
    view.hidden = YES;
    view.frame = CGRectMake(0, 0, screenWidth-44, screenHeight);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    [self.tableView registerClass:[HeaderPhotoCell class] forCellReuseIdentifier:@"HeaderPhotoCell"];
    [self.tableView registerClass:[AppendNewsCell class] forCellReuseIdentifier:@"AppendNewsCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //获取头像图片，取到的是一个字典，只有文本信息和图片，把这当成一个数组存到数组里。现在的问题是存进去是空的
    /*
     [GetNetworkData getPhotoDataWithBlock:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        NSString *dictString = [dict valueForKey:@"img"];
        HeadPortrait *headPortrait = [HeadPortrait new];
        headPortrait.url = [NSURL URLWithString:dictString];
        headPortrait.text = [dict valueForKey:@"text"];
        self.dataArray = @[
                           headPortrait
                           ];
        [self.tableView reloadData];
    }];*/
    
    [GetNetworkData getAppendDataWithBlock:^(NSDictionary *dict) {
        NSArray *list = [dict valueForKey:@"others"];
        list = [NSArray yy_modelArrayWithClass:[AppendNews class] json:list];
        
        self.dataArray = @[
                         @[@{
                               @"url":@"tabBar_essence_click_icon",
                               @"text":@"首页"
                               },
                           ],
                         @[@{
                               @"url":@"tabBar_essence_click_icon",
                               @"text":@"首页"
                               },
                           ],
                         list,
                         ];
        [self.tableView reloadData];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list = [self.dataArray objectAtIndex:section];
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section == 0) {
            return 100.f;
        }else if (indexPath.section == 1) {
            return 44.f;
        }
        return 44.f;
}

//设置cell点击不会改变cell的背景颜色
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *list = [self.dataArray objectAtIndex:indexPath.section];
    id obj = [list objectAtIndex:indexPath.row];
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderPhotoCell"];
    
    if (indexPath.section == 0) {
        ((HeaderPhotoCell *)cell).dicData = obj;
        cell.backgroundColor = BackgroundColor;
    }else if (indexPath.section == 1) {
        ((HeaderPhotoCell *)cell).dicData = obj;
        cell.backgroundColor = getColor(0.85, 0.85, 0.85);
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AppendNewsCell"];
        ((AppendNewsCell *)cell).dictData = obj;
    }
    
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
