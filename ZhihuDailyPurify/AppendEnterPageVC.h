//
//  AppendEnterPageVC.h
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/5.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseVC.h"

@interface AppendEnterPageVC : BaseVC {
    NSArray *detailsArray;
    UITableView *tv;
    NSDictionary *webDict;
}

@property (strong) NSString *kJsonString;

@end
