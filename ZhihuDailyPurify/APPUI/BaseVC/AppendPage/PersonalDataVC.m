//
//  PersonalDataVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/9.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalDataVC.h"
#import "PersonalDataCell.h"

@implementation PersonalDataVC

- (void)showContext {
    self.tableView.rowHeight = 60;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:[PersonalDataCell class] forCellReuseIdentifier:@"PersonalDataCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell"];
    cell.dictData = self.dicData;
    return cell;
}

@end
