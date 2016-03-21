//
//  LocalPhotoCell.h
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/7.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"

@interface LocalPhotoCell : BaseCell

@property (strong) UIButton *leftBtn;
@property (strong) UIButton *rightBtn;

@property (strong) UIImageView *ivLoaclPhoto;
@property (strong) UILabel *descLabel;

- (void)updateData:(NSArray *)list;
@end
