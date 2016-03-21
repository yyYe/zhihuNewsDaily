//
//  ShortComments.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/8.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "ShortComments.h"

@implementation ShortComments

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"author":@"author",
             @"content":@"content",
             @"avatat":@"avatat",
             @"time":@"time",
             @"ID":@"id",
             @"likes":@"likes",
             };
}

@end
