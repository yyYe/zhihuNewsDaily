//
//  ShortCommentsCell.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/8.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "ShortCommentsCell.h"
#import <SDWebImage/UIButton+WebCache.h>

#define ivPhotoHeight 40

@interface ShortCommentsCell ()

@property (strong) UIImageView *ivPicture;
@property (strong) UILabel *authorLabel;
@property (strong) UILabel *infoLabel;
@property (strong) UILabel *datelabel;
@property (strong) UIButton *clickBtn;
@property (strong) UILabel *clicklabel;

@end

@implementation ShortCommentsCell

- (void)layout {
    
    self.ivPicture = [UIImageView new];
    self.ivPicture.layer.cornerRadius = ivPhotoHeight/2;
    self.ivPicture.clipsToBounds = YES;
    [self addSubview:self.ivPicture];
    
    self.authorLabel = [UILabel new];
    self.authorLabel.font = sizeFont(13);
    [self.authorLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.authorLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self addSubview:self.authorLabel];
    
    self.infoLabel = [UILabel new];
    self.infoLabel.font = sizeFont(13);
    self.infoLabel.numberOfLines = 0;
    [self addSubview:self.infoLabel];
    
    self.datelabel = [UILabel new];
    self.datelabel.font = sizeFont(11);
    [self.datelabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.datelabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self addSubview:self.datelabel];
    
    self.clickBtn = btnStyle;
    [self addSubview:self.clickBtn];
    
    self.clicklabel = [UILabel new];
    self.clicklabel.font = sizeFont(12);
    [self addSubview:self.clicklabel];
    
    [self.ivPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(20);
        make.height.width.equalTo(@(ivPhotoHeight));
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivPicture);
        make.left.equalTo(self.ivPicture.mas_right).offset(10);
        make.bottom.equalTo(self.infoLabel.mas_top).offset(-10);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(10);
        make.left.equalTo(self.authorLabel);
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self.datelabel.mas_top).offset(-15);
    }];
    
    [self.datelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(self.authorLabel);
    }];
    
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.clicklabel.mas_left).offset(-5);
        make.top.equalTo(self.ivPicture);
    }];
    
    [self.clicklabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivPicture);
        make.left.equalTo(self.mas_right).offset(-30);
    }];
    
}

- (void)setDictData:(id)dictData {
    self.authorLabel.text = [dictData valueForKey:@"author"];
    self.infoLabel.text = [dictData valueForKey:@"content"];
    self.datelabel.text = [dictData valueForKey:@"time"];
    [self.ivPicture sd_setImageWithURL:[NSURL URLWithString:[dictData valueForKey:@"avatar"]]];
    [self.clickBtn setImage:[UIImage imageNamed:@"dishPagerLiked"] forState:UIControlStateNormal];
    self.clicklabel.text = [dictData valueForKey:@"likes"];
    
}

@end
