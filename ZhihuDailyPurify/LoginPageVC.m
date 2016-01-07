//
//  LoginPageVC.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "LoginPageVC.h"
#import <WeiboSDK/WeiboSDK.h>

#define ButtonStyle [UIButton buttonWithType:UIButtonTypeRoundedRect]
#define PhotoName(name) ([[UIImageView alloc] initWithImage:[UIImage imageNamed:name]])
#define buttonTitle(name) setTitle:name forState:UIControlStateNormal

#define kRedirectURL @"http://www.sina.com"

@implementation LoginPageVC

- (void)showContext {
    
    self.edgesForExtendedLayout = UIEventSubtypeNone;
    self.view.backgroundColor = getColor(0.11, 0.51, 0.84);
    [self navigationsController];
    [self showRegisterPage];
}

- (void)navigationsController {
    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(returnBeforePage)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
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
    describeLabel.textColor = getColor(0.64, 0.88, 0.95);
    [self.view addSubview:describeLabel];
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(ivPhoto.mas_bottom).offset(80);
    }];
    
    UIButton *xinlangBtn = ButtonStyle;
    xinlangBtn.layer.cornerRadius = 5.f;
    btnTarget(xinlangBtn, loginWeiboTapped);
    xinlangBtn.backgroundColor = [UIColor whiteColor];
    [xinlangBtn buttonTitle(@"新浪微博")];
    [self.view addSubview:xinlangBtn];
    
    UIImageView *ivXinlang = PhotoName(@"sync_weibo_selected");
    [xinlangBtn addSubview:ivXinlang];
    
    UIButton *tenxunBtn = ButtonStyle;
    tenxunBtn.layer.cornerRadius = 5.f;
    tenxunBtn.backgroundColor = [UIColor whiteColor];
    [tenxunBtn buttonTitle(@"腾讯微博")];
    
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

- (void)loginWeiboTapped {
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare {
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"测试使用";
    return message;
}

- (void)returnBeforePage {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
