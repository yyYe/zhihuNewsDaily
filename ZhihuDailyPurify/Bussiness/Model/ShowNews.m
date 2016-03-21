//
//  ShowNews.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/4.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "ShowNews.h"

@implementation ShowNews

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"avatar":@"image",
             @"title":@"title",
             @"num":@"id"
             };
}

@end
