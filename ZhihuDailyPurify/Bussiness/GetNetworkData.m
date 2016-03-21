//
//  GetNetworkData.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "GetNetworkData.h"
#import <AFNetworking/AFNetworking.h>

#define getData(dataChining)

//今日新闻
static NSString * const kNewsURL = @"http://news-at.zhihu.com/api/4/stories/latest";

//日期内容
//static NSString * const kDateURL = @"http://news-at.zhihu.com/api/4/stories/before/20151231";

//打开界面图片
static NSString * const kIvLogoURL = @"http://news-at.zhihu.com/api/4/start-image/1080*1776";

#pragma mark 描述页面内容
//点击新闻跳转页面,新闻详情页面
static NSString * const kDetailsURL = @"http://news-at.zhihu.com/api/4/news/3892357";

//网页导航栏上的评论数和点赞数
static NSString * const kStoryExtraURL = @"http://news-at.zhihu.com/api/4/story-extra/7696848";

//查看长评论链接
static NSString *const kLongCommentsURL = @"http://news-at.zhihu.com/api/4/story/7696848/long-comments";

//查看短评论链接
static NSString *const kShortCommentsURL = @"http://news-at.zhihu.com/api/4/story/7696848/short-comments";

#pragma mark 导航栏左边信息按钮
//登录成功的头像链接
static NSString * const kPhotoURL = @"http://news-at.zhihu.com/api/4/account";

static NSString * const kAvatarURL = @"http://news-at.zhihu.com/api/4/login";

//左边按钮添加显示内容
static NSString * const kAppendURL = @"http://news-at.zhihu.com/api/4/themes";

//左边按钮，点击添加过的主题，跳转详情页
static NSString * const kAppendDetailsURL = @"http://news-at.zhihu.com/api/4/theme/11";


@implementation GetNetworkData

#pragma mark 新闻列表信息
+ (void)getNewDataWithBlock:(void (^)(NSDictionary *))data {
    [self outPutResultdata:kNewsURL dictDataBlock:data];
}

#pragma mark 上啦更新信息

+ (NSString *)fetchURLWithDataIndex {
    
    NSDate *date = [NSDate date];
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSInteger dateTime = [[formatter stringFromDate:date] integerValue];
    NSString *urlString = [NSString stringWithFormat: @"http://news-at.zhihu.com/api/4/stories/before/%d",dateTime];
    return urlString;
}

+ (void)getDateDataWithBlock:(void (^)(NSDictionary *))data {
    [self outPutResultdata:[self fetchURLWithDataIndex] dictDataBlock:data];

}

#pragma mark 打开app界面显示三秒图片
+ (void)getIvLogoDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kIvLogoURL dictDataBlock:data];
}

#pragma mark 左边按钮显示添加新闻内容
+ (void)getAppendDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kAppendURL dictDataBlock:data];
}


+ (void)getAppendDetailsDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kAppendDetailsURL dictDataBlock:data];
}

#pragma mark 新闻详情页面

+ (void)getDetailsDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kDetailsURL dictDataBlock:data];
}

+ (void)getStoryExtraDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kStoryExtraURL dictDataBlock:data];
}

+ (void)getLongCommentDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kLongCommentsURL dictDataBlock:data];
}

+ (void)getShortCommentDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kShortCommentsURL dictDataBlock:data];
}

#pragma mark 登录成功的头像链接
+ (void)getPhotoDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kPhotoURL dictDataBlock:data];
}

#pragma mark 登录成功的头像链接
+ (void)getAvatarDataWithBlock:(void(^)(NSDictionary *dict))data {
    [self outPutResultdata:kAvatarURL dictDataBlock:data];
}

//提取相同的代码，防灾一个方法中
+ (void)outPutResultdata:(NSString *)string dictDataBlock:(void(^)(NSDictionary *dict))data {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        data(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    }];
}

@end
