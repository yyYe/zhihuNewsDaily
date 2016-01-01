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
static NSString * const kDateURL = @"http://news-at.zhihu.com/api/4/stories/before/20151231";

//打开界面图片
static NSString * const kIvLogoURL = @"http://news-at.zhihu.com/api/4/start-image/1080*1776";


@implementation GetNetworkData

+ (void)getNewDataWithBlock:(void (^)(NSDictionary *))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kNewsURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

+ (void)getDateDataWithBlock:(void (^)(NSDictionary *))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kDateURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

+ (void)getIvLogoDataWithBlock:(void(^)(NSDictionary *dict))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kIvLogoURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

@end
