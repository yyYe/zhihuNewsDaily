//
//  BaseVC.h
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/2.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import "GetNetworkData.h"
#import <YYModel/YYModel.h>
#import <UINavigationBar+Awesome.h>
#import <AFNetworking/AFNetworking.h>

#define getColor(_r,_g,_b) ([UIColor colorWithRed:_r green:_g blue:_b alpha:1])
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define BackgroundColor [UIColor colorWithRed:0 green:0.64 blue:0.92 alpha:1]
#define headerTableView 215
#define sizeFont(number) [UIFont fontWithName:@"Arial" size:number]

#define btnStyle [UIButton buttonWithType:UIButtonTypeRoundedRect]
#define btnHorizontal(btn) btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
#define btnWidth(btn) btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
#define btnTitleColor(btn) [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]
#define btnTitle(btn,title) [btn setTitle:title forState:UIControlStateNormal]
#define btnTarget(btn,name) [btn addTarget:self action:@selector(name) forControlEvents:UIControlEventTouchUpInside]
#define btnImage(btn,image) [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal]
#define buttonStyle(btn) UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom]

#define barBtnItem(btn,viewName) UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:viewName]


@interface BaseVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong) UITableView *tableView;

@property (strong) NSArray *dataArray;

- (void)showContext;
@end
