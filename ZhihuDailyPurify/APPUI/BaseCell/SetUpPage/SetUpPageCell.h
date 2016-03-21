//
//  SetUpPageCell.h
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/5.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseCell.h"

@interface SetUpPageCell : BaseCell {
    UILabel *titleLabel;
    UILabel *describeLabel;
}

@property (strong, nonatomic) NSDictionary *dict;
@end
