//
//  TopStoriesCell.m
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import "TopStoriesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

@interface TopStoriesCell () {
    NSInteger number;
}

@end

@implementation TopStoriesCell

- (void)layout {
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = YES;
    scrollView.contentOffset = CGPointMake(0, 0);
    
    //判断，获取的data.count 数组的长度是多少就显示多少个320；
    scrollView.contentSize = CGSizeMake(320 * number, 0);
    [self addSubview:scrollView];
    
    self.ivPhoto = [UIImageView new];
    [scrollView addSubview:self.ivPhoto];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:17.f];
    self.titleLabel.numberOfLines = 0;
    [self.ivPhoto addSubview:self.titleLabel];
    
    [self.ivPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivPhoto).offset(20);
        make.bottom.equalTo(self.ivPhoto).offset(-30);
    }];
    
}

- (void)setDictData:(NSDictionary *)dictData {
    number = dictData.count;
    [self.ivPhoto sd_setImageWithURL:[dictData valueForKey:@"image"]];
    self.titleLabel.text = [dictData valueForKey:@"title"];
}
@end
