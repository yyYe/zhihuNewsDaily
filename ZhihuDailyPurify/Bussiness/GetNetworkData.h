//
//  GetNetworkData.h
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetNetworkData : NSObject

#pragma mark 首页内容
+ (void)getNewDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getDateDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getIvLogoDataWithBlock:(void(^)(NSDictionary *dict))data;

#pragma mark 导航栏左边添加页面
+ (void)getAppendDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getAppendDetailsDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getPhotoDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getAvatarDataWithBlock:(void(^)(NSDictionary *dict))data;

#pragma mark 描述页面内容
+ (void)getDetailsDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getStoryExtraDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getLongCommentDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getShortCommentDataWithBlock:(void(^)(NSDictionary *dict))data;
@end
