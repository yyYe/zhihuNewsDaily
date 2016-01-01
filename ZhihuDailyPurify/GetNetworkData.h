//
//  GetNetworkData.h
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetNetworkData : NSObject

+ (void)getNewDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getDateDataWithBlock:(void(^)(NSDictionary *dict))data;

+ (void)getIvLogoDataWithBlock:(void(^)(NSDictionary *dict))data;
@end
