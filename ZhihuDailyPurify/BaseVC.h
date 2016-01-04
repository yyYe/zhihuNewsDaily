//
//  BaseVC.h
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/2.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import "GetNetworkData.h"
#import <YYModel/YYModel.h>
#import <UINavigationBar+Awesome.h>

#define getColor(_r,_g,_b) ([UIColor colorWithRed:_r green:_g blue:_b alpha:1])
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define BackgroundColor [UIColor colorWithRed:0 green:0.64 blue:0.92 alpha:1]

@interface BaseVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong) UITableView *tableView;

@property (strong) NSArray *dataArray;

- (void)showContext;
@end
