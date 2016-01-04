//
//  GetNetworkData.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "GetNetworkData.h"
#import <AFNetworking/AFNetworking.h>

//今日新闻
static NSString * const kNewsURL = @"http://news-at.zhihu.com/api/4/stories/latest";

//日期内容
//static NSString * const kDateURL = @"http://news-at.zhihu.com/api/4/stories/before/20151231";

//打开界面图片
static NSString * const kIvLogoURL = @"http://news-at.zhihu.com/api/4/start-image/1080*1776";

//左边按钮添加显示内容
static NSString * const kAppendURL = @"http://news-at.zhihu.com/api/4/themes";

//点击新闻跳转页面,新闻详情页面
static NSString * const kDetailsURL = @"http://news-at.zhihu.com/api/4/news/3892357";

//登录成功的头像链接
static NSString * const kPhotoURL = @"http://news-at.zhihu.com/api/4/start-image/1080*1776";

@implementation GetNetworkData

#pragma mark 新闻列表信息
+ (void)getNewDataWithBlock:(void (^)(NSDictionary *))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kNewsURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 上啦更新信息
+ (NSString *)fetchURLWithDataIndex {
    
    NSDate *date = [NSDate date];
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    NSInteger dateTime = [[formatter stringFromDate:date] integerValue];
    
    NSString *urlString = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/stories/before/%d",dateTime];
    
    return urlString;
}

+ (void)getDateDataWithBlock:(void (^)(NSDictionary *))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[self fetchURLWithDataIndex] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 打开app界面显示三秒图片
+ (void)getIvLogoDataWithBlock:(void(^)(NSDictionary *dict))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kIvLogoURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 左边按钮显示添加新闻内容
+ (void)getAppendDataWithBlock:(void(^)(NSDictionary *dict))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kAppendURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 新闻详情页面

+ (void)getDetailsDataWithBlock:(void(^)(NSDictionary *dict))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kDetailsURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 登录成功的头像链接
+ (void)getPhotoDataWithBlock:(void(^)(NSDictionary *dict))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kPhotoURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

@end
