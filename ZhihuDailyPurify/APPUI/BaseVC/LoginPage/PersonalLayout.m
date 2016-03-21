//
//  PersonalCell.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/5.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalLayout.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "GetNetworkData.h"

#define photoAndNameHeight 45
#define viewAndName 20
#define viewBackGroundColor(view) (view.backgroundColor = [UIColor blackColor])
#define photoWidth 80
#define leftOffset ([UIScreen mainScreen].bounds.size.width/2)

@implementation PersonalLayout

- (void)showLayout {
//    [GetNetworkData getPhotoDataWithBlock:^(NSDictionary *dict) {
//        UIImageView *ivPhoto = [UIImageView new];
//        [ivPhoto sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"img"]]];
//        
//    }];
    
    UIImageView *ivPhoto = [UIImageView new];
    ivPhoto.layer.cornerRadius = photoWidth/2.f;
    ivPhoto.layer.borderWidth = 1;
    [self addSubview:ivPhoto];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"笑了";
    [self addSubview:nameLabel];
    
    UIView *view1 = [UIView new];
    viewBackGroundColor(view1);
    [self addSubview:view1];
    
    UILabel *tenxunLabel = [UILabel new];
    tenxunLabel.text = @"绑定腾讯微博";
    [self addSubview:tenxunLabel];
    
    UIView *view2 = [UIView new];
    viewBackGroundColor(view2);
    [self addSubview:view2];
    
    UILabel *xinlangLabel = [UILabel new];
    xinlangLabel.text = @"解绑新浪微博";
    [self addSubview:xinlangLabel];
    
    UIView *view3 = [UIView new];
    viewBackGroundColor(view3);
    [self addSubview:view3];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.layer.cornerRadius = 10.f;
    loginBtn.layer.borderWidth = 1;
    loginBtn.backgroundColor = [UIColor whiteColor];
    [loginBtn setTitle:@"登入" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:loginBtn];
    
    [ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(100);
        make.centerX.equalTo(self.mas_centerX).offset(leftOffset);
        make.top.equalTo(self).offset(30);
        make.width.height.equalTo(@(photoWidth));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivPhoto);
        make.top.equalTo(ivPhoto.mas_bottom).offset(photoAndNameHeight);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivPhoto);
        make.top.equalTo(nameLabel.mas_bottom).offset(photoAndNameHeight);
        make.width.equalTo(@120);
        make.height.equalTo(@1);
    }];
    
    [tenxunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivPhoto);
        make.top.equalTo(view1.mas_bottom).offset(viewAndName);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivPhoto);
        make.top.equalTo(tenxunLabel.mas_bottom).offset(viewAndName);
        make.width.equalTo(view1);
        make.height.equalTo(view1);
    }];
    
    [xinlangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivPhoto);
        make.top.equalTo(view2.mas_bottom).offset(viewAndName);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivPhoto);
        make.top.equalTo(xinlangLabel.mas_bottom).offset(viewAndName);
        make.width.equalTo(view1);
        make.height.equalTo(view1);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivPhoto);
        make.top.equalTo(view3.mas_bottom).offset(80);
        make.width.equalTo(@85);
        make.height.equalTo(@35);
    }];
    
}



@end
