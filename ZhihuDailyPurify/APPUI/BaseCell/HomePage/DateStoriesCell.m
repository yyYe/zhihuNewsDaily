//
//  DateStoriesCell.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "DateStoriesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@implementation DateStoriesCell
- (void)layout {
    
    self.ivPhoto = [UIImageView new];
    [self addSubview:self.ivPhoto];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.f];
    self.titleLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(20);
        make.right.equalTo(self.ivPhoto.mas_left).offset(-15);
    }];
    
    [self.ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(15);
        make.top.equalTo(self).offset(10);
        make.right.bottom.equalTo(self).offset(-20);
        make.width.equalTo(@70);
    }];
    
}

- (void)setDictData:(NSDictionary *)dictData {
    [self.ivPhoto sd_setImageWithURL:[dictData valueForKey:@"images"][0]];
    self.titleLabel.text = [dictData valueForKey:@"title"];
}

@end
