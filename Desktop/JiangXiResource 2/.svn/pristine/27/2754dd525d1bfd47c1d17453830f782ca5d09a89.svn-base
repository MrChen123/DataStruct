//
//  HistoryView.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/7.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "HistoryView.h"
#import "Masonry.h"
#import "UIColor+Ext.h"

@interface HistoryView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UIView *topView;          // topView
@property (nonatomic, strong) UITableView *tableView;   // 历史记录tableView
@end

@implementation HistoryView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self uiConfig];
    }
    return self;
}

- (void)btnAction:(UIButton *)btn
{
    // 点击按钮，历史记录页面消失
    _select(-1);
}

- (void)setHistoryArray:(NSMutableArray *)historyArray
{
    _historyArray = historyArray;
    [self.tableView reloadData];
}

- (void)uiConfig
{
    self.topView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(50);
        }];
        
        UILabel *lab = ({
            UILabel *label = [UILabel new];
            label.numberOfLines = 0;
            label.font = [UIFont systemFontOfSize:20];
            label.textColor = UIColorFromHex(0x056FC2);
            label.text = @"   历史记录";
            
            [view addSubview:label];
            label;
        });
        
        UIButton *button = ({
            UIButton *btn = [UIButton new];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
            [view addSubview:btn];
            
            btn;
        });
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(view).insets(UIEdgeInsetsZero);
            make.right.equalTo(button.mas_left);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(view).insets(UIEdgeInsetsZero);
            make.width.mas_equalTo(50);
        }];
        
        view;
    });
    
    self.tableView = ({
        UITableView *table = [UITableView new];
        table.delegate = self;
        table.dataSource = self;
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:table];
        
        [table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self).insets(UIEdgeInsetsZero);
            make.top.equalTo(self.topView.mas_bottom);
        }];
        
        table;
        
    });
}

#pragma mark -----------UITableView Delegate-----------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = self.historyArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _select(indexPath.row);
}
@end
