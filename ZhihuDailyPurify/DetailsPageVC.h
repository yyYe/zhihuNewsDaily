//
//  DetailsPageVC.h
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/3.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseVC.h"

@interface DetailsPageVC : BaseVC <UIWebViewDelegate> {
    UIButton *rightBtn1;
    UIButton *rightBtn3;
    long rightBtn1Number;
    NSInteger rightBtn3Number;
    UIView *view;
    NSDictionary *dict;
}

@property (strong) UIWebView *webView;
@property (strong) NSURLRequest *request;
@property (strong) NSString *idString;

@end
