//
//  LocalPhotoCell.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/7.
//  Copyright © 2016年 yeyy. All rights reserved.
//



#import "LocalPhotoCell.h"

@implementation LocalPhotoCell

- (void)layout {
    
    self.leftBtn = btnStyle;
    [self addSubview:self.leftBtn];
    
    self.rightBtn = btnStyle;
    [self addSubview:self.rightBtn];
    
    self.ivPhoto = [UIImageView new];
//    self.ivPhoto.layer.cornerRadius = 10.f;
//    self.ivPhoto.clipsToBounds = YES;
    [self.leftBtn addSubview:self.ivPhoto];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = sizeFont(13);
    self.titleLabel.numberOfLines = 1;
    [self.leftBtn addSubview:self.titleLabel];
    
    self.ivLoaclPhoto = [UIImageView new];
//    self.ivLoaclPhoto.layer.cornerRadius = 15.f;
//    self.ivLoaclPhoto.clipsToBounds = YES;
    [self.rightBtn addSubview:self.ivLoaclPhoto];
    
    self.descLabel = [UILabel new];
    self.descLabel.textColor = [UIColor whiteColor];
    self.descLabel.font = sizeFont(13);
    self.descLabel.numberOfLines = 1;
    [self.rightBtn addSubview:self.descLabel];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self);
        make.left.equalTo(self.mas_centerX);
    }];
    
    [self.ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn).offset(20);
        make.centerY.equalTo(self);
        make.height.width.equalTo(@20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivPhoto.mas_right).offset(20);
        make.centerY.equalTo(self.ivPhoto);
    }];
    
    [self.ivLoaclPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivPhoto);
        make.left.equalTo(self.rightBtn).offset(20);
        make.height.width.equalTo(self.ivPhoto);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivLoaclPhoto.mas_right).offset(20);
        make.centerY.equalTo(self.ivPhoto);
    }];
    
}

- (void)updateData:(NSArray *)list {
    NSDictionary *dict1 = list[0];
    NSDictionary *dict2 = list[1];
    self.ivPhoto.image = [UIImage imageNamed:[dict1 valueForKey:@"avatar"]];
    self.titleLabel.text = [dict1 valueForKey:@"text"];
    
    self.ivLoaclPhoto.image = [UIImage imageNamed:[dict2 valueForKey:@"avatar"]];
    self.descLabel.text = [dict2 valueForKey:@"text"];
}

@end
