//
//  HeadPortrait.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/3.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "HeadPortrait.h"

@implementation HeadPortrait

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"url":@"img",
             @"text":@"text",
             };
}
@end
