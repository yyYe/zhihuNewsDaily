//
//  TopStoriesModel.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/2.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "TopStoriesModel.h"
#import "AppendNews.h"

@implementation TopStoriesModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"topStories" : AppendNews.class
             };
}

@end
