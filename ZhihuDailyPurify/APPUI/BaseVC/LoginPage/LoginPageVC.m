//
//  LoginPageVC.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "LoginPageVC.h"
#import <TencentOpenAPI/TencentOAuth.h>

#define ButtonStyle [UIButton buttonWithType:UIButtonTypeRoundedRect]
#define PhotoName(name) ([[UIImageView alloc] initWithImage:[UIImage imageNamed:name]])
#define buttonTitle(name) setTitle:name forState:UIControlStateNormal

#define kRedirectURL @"http://www.sina.com"
#define kTencnetURL @"1105023127"

@interface LoginPageVC () <TencentSessionDelegate>  {
    TencentOAuth *tencentOAuth;
}

@end

@implementation LoginPageVC

- (void)showContext {
    
    self.edgesForExtendedLayout = UIEventSubtypeNone;
    self.view.backgroundColor = getColor(0.11, 0.51, 0.84);
    [self navigationsController];
    [self showRegisterPage];
    
    tencentOAuth=[[TencentOAuth alloc]initWithAppId:kTencnetURL andDelegate:self];
    //4，设置需要的权限列表，此处尽量使用什么取什么。
    self.dataArray = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",@"add_t", nil];//@"get_simple_userinfo"可以省略
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
    btnTarget(tenxunBtn, loginAct);
    [tenxunBtn buttonTitle(@"腾讯QQ")];
    
    [self.view addSubview:tenxunBtn];
    
    UIImageView *ivTenxun = PhotoName(@"sync_qzone_selected");
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
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (WBMessageObject *)messageToShare {
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"测试使用";
    return message;
}

- (void)tencentBolgLoginTapped {
    
}

- (void)returnBeforePage {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark login

- (void)loginAct {
    [tencentOAuth authorize:self.dataArray inSafari:NO];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
