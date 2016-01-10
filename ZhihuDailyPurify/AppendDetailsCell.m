//
//  AppendDetailsCell.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/9.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AppendDetailsCell.h"

@implementation AppendDetailsCell

- (void)layout {
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.f];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
    }];
    
}

- (void)setDicData:(NSDictionary *)dicData {
    self.titleLabel.text = [dicData valueForKey:@"title"];
}

@end
