//
//  SetUpPageCell.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/5.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "SetUpPageCell.h"

@implementation SetUpPageCell

- (void)layout {

    titleLabel = [UILabel new];
    titleLabel.font = [UIFont fontWithName:@"Arial" size:15.f];
    [self addSubview:titleLabel];
    
    describeLabel = [UILabel new];
    describeLabel.font = [UIFont fontWithName:@"Arial" size:13.f];
    [self addSubview:describeLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(describeLabel.mas_top);
    }];
    
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(titleLabel);
    }];
    
}

- (void)setDict:(NSDictionary *)dict {
    titleLabel.text = [dict valueForKey:@"title"];
    describeLabel.text = [dict valueForKey:@"describe"];
}

@end
