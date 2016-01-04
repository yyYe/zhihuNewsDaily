//
//  ViewController.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "HomePageNewsVC.h"
#import "StoriesCell.h"
#import "LoginPageVC.h"
#import "SettingPageVC.h"
#import "DetailsPageVC.h"
#import "SelectBtnVC.h"

#import "ShowNews.h"
#import "DetailsModel.h"

#define btnHeight 44
#define btnStyle [UIButton buttonWithType:UIButtonTypeRoundedRect]
#define btnHorizontal(btn) btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
#define btnWidth(btn) btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
#define btnTitleColor(btn) [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]


@interface HomePageNewsVC () {
    NSArray *newsArray;
    NSMutableArray *dateArray;
    BOOL data1Fetched;
    BOOL data2Fetched;
    
    UIPageControl *pageControl;
    UIScrollView *ScrollView;
    
    NSInteger number;
    NSInteger timeCount;
    
    NSDictionary *photoDict;
    UIView *view;
    NSDictionary *webDict;
}


@end

@implementation HomePageNewsVC


- (void)showContext {
    
    self.view.backgroundColor = getColor(0.93, 0.98, 0.94);
    self.tableView.userInteractionEnabled = YES;
    
    [self navigationsController];
    [self TableView];
    
    [GetNetworkData getDetailsDataWithBlock:^(NSDictionary *dict) {
        webDict = dict;
        [self.tableView reloadData];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)TableView {
    
    dateArray = @[].mutableCopy;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
//    self.tableView.frame = CGRectMake(0, 0, screenWidth-20*2, screenHeight);
    [self showHeaderView];
    
    [self.tableView registerClass:[StoriesCell class] forCellReuseIdentifier:@"HomePageCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self showData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    //刷新有问题，没有判断时间
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self showData];
    }];
    
}

- (void)showData {
    
    data1Fetched = NO;
    data2Fetched = NO;
    [GetNetworkData getNewDataWithBlock:^(NSDictionary *dict) {
        newsArray = [dict valueForKey:@"stories"];
        NSLog(@"newsArray---%d",newsArray.count);
        data2Fetched = YES;
        if (data1Fetched) {
            self.dataArray = @[newsArray,dateArray];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self.tableView reloadData];
    }];
    
    [GetNetworkData getDateDataWithBlock:^(NSDictionary *dict) {
        NSArray *list = [dict valueForKey:@"stories"];
        [dateArray addObjectsFromArray:list];
        data1Fetched = YES;
        if (data2Fetched) {
            self.dataArray = @[newsArray,dateArray];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    }];
}

- (void)showHeaderView {
    
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, 0, 215);
    [self.view addSubview:headerView];
    //先取出总共有多少个数组
    [GetNetworkData getNewDataWithBlock:^(NSDictionary *dict) {
        NSArray *list = [dict valueForKey:@"top_stories"];
        
        list = [NSArray yy_modelArrayWithClass:[ShowNews class] json:list];
        
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
            make.edges.equalTo(headerView);
        }];
        
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
        
        
        //取出每个数组里的图片和标题,添加到滚动视图里，
        for (NSInteger i = 0; i < number; i++) {
            
            ShowNews *appendNews = list[i];
            
            UIImageView *ivPhoto = [UIImageView new];
            [ivPhoto sd_setImageWithURL:appendNews.url];
            [ScrollView addSubview:ivPhoto];
            
            UILabel *titleLabel = [UILabel new];
            titleLabel.text = appendNews.title;
            titleLabel.numberOfLines = 0;
            [ScrollView addSubview:titleLabel];
            
            [ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ScrollView).offset(screenWidth * i);
                make.top.right.bottom.equalTo(headerView);
            }];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ScrollView).offset(20 + screenWidth * i);
                make.width.equalTo(@(screenWidth-20*2));
                make.bottom.equalTo(headerView).offset(-30);
            }];
        }
        
        NSInteger page = 0;
        
        pageControl = [UIPageControl new];
        pageControl.numberOfPages = number;
        pageControl.currentPage = page;
        
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];//滚动颜色
        pageControl.pageIndicatorTintColor = [UIColor grayColor];//背景颜色
        
        [ScrollView addSubview:pageControl];
        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerView);
            make.bottom.equalTo(headerView).offset(-10);
            make.width.equalTo(@30);
            make.height.equalTo(@10);
        }];
    }];
    
    self.tableView.tableHeaderView = headerView;
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
    NSInteger page = result/screenWidth * 1.f;
    pageControl.currentPage = page;
}

//导航栏左边第二个，根据滚动改变名字，给一个事件，传值，再把header的隐藏，
- (void)navigationsController {
    //导航栏标题，根据section的内容而改变
    self.navigationItem.title = @"首页";
    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"buyListRecipeButtonNormal"] style: UIBarButtonItemStylePlain target: self action:@selector(showLeftButtonContext)];
    
    //自定义左右导航项一
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 22, 22);
    [rightBtn1 setBackgroundImage:[UIImage imageNamed:@"convenient_share_other"] forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(btnSelectAppend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn1Bar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame = CGRectMake(0, 0, 22, 22);
    [rightBtn2 setBackgroundImage:[UIImage imageNamed:@"notification"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(jumpLoginPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn2Bar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn2];
    
    NSArray *rightBtn = [NSArray arrayWithObjects:rightBtn1Bar,rightBtn2Bar, nil];
    self.navigationItem.rightBarButtonItems = rightBtn;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置显示的颜色
    self.navigationController.navigationBar.barTintColor = BackgroundColor;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
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
    NSArray *array = [self.dataArray objectAtIndex:section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    id obj = [array objectAtIndex:indexPath.row];
    StoriesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell"];
    
    cell.dictData = obj;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = [newsArray objectAtIndex:indexPath.row];
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

- (void)jumpLoginPage {
    LoginPageVC *loginVC = [LoginPageVC new];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)btnSelectAppend {
    SelectBtnVC *selectVC = [SelectBtnVC new];
    [self.navigationController addChildViewController:selectVC];
    [self.navigationController.view addSubview:selectVC.view];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    view.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
