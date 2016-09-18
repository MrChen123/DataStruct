
//
//  ResourceHistoryVC.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "ResourceHistoryVC.h"
#import "MoreView.h"
#import "CustomSegView.h"
#import "ResourceHistoryModel.h"
#import "ResourceHistoryCell.h"
#import "HistorySearchModel.h"

// 边距
#define kPadding 5
// 边框颜色
#define kBorderColor [UIColor colorWithRed:0.00f green:0.51f blue:0.82f alpha:1.00f]
// 按钮颜色
#define kBtnSelectedColor UIColorFromHex(0x0185ce)
// cellId
#define kCellId     @"resourceHistoryCellId"

@interface ResourceHistoryVC ()
<
UITextFieldDelegate,
CustomSegViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>
// UI部分
@property (nonatomic, strong) UITextField *searchTf;                // 宽带账号
@property (nonatomic, strong) UIView *topView;                      // 搜索框和搜索按钮(头视图)
@property (nonatomic, strong) CustomSegView *segView;               // 按钮视图(尾视图)
@property (nonatomic, strong) UITableView *tableView;               // tableView
@property (nonatomic, strong) UIView *clearView;                    // 键盘处理View
// 数据部分
@property (nonatomic, strong) NSMutableArray *dataArray;            // 数据部分（今天，最近三天，最近一周）
@property (nonatomic, strong) HistorySearchModel *searchModel;      // 搜索信息
@end

@implementation ResourceHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"历史记录";
    
    [self uiConfig];
    
    // 默认刚进来的时候显示今天的记录
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----------辅助方法-----------
// 返回
- (void)backAction:(UIButton *)btn
{
    NSLog(@"%s", __func__);
}

// 根据宽带账号搜索
- (void)searchAction:(UIButton *)btn
{
    [self tapAction];
    // 发起请求
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadData];
}

// 用于回收键盘
- (void)tapAction
{
    self.clearView.hidden = YES;
    [self.searchTf resignFirstResponder];
}

// 发起请求
- (void)loadData
{
    NSString *params = [self.searchModel toJSONString];
    NSLog(@"请求参数:%@", params);
    
    NSMutableDictionary *dicts = [[NSMutableDictionary alloc] init];
    [dicts setObject:params forKey:@"params"];
    
    XhNetWorking *request = [XhNetWorking requestUrl:Login params:dicts tag:0];
    
    WeakSelf;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        // 隐藏菊花
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        // 关闭tableView效果
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        NSDictionary *dataDic = request.responseJSONObject;
        int state = [dataDic[@"status"] intValue];
        // 请求成功
        if (state == 1) {
            NSDictionary *jsonDict = dataDic[@"json"];
            
            // 如果pageNo=1，说明是重新加载，删除旧记录
            NSInteger pageNum = weakSelf.searchModel.currentPage;
            if (pageNum == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            
            if (pageNum == 1 &&
                ([jsonDict[@"row"] isKindOfClass:[NSNull class]] || [jsonDict[@"row"] count] == 0)) {
                [CommonLogic showPromptInfo:@"查询结果为空"];
                [weakSelf.tableView reloadData];
                weakSelf.searchModel.currentPage = 1;
                return;
            } else if ([jsonDict[@"row"] isKindOfClass:[NSNull class]] || [jsonDict[@"row"] count] == 0) {
                // 没有请求到新数据
                weakSelf.searchModel.currentPage--;
                [CommonLogic showPromptInfo:@"没有更多记录了"];
                return;
            }
            
            for (NSDictionary *itemDict in jsonDict[@"row"]) {
                [weakSelf.dataArray addObject:[[ResourceHistoryModel alloc] initWithDictionary:itemDict error:nil]];
            }
            [weakSelf.tableView reloadData];
            
        } else {
            // 错误
            [CommonLogic showPromptInfo:dataDic[@"failReason"]];
            
            // 造假数据
            for (int i = 0; i < 2; i++) {
                ResourceHistoryModel *model = [[ResourceHistoryModel alloc] init];
                model.account = @"13912345671";
                model.time = @"2016年8月25日11:35";
                model.address = @"JKGD-20160823-001,南昌市新区万达华府1单元301室";
                model.activeStatus = @"激活成功!";
                [weakSelf.dataArray addObject:model];
            }
            
            [weakSelf.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        // 隐藏菊花
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        // 关闭tableView效果
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        NSString *errorInfo = [request.error localizedDescription];
        NSLog(@"%@", errorInfo);
        [CommonLogic showPromptInfo:@"请求失败，请稍后重试!"];
    }];
    
}

#pragma mark -----------代理-----------
#pragma mark UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tapAction];
    // 发起请求
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadData];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // 添加一个透明View,用于处理键盘
    self.clearView.hidden = NO;
    return YES;
}

