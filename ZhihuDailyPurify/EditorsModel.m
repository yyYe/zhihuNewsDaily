//
//  EditorsModel.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/6.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "EditorsModel.h"

@implementation EditorsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"url":@"url",
             @"avatat":@"avatat",
             @"title":@"name",
             @"describe":@"bio",
             };
}

@end
