//
//  SelectBtnVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/3.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "SelectBtnVC.h"
#import <Masonry/Masonry.h>


#define btnHeight 44
#define btnStyle [UIButton buttonWithType:UIButtonTypeRoundedRect]
#define btnHorizontal(btn) btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
#define btnWidth(btn) btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
#define btnTitleColor(btn) [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]

@implementation SelectBtnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.navigationController.view).offset(-5);
        make.top.equalTo(self.navigationController.view).offset(5);
        make.height.equalTo(@(btnHeight *2));
        make.width.equalTo(@180);
    }];
    
    UIButton *returnBtn = btnStyle;
    btnTitleColor(returnBtn);
    btnHorizontal(returnBtn);
    btnWidth(returnBtn);
    [returnBtn setTitle:@"夜间模式" forState:UIControlStateNormal];
    [view addSubview:returnBtn];
    
    UIButton *setUpBtn = btnStyle;
    btnTitleColor(setUpBtn);
    btnHorizontal(setUpBtn);
    btnWidth(setUpBtn);
    [setUpBtn setTitle:@"设置选项" forState:UIControlStateNormal];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    view.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
