//
//  LoginPageVC.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "LoginPageVC.h"
#import <Masonry/Masonry.h>

#define ButtonStyle [UIButton buttonWithType:UIButtonTypeRoundedRect]
#define PhotoName(name) ([[UIImageView alloc] initWithImage:[UIImage imageNamed:name]])

@implementation LoginPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIEventSubtypeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.11 green:0.51 blue:0.84 alpha:1];
    [self navigationsController];
    [self showRegisterPage];
}

- (void)navigationsController {
    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(returnBeforePage)];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
}

- (void)showRegisterPage {
    UIImageView *ivPhoto = PhotoName(@"zhihuLogo");
    [self.view addSubview:ivPhoto];
    [ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(90);
    }];
    
    UILabel *describeLabel = [UILabel new];
    describeLabel.text = @"使用微博登录";
    describeLabel.textColor = [UIColor colorWithRed:0.64 green:0.88 blue:0.95 alpha:1];
    [self.view addSubview:describeLabel];
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(ivPhoto.mas_bottom).offset(80);
    }];
    
    UIButton *xinlangBtn = ButtonStyle;
    xinlangBtn.layer.cornerRadius = 5.f;
    xinlangBtn.backgroundColor = [UIColor whiteColor];
    [xinlangBtn setTitle:@"新浪微博" forState:UIControlStateNormal];
    [self.view addSubview:xinlangBtn];
    
    UIImageView *ivXinlang = PhotoName(@"sync_weibo_selected");
    [xinlangBtn addSubview:ivXinlang];
    
    UIButton *tenxunBtn = ButtonStyle;
    tenxunBtn.layer.cornerRadius = 5.f;
    tenxunBtn.backgroundColor = [UIColor whiteColor];
    [tenxunBtn setTitle:@"腾讯微博" forState:UIControlStateNormal];
    [self.view addSubview:tenxunBtn];
    
    UIImageView *ivTenxun = PhotoName(@"tencent-weibo-B");
    [tenxunBtn addSubview:ivTenxun];
    
    [xinlangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(describeLabel.mas_bottom).offset(20);
        make.height.equalTo(@45);
        make.width.equalTo(@230);
    }];
    
    [ivXinlang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xinlangBtn.mas_left).offset(55);
        make.centerY.equalTo(xinlangBtn);
    }];
    
    [tenxunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(xinlangBtn.mas_bottom).offset(20);
        make.width.height.equalTo(xinlangBtn);
    }];
    
    [ivTenxun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tenxunBtn.mas_left).offset(55);
        make.centerY.equalTo(tenxunBtn);
    }];
    
    UILabel *cautionLabel = [UILabel new];
    cautionLabel.font = [UIFont fontWithName:@"Arial" size:11.f];
    cautionLabel.text = @"知乎日报不会未经同意通过你的微博帐号发布任何消息";
    [self.view addSubview:cautionLabel];
    [cautionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    
}

- (void)returnBeforePage {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
