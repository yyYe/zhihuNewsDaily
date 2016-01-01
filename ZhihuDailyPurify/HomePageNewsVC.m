//
//  ViewController.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "HomePageNewsVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

#import "GetNetworkData.h"
#import "StoriesModel.h"
#import "StoriesCell.h"
#import "LoginPageVC.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface HomePageNewsVC () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *newsArray;
    NSArray *dateArray;
    BOOL data1Fetched;
    BOOL data2Fetched;
    
    UITableView *tv;
    UIPageControl *pageControl;
    UIScrollView *ScrollView;
    
    NSInteger number;
    NSInteger timeCount;
}

@property (strong) NSArray *dataArray;

@end

@implementation HomePageNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationsController];
    [self TableView];
    
    
}


- (void)TableView {
    tv = [UITableView new];
    tv.dataSource = self;
    tv.delegate = self;
    tv.bounces = NO;
    [self.view addSubview:tv];
    
    [self showHeaderView];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(20);
//        make.right.equalTo(self.view).offset(-20);
        make.edges.equalTo(self.view);
    }];
    
    [tv registerClass:[StoriesCell class] forCellReuseIdentifier:@"HomePageCell"];
    
    data1Fetched = NO;
    data2Fetched = NO;
    [GetNetworkData getNewDataWithBlock:^(NSDictionary *dict) {
        newsArray = [dict valueForKey:@"stories"];
        data2Fetched = YES;
        if (data1Fetched) {
            _dataArray = @[newsArray,dateArray];
        }
        [tv reloadData];
    }];
    
    [GetNetworkData getDateDataWithBlock:^(NSDictionary *dict) {
        dateArray = [dict valueForKey:@"stories"];
        data1Fetched = YES;
        if (data2Fetched) {
            _dataArray = @[newsArray,dateArray];
        }
        [tv reloadData];
    }];
}

- (void)showHeaderView {
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, 0, 215);
    //先取出总共有多少个数组
    [GetNetworkData getNewDataWithBlock:^(NSDictionary *dict) {
        NSArray *list = [dict valueForKey:@"top_stories"];
        
        number = list.count;
        timeCount = 0;
        
        //初始化一个滚动视图
        ScrollView = [UIScrollView new];
        ScrollView.pagingEnabled = YES;
        ScrollView.bounces = NO;
        ScrollView.contentSize = CGSizeMake(screenWidth * number, 0);
        
        ScrollView.showsHorizontalScrollIndicator = NO;
        ScrollView.showsVerticalScrollIndicator = NO;
        [headerView addSubview:ScrollView];
        
        [ScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
        
        //取出每个数组里的图片和标题,添加到滚动视图里，
        for (NSInteger i = 0; i < number; i++) {
            
            NSDictionary *dict = list[i];
            
            UIImageView *ivPhoto = [UIImageView new];
            [ivPhoto sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"image"]]];
            [ScrollView addSubview:ivPhoto];
            
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = [dict valueForKey:@"title"];
            titleLabel.numberOfLines = 0;
            [ScrollView addSubview:titleLabel];
            
            [ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ScrollView).offset(screenWidth * i);
                make.top.right.bottom.equalTo(headerView);
            }];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ScrollView).offset(20 + screenWidth * i);
                make.right.equalTo(ivPhoto).offset(-20);
                make.bottom.equalTo(headerView).offset(-30);
            }];
        }
        
        NSInteger page = 0;
        
        pageControl = [UIPageControl new];
        pageControl.numberOfPages = number;
        pageControl.currentPage = page;
        
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];//滚动颜色
        pageControl.pageIndicatorTintColor = [UIColor grayColor];//背景颜色
//        pageControl.shouldGroupAccessibilityChildren = YES;
        
        [ScrollView addSubview:pageControl];
        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerView);
            make.bottom.equalTo(headerView).offset(-10);
            make.width.equalTo(@30);
            make.height.equalTo(@10);
        }];
    }];
    
    [self.view addSubview:headerView];
    tv.tableHeaderView = headerView;
    
}

//定时滚动
-(void)scrollTimer{
    timeCount ++;
    //当
    if (timeCount == number) {
        timeCount = 0;
    }
    [ScrollView setContentOffset:CGPointMake(screenWidth *1.f * timeCount, 0.0f) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat result = ScrollView.contentOffset.x;
    NSInteger page = result * 1.f/screenWidth;
    pageControl.currentPage = page;
}

//导航栏左边第二个，根据滚动改变名字，给一个事件，传值，再把header的隐藏，
- (void)navigationsController {
    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"buyListRecipeButtonNormal"] style: UIBarButtonItemStylePlain target: self action:nil];
    
    //自定义左右导航项一
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 22, 22);
    [rightBtn1 setBackgroundImage:[UIImage imageNamed:@"convenient_share_other"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtn1Bar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame = CGRectMake(0, 0, 22, 22);
    [rightBtn2 setBackgroundImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(jumpLoginPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn2Bar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn2];
    
    NSArray *rightBtn = [NSArray arrayWithObjects:rightBtn1Bar,rightBtn2Bar, nil];
    self.navigationItem.rightBarButtonItems = rightBtn;
    
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

//根据这里传值给导航栏，
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"今日热闻";
    }
    return @"2015年12月30";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [_dataArray objectAtIndex:section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [_dataArray objectAtIndex:indexPath.section];
    id obj = [array objectAtIndex:indexPath.row];
    StoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell"];
    
    cell.dictData = obj;
    return cell;
}

- (void)jumpLoginPage {
    LoginPageVC *loginVC = [LoginPageVC new];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
