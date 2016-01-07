//
//  DetailsPageVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/1/3.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "DetailsPageVC.h"
#import "CommentVC.h"

#define string(strName,number) NSString *strName = [NSString stringWithFormat:@"%ld",number+1]
#define ivStyle(ivName,imageName) UIImageView *ivName = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]]
#define labelStyle(labelName) UILabel *labelName = [UILabel new]
#define btnFrame(btn) btn.frame = CGRectMake(0, 0, 22, 22)


//网页导航栏上的评论数和点赞数
static NSString * const kStoryExtraURL = @"http://news-at.zhihu.com/api/4/story-extra/7696848";

@implementation DetailsPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [UIWebView new];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSString *storyExtraString =[kStoryExtraURL stringByReplacingOccurrencesOfString:@"7696848" withString:_idString];
    
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:storyExtraString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            dict = responseObject;
            [self showNavigationBar];
            [self.webView loadRequest:self.request];
            [self.webView.scrollView.mj_header beginRefreshing];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        }];
    }];
    [self.webView.scrollView.mj_header beginRefreshing];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView.scrollView.mj_header endRefreshing];
}

- (void)showNavigationBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"backStretchBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(returnBeformPage)];
    
    NSNumber *number1 = [dict valueForKey:@"popularity"];
    rightBtn1Number = [number1 longValue];
    
    rightBtn1 = [UIButton new];
    rightBtn1.titleLabel.font = sizeFont(13);
    rightBtn1.frame = CGRectMake(0, 0, 30, 22);
    NSString *right1String = [NSString stringWithFormat:@"%ld",rightBtn1Number];
    btnTitle(rightBtn1, right1String);
    barBtnItem(rightBar1, rightBtn1);
    
    buttonStyle(rightBtn2);
    btnFrame(rightBtn2);
    btnImage(rightBtn2,@"dishPagerLiked");
    btnTarget(rightBtn2, rightBtn2Tapped);
    barBtnItem(rightBar2, rightBtn2);

    NSNumber *number2 = [dict valueForKey:@"comments"];
    rightBtn3Number = [number2 integerValue];
    
    rightBtn3 = [UIButton new];
    rightBtn3.titleLabel.font = sizeFont(13);
    btnFrame(rightBtn3);
    NSString *right3String = [NSString stringWithFormat:@"%d",rightBtn3Number];
    btnTitle(rightBtn3, right3String);
    barBtnItem(rightBar3, rightBtn3);
    
    buttonStyle(rightBtn4);
    btnFrame(rightBtn4);
    btnImage(rightBtn4,@"tabCDeselected");
    btnTarget(rightBtn4, rightBtn4Tapped);
    barBtnItem(rightBar4, rightBtn4);
    
    rightBtn5 = btnStyle;
    btnFrame(rightBtn5);
    btnTarget(rightBtn5, rightBtn5Tapped);
    btnImage(rightBtn5,@"yellowStar40Disabled");
    barBtnItem(rightBar5, rightBtn5);
    
    buttonStyle(rightBtn6);
    btnFrame(rightBtn6);
    btnImage(rightBtn6,@"convenient_share_other");
    btnTarget(rightBtn6, rightBtn6Tapped);
    barBtnItem(rightBar6, rightBtn6);
    
    NSArray *barArray = @[rightBar1,rightBar2,rightBar3,rightBar4,rightBar5,rightBar6];
    self.navigationItem.rightBarButtonItems = barArray;
}

- (void)rightBtn2Tapped {
    string(string, rightBtn1Number);
    btnTitle(rightBtn1, string);
}

- (void)rightBtn4Tapped {
    //comments
    NSNumber *commentsNumber = [dict valueForKey:@"comments"];
    NSString *commentsString = [commentsNumber stringValue];
    //long comment
    NSNumber *longCommentNumber = [dict valueForKey:@"comments"];
    NSString *longCommentString = [longCommentNumber stringValue];
    //short comment
    NSNumber *shortCommentNumber = [dict valueForKey:@"comments"];
    NSString *shortCommentString = [shortCommentNumber stringValue];
    
    CommentVC *commentVC = [CommentVC new];
    commentVC.comments = commentsString;
    commentVC.longComments = longCommentString;
    commentVC.shortComments = shortCommentString;
    commentVC.idString = _idString;
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)rightBtn5Tapped {
    btnImage(rightBtn5,@"yellowStar40Enabled");
}

