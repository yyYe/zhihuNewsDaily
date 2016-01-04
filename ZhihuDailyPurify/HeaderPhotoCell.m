//
//  HeaderPhotoCell.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/3.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "HeaderPhotoCell.h"

@implementation HeaderPhotoCell

- (void)layout {
    
    self.ivPhoto = [UIImageView new];
    self.ivPhoto.layer.cornerRadius = 15.f;
    self.ivPhoto.clipsToBounds = YES;
    [self addSubview:self.ivPhoto];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:13.f];
    self.titleLabel.numberOfLines = 1;
    [self addSubview:self.titleLabel];
    
    [self.ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(6);
        make.right.equalTo(self.titleLabel.mas_left).offset(-20);
        make.height.equalTo(@30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivPhoto.mas_right).offset(20);
        make.centerY.equalTo(self.ivPhoto);
    }];
    
}

- (void)setDictData:(NSDictionary *)dicData {
//    [self.ivPhoto sd_setImageWithURL:[dicData valueForKey:@"url"]];
    self.ivPhoto.image = [UIImage imageNamed:[dicData valueForKey:@"url"]];
    self.titleLabel.text = [dicData valueForKey:@"text"];
}

@end
