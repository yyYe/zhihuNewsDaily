//
//  SettingPageVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/1.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "SettingPageVC.h"
#import "HeadPortrait.h"
#import "AppendNews.h"

#import "AppendEnterPageVC.h"
#import "PersonalHomePageVC.h"

#import "HeaderPhotoCell.h"
#import "AppendNewsCell.h"
#import "LocalPhotoCell.h"


static NSString * const kAppendDetailsURL = @"http://news-at.zhihu.com/api/4/theme/11";

@implementation SettingPageVC

- (void)showContext {
    self.view.backgroundColor = [UIColor clearColor];
    
    view = [UIView new];
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
    [self.tableView registerClass:[LocalPhotoCell class] forCellReuseIdentifier:@"LocalPhotoCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //获取头像图片，取到的是一个字典，只有文本信息和图片，把这当成一个数组存到数组里。现在的问题是存进去是空的
    /*
     [GetNetworkData getAvatarDataWithBlock:^(NSDictionary *data) {
     dictInfo = data;
     headPortrait = [HeadPortrait new];
     headPortrait.avatar = [dictInfo valueForKey:@"avatar"];
     headPortrait.text = [dictInfo valueForKey:@"text"];
     [self.tableView reloadData];
     }];*/
    
    [GetNetworkData getAppendDataWithBlock:^(NSDictionary *dict) {
        array = [dict valueForKey:@"others"];
        NSArray *list = [NSArray yy_modelArrayWithClass:[AppendNews class] json:array];
        
        self.dataArray = @[
                           @[@{
                                 @"avatar":@"a111",
                                 @"text":@"请登录"
                                 },
                             @[@{
                                   @"avatar":@"yellowStar40Disabled",
                                   @"text":@"我的收藏"
                                   },
                               @{
                                   @"avatar":@"myFavourite",
                                   @"text":@"离线下载"
                                   },
                               ]
                             ],
                           @[@{
                                 @"avatar":@"tabBar_essence_click_icon",
                                 @"text":@"首页"
                                 },
                             ],
                           list,
                           ];
        [self.tableView reloadData];
    }];
    
    [GetNetworkData getAppendDetailsDataWithBlock:^(NSDictionary *dict) {
        detailsDict = dict;
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
            return 44.f;
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.font = sizeFont(14);
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:[obj valueForKey:@"avatar"]];
            cell.imageView.layer.cornerRadius = 22;
            cell.imageView.clipsToBounds = YES;//图片等时候需要调用
            cell.textLabel.text = [obj valueForKey:@"text"];
            cell.backgroundColor = BackgroundColor;
        }else {
            LocalPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocalPhotoCell"];
            [cell updateData:obj];
            cell.backgroundColor = BackgroundColor;
            return cell;
        }
    }else if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:[obj valueForKey:@"avatar"]];
        cell.textLabel.text = [obj valueForKey:@"text"];
        cell.backgroundColor = getColor(0.85, 0.85, 0.85);
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AppendNewsCell"];
        ((AppendNewsCell *)cell).dictData = obj;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    id obj = [array objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PersonalHomePageVC *personalVC = [PersonalHomePageVC new];
            [self.navigationController pushViewController:personalVC animated:YES];
        }
        return;
    }else if (indexPath.section == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        
        NSDictionary *dict = [array objectAtIndex:indexPath.row];
        NSNumber *idNumber = [dict valueForKey:@"id"];
        NSString *idString = [idNumber stringValue];
//        NSString *detailsString = [detailsDict valueForKey:@"share_url"];
        //取出点击的cell的id，把它替换到取到的数据接口最后面， 就是需要显示的完整链接
        NSString *WEBString =[kAppendDetailsURL stringByReplacingOccurrencesOfString:@"11" withString:idString];
        AppendEnterPageVC *detailsVC = [AppendEnterPageVC new];
        detailsVC.kJsonString = WEBString;
        [self.navigationController pushViewController:detailsVC animated:YES];

    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    view.hidden = YES;
//    UIView *removeView = self.view;
//    [removeView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
