//
//  ShowInfoVC.m
//  ZhihuNewsDaily
//
//  Created by loufq on 16/2/28.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "ShowInfoVC.h"
#import "DetailsModel.h"
#import <Masonry/Masonry.h>

@interface ShowInfoVC ()

@property (nonatomic, strong) DetailsModel *model;

@end

@implementation ShowInfoVC

- (DetailsModel *)model {
    if (!_model) {
        _model = [DetailsModel new];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [UIView new];
    view.userInteractionEnabled = NO;
    view.hidden = YES;
    view.frame = CGRectMake(10, 38, 300, 225);
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    UIView *headerView = [UIView new];
    headerView.layer.borderWidth = 1;
    headerView.frame = CGRectMake(0, 0, 0, 44);
    [self.view addSubview:headerView];
    
    self.tableView.tableHeaderView = headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    customView.backgroundColor = [UIColor grayColor];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(customView).offset(5);
        make.centerY.equalTo(customView);
    }];
    
    UILabel *appTitleLabel = [UILabel new];
    appTitleLabel.text = @"应用名";
    appTitleLabel.font = [UIFont systemFontOfSize:18];
    [customView addSubview:appTitleLabel];
    [appTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(customView);
    }];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(customView).offset(-5);
        make.centerY.equalTo(customView);
    }];
    
    return customView;
}


- (void)cancelButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}


- (id)init {
    self = [super init];
    if (self) {
        [self initForm];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initForm];
    }
    return self;
}

- (void)initForm {
    XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    NSLog(@"title-%@",self.Title);
    
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title" rowType:XLFormRowDescriptorTypeText title:self.Title];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"textView" rowType:XLFormRowDescriptorTypeTextView];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"title" rowType:XLFormRowDescriptorTypeText title:self.Title];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"textView" rowType:XLFormRowDescriptorTypeTextView];
    [section addFormRow:row];
    
    self.form = form;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
