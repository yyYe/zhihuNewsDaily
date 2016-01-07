//
//  SelectBtnVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/3.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "SelectBtnVC.h"
#import <Masonry/Masonry.h>
#import "SetUpPageVC.h"
#import "PersonalHomePageVC.h"

#define btnHeight 44


@implementation SelectBtnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-5);
        make.top.equalTo(self.view).offset(25);
        make.height.equalTo(@(btnHeight *2));
        make.width.equalTo(@180);
    }];
    
    returnBtn = btnStyle;
    btnTitleColor(returnBtn);
    btnHorizontal(returnBtn);
    btnWidth(returnBtn);
    btnTitle(returnBtn,@"夜间模式");
    btnTarget(returnBtn, updateBackgroundColor);
    [view addSubview:returnBtn];
    
    UIButton *setUpBtn = btnStyle;
    btnTitleColor(setUpBtn);
    btnHorizontal(setUpBtn);
    btnWidth(setUpBtn);
    btnTitle(setUpBtn, @"设置选项");
    btnTarget(setUpBtn, jumpSetUpPageTapped);
    [view addSubview:setUpBtn];
    
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view);
        make.height.equalTo(setUpBtn);
        make.bottom.equalTo(setUpBtn.mas_top);
    }];
    
    [setUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(view);
        make.height.equalTo(returnBtn);
        make.top.equalTo(returnBtn.mas_bottom);
    }];
    
}

- (void)jumpSetUpPageTapped {
    view.hidden = YES;
    SetUpPageVC *setUpVC = [SetUpPageVC new];
    [self.navigationController pushViewController:setUpVC animated:YES];
}

- (void)updateBackgroundColor {
//    if ([returnBtn isEqual: @"夜间模式"]) {
//        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//        btnTitle(returnBtn, @"日间模式");
//    }else {
    //    }
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    btnTitle(returnBtn, @"日间模式");
    if (self.navigationController.navigationBar.barTintColor == [UIColor blackColor]) {
        btnTitleColor(returnBtn);
        btnTitle(returnBtn, @"夜间模式");
    }
//    view.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    view.hidden = YES;
    [self.view removeFromSuperview];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
