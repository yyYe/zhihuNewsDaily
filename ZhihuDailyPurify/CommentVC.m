//
//  CommentVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/7.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CommentVC.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "ShortCommentsCell.h"
#import "ShortComments.h"

//查看长评论链接
static NSString *const kLongCommentsURL = @"http://news-at.zhihu.com/api/4/story/7696848/long-comments";

//查看短评论链接
static NSString *const kShortCommentsURL = @"http://news-at.zhihu.com/api/4/story/7696848/short-comments";


@implementation CommentVC

- (void)showContext {
    [self navigationsController];
    
    [self tableHeaderViewAndTableFooterView];
}

- (void)navigationsController {
    //导航栏标题，根据section的内容而改变
    //    self.navigationItem.title = @"首页";
    
    //自定义左边导航栏按钮
    buttonStyle(leftBtn1);
    leftBtn1.frame = CGRectMake(0, 0, 22, 22);
    btnImage(leftBtn1, @"backStretchBackgroundNormal");
    btnTarget(leftBtn1, returnBeformPage);
    barBtnItem(leftBtn1Bar, leftBtn1);
    
    NSString *commentsString = [NSString stringWithFormat:@"%@条点评",_comments];
    buttonStyle(leftBtn2);
    leftBtn2.titleLabel.font = sizeFont(15);
    leftBtn2.frame = CGRectMake(0, 0, 80, 22);
    btnTitle(leftBtn2, commentsString);
    barBtnItem(leftBtn2Bar, leftBtn2);
    
    NSArray *leftBtn = [NSArray arrayWithObjects:leftBtn1Bar,leftBtn2Bar, nil];
    self.navigationItem.leftBarButtonItems = leftBtn;
    
    //自定义右边导航栏按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"Icon-41"] style:UIBarButtonItemStylePlain target:self action:nil];
    
}

- (void)shortCommentsBtnTapped {
    UITableView *tv = [UITableView new];
    tv.dataSource = self;
    tv.delegate = self;
    tv.tag = 200;
    tv.rowHeight = UITableViewAutomaticDimension;
    tv.rowHeight = 200;
    [self.view addSubview:tv];
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [tv registerClass:[ShortCommentsCell class] forCellReuseIdentifier:@"ShortCommentsCell"];
    
    NSString *storyExtraString =[kShortCommentsURL stringByReplacingOccurrencesOfString:@"7696848" withString:_idString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:storyExtraString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        listData = [responseObject valueForKey:@"comments"];
        listData = [NSArray yy_modelArrayWithClass:[ShortComments class] json:listData];
        [tv reloadData];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    }];
    
}

- (void)tableHeaderViewAndTableFooterView {
    
    [self.view addSubview:self.tableView];
    self.tableView.tag = 100;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = BackgroundColor;
    headerView.frame = CGRectMake(0, 0, 0, 44);
    
    UILabel *longCommentsLabel = [UILabel new];
    longCommentsLabel.font = sizeFont(13);
    longCommentsLabel.text = [NSString stringWithFormat:@"%@条长评",_longComments];
    [headerView addSubview:longCommentsLabel];
    [longCommentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(20);
        make.centerY.equalTo(headerView);
    }];
    
    self.tableView.tableHeaderView = headerView;
    
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, 0, 44);
    
    UIButton *shortBtn = btnStyle;
    shortBtn.backgroundColor = [UIColor redColor];
    btnTarget(shortBtn, shortCommentsBtnTapped);
    [footerView addSubview:shortBtn];
    [shortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(footerView);
    }];
    
    UILabel *shortCommentsLabel = [UILabel new];
    shortCommentsLabel.font = sizeFont(13);
    shortCommentsLabel.text = [NSString stringWithFormat:@"%@条短评",_shortComments];
    [footerView addSubview:shortCommentsLabel];
    [shortCommentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).offset(20);
        make.centerY.equalTo(footerView);
    }];
    self.tableView.tableFooterView = footerView;

}

- (void)getLongCommentsData {
//    NSString *longCommentsString = [kLongCommentsURL stringByReplacingOccurrencesOfString:@"7696848" withString:_idString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        return 10;
    }
    return listData.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView.tag == 100) {
//        return 44;
//    }else {
//        return 150;
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 100) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.textLabel.text = [NSString stringWithFormat:@"第%d个cell",indexPath.row];
        return cell;
    }else {
        id shortComments = [listData objectAtIndex:indexPath.row];
        ShortCommentsCell *shortCell = [tableView dequeueReusableCellWithIdentifier:@"ShortCommentsCell"];
        shortCell.dictData = shortComments;
        return shortCell;
    }
    return nil;
}

- (void)returnBeformPage {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