#pragma mark CustomSegView Delegate
- (void)clickSegItem:(NSInteger)index
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.searchModel.requestDay = index;
    [self loadData];
}

#pragma mark UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResourceHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __func__);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kCellId cacheByIndexPath:indexPath configuration:^(ResourceHistoryCell *cell) {
        cell.model = self.dataArray[indexPath.row];
    }];
    return height;
}

#pragma mark -----------数据部分-----------
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (HistorySearchModel *)searchModel
{
    if (_searchModel == nil) {
        _searchModel = [[HistorySearchModel alloc] init];
        _searchModel.currentPage = 1;
        _searchModel.requestDay = requestToday;
    }
    return _searchModel;
}

#pragma mark -----------UI-----------
- (void)uiConfig
{
    // 上层放搜索框
    [self configTop];
    
    // 放入分段选择器
    [self configMiddle];
    
    // 1个scrollView接两个tableView
    [self configBottom];
    
}

- (void)configTop
{
    self.topView = ({
        UIView *view = [UIView new];
        view.layer.borderColor = kBorderColor.CGColor;
        view.layer.borderWidth = 1;
        
        
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(kPadding, kPadding, 0, kPadding));
            make.height.mas_equalTo(44);
        }];
        
        view;
    });
    
    self.searchTf = ({
        UITextField *tf = [UITextField new];
        tf.placeholder = @"请输入宽带账号";
        tf.layer.borderColor = kBorderColor.CGColor;
        tf.layer.borderWidth = 1;
        tf.borderStyle = UITextBorderStyleNone;
        //默认键盘
        tf.keyboardType = UIKeyboardTypeDefault;
        //设置键盘右下角的键的显示风格
        tf.returnKeyType = UIReturnKeyDone;
        tf.clearButtonMode = UITextFieldViewModeAlways;
        tf.delegate = self;
        [self.topView addSubview:tf];
        
        tf;
    });
    
    UIButton *searchBtn = ({
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:btn];
        
        btn;
    });
    
    [self.searchTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.topView).insets(UIEdgeInsetsZero);
        make.right.equalTo(searchBtn.mas_left);
    }];
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self.topView).insets(UIEdgeInsetsZero);
        make.width.mas_equalTo(40);
    }];

}

- (void)configMiddle
{
    self.segView = ({
        CustomSegView *seg = [CustomSegView new];
        [self.view addSubview:seg];
        
        [seg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView.mas_bottom).offset(kPadding);
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, kPadding, kPadding, kPadding));
            make.height.mas_equalTo(40);
        }];
        
        seg.isDifferent = YES;
        seg.notHasSelect = YES;
        seg.titleArray = @[@"最近三天",
                           @"最近一周"];
        seg.delegate = self;
        
        seg;
    });
}

- (void)configBottom
{
    self.tableView = ({
        UITableView *tableView = [UITableView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[ResourceHistoryCell class] forCellReuseIdentifier:kCellId];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.estimatedRowHeight = 60;
        
        // 给tableView添加刷新视图
        WeakSelf;
        // 下拉刷新
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.searchModel.currentPage = 1;
            [weakSelf loadData];
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        
        // 上拉加载下一页
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.searchModel.currentPage++;
            [weakSelf loadData];
        }];
        
        [self.view addSubview:tableView];
        
        // 布局
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, kPadding, kPadding, kPadding));
            make.top.equalTo(self.segView.mas_bottom).offset(kPadding);
        }];
        
        tableView;
    });
}

- (UIView *)clearView
{
    if (_clearView == nil) {
        _clearView = [[UIView alloc] init];
        _clearView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [_clearView addGestureRecognizer:tap];
        [self.view addSubview:_clearView];
        
        [_clearView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self.view).insets(UIEdgeInsetsZero);
            make.top.equalTo(self.topView.mas_bottom);
        }];
    }
    return _clearView;
}

@end
