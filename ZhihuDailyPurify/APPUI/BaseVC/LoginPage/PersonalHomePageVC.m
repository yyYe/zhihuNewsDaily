//
//  PersonalHomePageVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/5.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalHomePageVC.h"
#import "PersonalLayout.h"
#import <Masonry/Masonry.h>
#import "SettingPageVC.h"


@implementation PersonalHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIEventSubtypeNone;
//    [self layout];
    [self navigationsController];
    PersonalLayout *personal = [PersonalLayout new];
    [personal showLayout];
    [self.view addSubview:personal];
}

- (void)navigationsController {
    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"buyListRecipeButtonNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeftButtonContext)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Icon-40"] style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)showLeftButtonContext {
    SettingPageVC *pageVC = [SettingPageVC new];
    [self.navigationController addChildViewController:pageVC];
    [self.navigationController.view addSubview:pageVC.view];
    
}

@end
