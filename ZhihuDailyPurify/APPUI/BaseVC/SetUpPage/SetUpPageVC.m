//
//  SetUpPageVC.m
//  
//
//  Created by loufq on 16/1/5.
//
//

#import "SetUpPageVC.h"
#import "SetUpPageCell.h"

@implementation SetUpPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationsController];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[SetUpPageCell class] forCellReuseIdentifier:@"SetUpPageCell"];
    
    self.dataArray = @[
                       @[@{
                             @"type":@1,
                             @"title":@"自动离线下载",
                             @"describe":@"仅wi-fi下可用，自动下载最新版本",
                             },
                         @{
                             @"type":@1,
                             @"title":@"无图模式",
                             @"describe":@"2G/3G网络下不下载图片",
                             },
                         @{
                             @"type":@1,
                             @"title":@"大字号",
                             },
                         ],
                       @[@{
                             @"type":@1,
                             @"title":@"推送消息",
                             },
                         @{
                             @"type":@1,
                             @"title":@"点评分享到微博",
                             },
                         @{
                             @"type":@2,
                             @"title":@"清除缓存",
                             },
                         @{
                             @"type":@2,
                             @"title":@"检查更新",
                             @"describe":@"版本：2.5.3(390)",
                             },
                         ],
                       @[@{
                             @"type":@2,
                             @"title":@"意见反馈",
                             },
                         ],
                       ];
    
}

- (void)navigationsController {
    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"backStretchBackgroundNormal"] style: UIBarButtonItemStylePlain target:self action:@selector(returnBeformPage)];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list = [self.dataArray objectAtIndex:section];
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 0.0, 300.0, 30.0)];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.opaque = YES;
    headerLabel.textColor = [UIColor colorWithRed:0 green:0.59 blue:0.53 alpha:1];
//    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = sizeFont(13);
    headerLabel.frame = CGRectMake(20.0, 0.0, 300.0, 30.0);
    
    if (section == 0) {
        headerLabel.text =  @"常规";
    }else if (section == 1){
        headerLabel.text = @"其他";
    }else if (section == 2){
        headerLabel.text = @"反馈";
    }
    
    [customView addSubview:headerLabel];
    
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *list = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *dict = [list objectAtIndex:indexPath.row];
    SetUpPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetUpPageCell"];
    cell.dict = dict;
    
    return cell;
}

- (void)returnBeformPage {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
