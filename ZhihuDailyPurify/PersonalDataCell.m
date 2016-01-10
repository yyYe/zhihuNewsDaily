//
//  PersonalDataCell.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/9.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalDataCell.h"

#define ivPhotoSize 40

@interface PersonalDataCell () {
    UILabel *describe;
}

@end

@implementation PersonalDataCell

- (void)layout {
    
    self.ivPhoto = [UIImageView new];
    self.ivPhoto.layer.cornerRadius = ivPhotoSize/2;
    self.ivPhoto.clipsToBounds = YES;
    [self addSubview:self.ivPhoto];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = sizeFont(13);
    [self addSubview:self.titleLabel];
    
    describe = [UILabel new];
    describe.font = sizeFont(11);
    [self addSubview:describe];
    
    [self.ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.right.equalTo(self.titleLabel.mas_left).offset(-10);
        make.height.width.equalTo(@(ivPhotoSize));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivPhoto.mas_right).offset(10);
        make.top.equalTo(self.ivPhoto);
    }];
    
    [describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.ivPhoto.mas_bottom);
    }];
}

- (void)setDictData:(id)dictData {
    [self.ivPhoto sd_setImageWithURL:[NSURL URLWithString:[dictData valueForKey:@"avatar"]]];
    self.titleLabel.text = [dictData valueForKey:@"title"];
    describe.text = [dictData valueForKey:@"describe"];
}

@end