- (void)rightBtn6Tapped {
    view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(50);
        make.width.equalTo(@(screenWidth-20*2));
        make.height.equalTo(@330);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"分享";
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(30);
        make.top.equalTo(view).offset(20);
    }];
    
    //新浪微博
    ivStyle(ivXinLang, @"share_weibo");
    [view addSubview:ivXinLang];
    [ivXinLang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(40);
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.height.width.equalTo(@50);
    }];
    labelStyle(xinLangLabel);
    xinLangLabel.text = @"新浪微博";
    xinLangLabel.font = sizeFont(12.0);
    [view addSubview:xinLangLabel];
    [xinLangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivXinLang);
        make.top.equalTo(ivXinLang.mas_bottom).offset(5);
    }];
    
    //微信
    ivStyle(ivWeiXin, @"share_weixin");
    [view addSubview:ivWeiXin];
    [ivWeiXin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivXinLang.mas_right).offset(30);
        make.top.equalTo(ivXinLang);
        make.height.width.equalTo(ivXinLang);
    }];
    labelStyle(weiXinLabel);
    weiXinLabel.text = @"微信";
    weiXinLabel.font = sizeFont(12.0);
    [view addSubview:weiXinLabel];
    [weiXinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivWeiXin);
        make.top.equalTo(ivWeiXin.mas_bottom).offset(5);
    }];
    
    //微信朋友圈
    ivStyle(ivWeiXinFriend, @"share_weixin_friends");
    [view addSubview:ivWeiXinFriend];
    [ivWeiXinFriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivWeiXin.mas_right).offset(30);
        make.top.equalTo(ivXinLang);
        make.height.width.equalTo(ivXinLang);
    }];
    labelStyle(weiXinFriendLabel);
    weiXinFriendLabel.text = @"微信朋友圈";
    weiXinFriendLabel.font = sizeFont(12.0);
    [view addSubview:weiXinFriendLabel];
    [weiXinFriendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivWeiXinFriend);
        make.top.equalTo(ivWeiXinFriend.mas_bottom).offset(5);
    }];
    
    //印象笔记
    ivStyle(ivImpressionNotes, @"yinxiang_biji");
    ivImpressionNotes.layer.cornerRadius = 25.0;
    [view addSubview:ivImpressionNotes];
    [ivImpressionNotes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivXinLang);
        make.top.equalTo(xinLangLabel.mas_bottom).offset(30);
        make.height.width.equalTo(ivXinLang);
    }];
    labelStyle(ImpressionNotesLabel);
    ImpressionNotesLabel.text = @"印象笔记";
    ImpressionNotesLabel.font = sizeFont(12.0);
    [view addSubview:ImpressionNotesLabel];
    [ImpressionNotesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivImpressionNotes);
        make.top.equalTo(ivImpressionNotes.mas_bottom).offset(5);
    }];
    
    //有道云笔记
    ivStyle(ivCloudNotes, @"youdaoyun_biji");
    ivCloudNotes.layer.cornerRadius = 25.0;
    [view addSubview:ivCloudNotes];
    [ivCloudNotes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivImpressionNotes.mas_right).offset(30);
        make.top.equalTo(ivImpressionNotes);
        make.height.width.equalTo(ivXinLang);
    }];
    labelStyle(CloudNotesLabel);
    CloudNotesLabel.text = @"有道云笔记";
    CloudNotesLabel.font = sizeFont(12.0);
    [view addSubview:CloudNotesLabel];
    [CloudNotesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivCloudNotes);
        make.top.equalTo(ivCloudNotes.mas_bottom).offset(5);
    }];
    
    //QQ
    ivStyle(ivQQ, @"share_qq");
    [view addSubview:ivQQ];
    [ivQQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivCloudNotes.mas_right).offset(30);
        make.top.equalTo(ivCloudNotes);
        make.height.width.equalTo(ivXinLang);
    }];
    labelStyle(qqLabel);
    qqLabel.text = @"QQ";
    qqLabel.font = sizeFont(12.0);
    [view addSubview:qqLabel];
    [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivQQ);
        make.top.equalTo(ivQQ.mas_bottom).offset(5);
    }];
    
    //更多平台
    ivStyle(ivSeeMore, @"gengduopingtaitubiao");
    [view addSubview:ivSeeMore];
    [ivSeeMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ivXinLang);
        make.top.equalTo(ImpressionNotesLabel.mas_bottom).offset(30);
        make.height.width.equalTo(ivXinLang);
    }];
    labelStyle(SeeMoreLabel);
    SeeMoreLabel.text = @"更多平台";
    SeeMoreLabel.font = sizeFont(12.0);
    [view addSubview:SeeMoreLabel];
    [SeeMoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ivSeeMore);
        make.top.equalTo(ivSeeMore.mas_bottom).offset(5);
    }];

}

- (void)returnBeformPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    view.hidden = YES;
}

@end
