//
//  SearchResourcesPortView.m
//  JiangXiResource
//
//  Created by xinjie on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "SearchResourcesPortView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"
#import "CommonDefine.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SearchResourcesPortViewTableViewCell.h"

@interface SearchResourcesPortView ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic ,strong) UIView *titleBackView;            // title背景view
@property (nonatomic ,strong) UIButton *imageBtn;               // 图片
@property (nonatomic ,strong) UILabel *titleLabel;              // 名称
@property (nonatomic ,strong) UIView *btnBackView;              // 空闲端口  全部端口按钮背景
@property (nonatomic ,strong) UIButton *freePortBtn;            // 空闲端口
@property (nonatomic ,strong) UIButton *allPortBtn;             // 全部端口
@property (nonatomic ,strong) UITableView *tableView;           // 端口列表
@property (nonatomic ,strong) UIButton *selectedBtn;            // 选中端口

@end

@implementation SearchResourcesPortView

- (void)layoutSubviews {
    //1. 执行 [super layoutSubviews];
    [super layoutSubviews];
    //2. 设置preferredMaxLayoutWidth: 多行label约束的完美解决
    self.titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 50;
    //3. 设置preferredLayoutWidth后，需要再次执行 [super layoutSubviews];
    //其实在实际中这步不写，也不会出错，官方解释是说设置preferredLayoutWidth后需要重新计算并布局界面，所以这步最好执行
    [super layoutSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = black_color_245;
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self createBackgroundView]; // 创建背景View
    [self createTitleLabelAndImageBtn]; // 创建titleBackView上的title和箭头图片
    [self createButton]; // 创建空闲端口按钮 和 全都端口按钮
    [self setViewFrame]; // 设置以上控件的布局
    [self createTableView];  // 创建tableview
}

- (void)createBackgroundView{
    // backView
    self.titleBackView = [self createBackView];
    self.titleBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.titleBackView addGestureRecognizer:tap];
    self.btnBackView = [self createBackView];
}

- (void)createTitleLabelAndImageBtn{
    self.titleLabel = [self createLabeltext:@"M1人民广场机房综合机房"];
    self.titleLabel.numberOfLines = 0;
    
    self.imageBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"xiangshang"] forState:UIControlStateNormal];
        
        [self.titleBackView addSubview:btn];
        btn;
    });
}

- (void)createButton{
    self.freePortBtn = [self createBtnWithTitle:@"空闲端口" tag:FreePortBtnTag];
    [self btnAction:self.freePortBtn]; // 首次进入 让空闲端口按钮处于选中状态
    self.allPortBtn = [self createBtnWithTitle:@"全部端口" tag:AllPortBtnTag];
}

- (void)setViewFrame{
    // backView
    [self.titleBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.right.equalTo(self);
    }];
    
    [self.btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBackView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@40);
    }];
    
    
    // titleBackView 上的title 和 image
    [ self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.titleBackView).insets(UIEdgeInsetsMake(10, 10, 10, 0));
        make.right.equalTo(self.imageBtn.mas_left).offset(-10);
    }];
    
    
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    // 空闲端口 按钮
    NSArray *searchArray = @[self.freePortBtn,
                             self.allPortBtn];
    [searchArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    [searchArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnBackView);
        make.bottom.equalTo(self.btnBackView);
    }];
}

- (void)createTableView{
    // tableview
    self.tableView = ({
        UITableView *view = [[UITableView alloc] init];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnBackView.mas_bottom);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [view registerClass:[SearchResourcesPortViewTableViewCell class] forCellReuseIdentifier:@"TableViewCellID"];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        // 处理分割线
        if ([view respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [view setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([view respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [view setLayoutMargins:UIEdgeInsetsZero];
        }
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
        view.tableFooterView = footView;
        view;
    });

}

// TitleBackView 手势点击
- (void)tapClick{
    if ([self.delegate respondsToSelector:@selector(searchResourcesPortViewBtnClick:)]) {
        [self.delegate searchResourcesPortViewBtnClick:TitleBackViewTag];
    }
}

// 空闲端口 全部端口 按钮点击
- (void)btnAction:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(searchResourcesPortViewBtnClick:)]) {
        [self.delegate searchResourcesPortViewBtnClick:btn.tag];
    }
}

// 设置titleLabel的文字信息
- (void)setString:(NSString *)string{
    self.titleLabel.text = string;
}

#pragma mark tableViewDelegate
//处理cell的线到头
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.portListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"TableViewCellID" configuration:^(SearchResourcesPortViewTableViewCell *cell) {
        SearchResourcesPortViewListModel *model = self.portListArray[indexPath.row];
        cell.model = model;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"TableViewCellID";
    SearchResourcesPortViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    if (self.portListArray.count > 0) {
        SearchResourcesPortViewListModel *model = self.portListArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResourcesPortViewListModel *model = self.portListArray[indexPath.row];
    NSDictionary *dic = @{@"name": model.titleName};
    if ([self.delegate respondsToSelector:@selector(searchResourcesPortViewSelectedCell:)]) {
        [self.delegate searchResourcesPortViewSelectedCell:dic];
    }
}


-(UILabel *)createLabeltext:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = UIColorFromHex(0x0185ce);
    label.text = text;
    [self.titleBackView addSubview:label];
    return label;
}


- (UIView *)createBackView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    return view;
}

- (UIButton *)createBtnWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnBackView addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromHex(0x0185ce) forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = UIColorFromHex(0xd2d2d2).CGColor;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = tag;
        btn;
    });
    return button;
}



@end
