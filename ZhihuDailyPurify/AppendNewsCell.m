//
//  FirstCell.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/3.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AppendNewsCell.h"

@implementation AppendNewsCell

- (void)layout {
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:15.f];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];
    
    self.ivPhoto = [UIImageView new];
    self.ivPhoto.image = [UIImage imageNamed:@"homepageCreateRecipeButton"];
    [self addSubview:self.ivPhoto];
    
    [self.ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-100);
        make.centerY.equalTo(self);
    }];
}

- (void)setDictData:(NSDictionary *)dictData {
    
    self.titleLabel.text = [dictData valueForKey:@"name"];
}

@end
