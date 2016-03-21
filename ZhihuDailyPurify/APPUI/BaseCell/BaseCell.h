//
//  BaseCell.h
//  ZhihuDailyPurify
//
//  Created by loufq on 15/12/31.
//  Copyright © 2015年 yeyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

#define sizeFont(number) [UIFont fontWithName:@"Arial" size:number]
#define btnStyle [UIButton buttonWithType:UIButtonTypeRoundedRect]
#define btnTarget(btn,name) [btn addTarget:self action:@selector(name) forControlEvents:UIControlEventTouchUpInside]

@interface BaseCell : UITableViewCell

@property (strong) UIImageView *ivPhoto;
@property (strong) UILabel *titleLabel;

- (void)layout;
@end
