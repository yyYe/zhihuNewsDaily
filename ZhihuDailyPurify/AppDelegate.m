//
//  AppDelegate.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NavigationController.h"
#import "GetNetworkData.h"
#import "HomePageNewsVC.h"
#import "CommentVC.h"

#define screenSize CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

@interface AppDelegate () {
//    UIView *view;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HomePageNewsVC *newsVC = [HomePageNewsVC new];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:newsVC];
    
    nav.navigationBar.translucent = NO;
    [nav.navigationBar setTintColor:[UIColor whiteColor]];
    //设置显示的颜色
    nav.navigationBar.barTintColor = BackgroundColor;
    nav.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    /*
    [GetNetworkData getIvLogoDataWithBlock:^(NSDictionary *dict) {
        view = [UIView new];
        view.frame = screenSize;
        [self.window addSubview:view];
        
        UIImageView *ivLogo = [UIImageView new];
        ivLogo.frame = screenSize;
        [ivLogo sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"img"]]];
        [view addSubview:ivLogo];
    }];
    
    //进入app显示图片3秒，
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.hidden = YES;
    });
    */
     
    return YES;
}

@end
