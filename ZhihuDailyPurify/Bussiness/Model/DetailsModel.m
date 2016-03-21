//
//  DetailsModel.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/3.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "DetailsModel.h"

@implementation DetailsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"url":@"share_url",
             };
}

@end
