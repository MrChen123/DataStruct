//
//  StandardAddressVC.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "StandardAddressVC.h"
#import "OtherUtils.h"
#import "PromptChooseView.h"
#import "HistoryView.h"

// 边距
#define kPadding 5
#define kCellId    @"standardCellId"

@interface StandardAddressVC ()
<
UISearchBarDelegate,
UITableViewDelegate,
UITableViewDataSource,
ChatViewPromptChooseViewDelegate
>
// UI部分
@property (nonatomic, strong) UIView *topView;              // 上层View
@property (nonatomic, strong) UISearchBar *searchBar;       // 搜索框
@property (nonatomic, strong) UILabel *regionLabel;         // 所属区县
@property (nonatomic, strong) UITableView *tableView;       // tableView
@property (nonatomic, strong) HistoryView *history;         // 历史记录View
@property (nonatomic, strong) UIView *clearView;            // 键盘处理View
// 数据部分
@property (nonatomic, strong) NSMutableArray *addressArray; // 地址数据
@property (nonatomic, strong) NSMutableArray *historyArray; // 历史记录数据
@property (nonatomic, strong) NSMutableArray *equipArray;   // 设备数据
@property (nonatomic, assign) BOOL isFirst;                 // 第一次进入使用
@property (nonatomic, assign) BOOL isAddress;               // 当前tableView显示数据是否是地址tableView
@end

@implementation StandardAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self uiConfig];
    
    [self dataConfig];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----------辅助方法-----------
// 用于回收键盘
- (void)tapAction
{
    self.clearView.hidden = YES;
    [self.searchBar resignFirstResponder];
}
// 验证信息
- (BOOL)checkValidate
{
    if (self.searchBar.text &&
        self.regionLabel.text) {
        return YES;
    } else {
        [CommonLogic showPromptInfo:@"请填写完所有信息"];
        return NO;
    }
    return YES;
}
// 显示历史记录信息
- (void)showHistory
{
    self.topView.hidden = YES;
    self.history.historyArray = self.historyArray;
    self.history.hidden = NO;
}

// 隐藏历史记录
- (void)hideHistory
{
    self.topView.hidden = NO;
    self.history.hidden = YES;
}

- (void)dataConfig
{
    // 首次进入时，请求的是地址信息
    self.isFirst = YES;
    self.isAddress = YES;
    self.regionLabel.text = self.region;
    
    if (self.portNewValue) {
        [self loadHistoryData:NO addID:@"-1"];
    }
}

// 更换所属区域信息
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 发起请求，查询区域信息
//    [self loadRequest];
    [self.searchBar resignFirstResponder];
    
    PromptChooseView *view = [[PromptChooseView alloc] init];
    [self.navigationController.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationController.view);
    }];
    view.style = PromptChooseViewStlyOrNone;
    view.delegate = self;
    [view setListArray:@[@"南通市",@"如东县",@"掘tou港镇",@"三桥村"]];
}

/**
 *  请求类
 *
 *  @param isHistroy   是否查询历史记录
 *  @param addressID   是否根据标准地址查询设备
 */
- (void)loadHistoryData:(BOOL)isHistroy addID:(NSString *)addressID
{
    [self.searchBar resignFirstResponder];
    // 请求参数
    NSString *params;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (isHistroy) {
        [dict setObject:@"111" forKey:@"history"];
        params = [self convertToJsonString:dict];
    } else {
        if (self.type == addressTypeChange) {
            if (self.portNewValue) {
                // 如果有新端口信息,则根据新端口ID查询标准地址
                [dict setObject:self.portNewValue forKey:@"portID"];
                params = [self convertToJsonString:dict];
            } else {
                // 根据关键字查询标准地址
                if(![self checkValidate]) {
                    return;
                }
                [dict setObject:self.searchBar.text forKey:@"keyWord"];
                [dict setObject:self.regionLabel.text forKey:@"region"];
                params = [self convertToJsonString:dict];
            }
        } else if (self.type == addressTypeSearch) {
            if ([addressID integerValue] != -1) {
                // 根据标准地址查询设备
                [dict setObject:addressID forKey:@"addressID"];
                params = [self convertToJsonString:dict];
            } else {
                // 根据关键字查询标准地址
                if(![self checkValidate]) {
                    return;
                }
                [dict setObject:self.searchBar.text forKey:@"keyWord"];
                [dict setObject:self.regionLabel.text forKey:@"region"];
                params = [self convertToJsonString:dict];
            }
        }
    }

    // 开启菊花
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"请求参数:%@", params);
    
    NSMutableDictionary *dicts = [[NSMutableDictionary alloc] init];
    [dicts setObject:params forKey:@"params"];
    
    XhNetWorking *request = [XhNetWorking requestUrl:Login params:dicts tag:0];
    
    WeakSelf;
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        // 隐藏菊花
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        NSDictionary *dataDic = request.responseJSONObject;
        int state = [dataDic[@"status"] intValue];
        // 请求成功
        if (state == 1) {
            NSDictionary *jsonDict = dataDic[@"json"];
            
            if (([jsonDict[@"row"] isKindOfClass:[NSNull class]] || [jsonDict[@"row"] count] == 0)) {
                [CommonLogic showPromptInfo:@"查询结果为空"];
                return;
            }
            
            // TODO:数据解析
            
        } else {
            // 错误
            [CommonLogic showPromptInfo:dataDic[@"failReason"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        // 隐藏菊花
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        NSString *errorInfo = [request.error localizedDescription];
        NSLog(@"%@", errorInfo);
        [CommonLogic showPromptInfo:@"请求失败，请稍后重试!"];
    }];
    
    // 测试数据用
    if (isHistroy) {
        for (int i = 0; i < 20; i++) {
            [self.historyArray addObject:[NSString stringWithFormat:@"JKGD-20160823-001,南昌市新区万达华府1单元3%d室",i]];
        }
        [self showHistory];
    } else {
        [self hideHistory];
        if (self.type == addressTypeChange) {
            for (int i = 0; i < 20; i++) {
                [self.addressArray addObject:[NSString stringWithFormat:@"南昌市新区万达华府1单2340元3%d室",i]];
            }
        } else if (self.type == addressTypeSearch) {
            if ([addressID integerValue] != -1) {
                // 根据标准地址查询设备
                for (int i = 0; i < 20; i++) {
                    [self.equipArray addObject:[NSString stringWithFormat:@"南昌市新区万达设备%d",i]];
                }
            } else {
                // 根据关键字查询标准地址
                for (int i = 0; i < 20; i++) {
                    [self.addressArray addObject:[NSString stringWithFormat:@"南昌市新区万达华府1单元3%d室",i]];
                }
            }
        }
        [self.tableView reloadData];
    }
}

#pragma mark -----------代理-----------
#pragma mark UISearchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (self.isFirst) {
        self.isFirst = NO;
        [self loadHistoryData:YES addID:@"-1"];
        return NO;
    }
    return YES;
}

//点击键盘上的search按钮时调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self loadHistoryData:NO addID:@"-1"];
}

//输入文本实时更新时调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@", searchText);
    if (searchBar.text.length == 0) {
        [self showHistory];
    } else {
        [self loadHistoryData:NO addID:@"-1"];
    }
}

#pragma mark ChatViewPromptChooseViewDelegate
- (void)refreshView:(NSString *)value
{
    self.regionLabel.text = value;
}

#pragma mark UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (self.isAddress) {
        cell.textLabel.text = self.addressArray[indexPath.row];
    } else {
        cell.textLabel.text = self.equipArray[indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isAddress) {
        return self.addressArray.count;
    } else {
        return self.equipArray.count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == addressTypeChange) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self.addressArray[indexPath.row] forKey:@"name"];
        _addressCallBack(dict);
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.type == addressTypeSearch) {
        if (self.isAddress) {
            // 请求设备数据
            [self loadHistoryData:NO addID:self.addressArray[indexPath.row]];
            self.isAddress = NO;
        } else {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:self.equipArray[indexPath.row] forKey:@"name"];
            _addressCallBack(dict);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:kCellId cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
        if (self.isAddress) {
            cell.textLabel.text = self.addressArray[indexPath.row];
        } else {
            cell.textLabel.text = self.equipArray[indexPath.row];
        }
    }];
    return height;
}

#pragma mark -----------数据-----------
- (NSMutableArray *)addressArray
{
    if (_addressArray == nil) {
        _addressArray = [[NSMutableArray alloc] init];
    }
    return _addressArray;
}

- (NSMutableArray *)historyArray
{
    if (_historyArray == nil) {
        _historyArray = [[NSMutableArray alloc] init];
    }
    return _historyArray;
}

- (NSMutableArray *)equipArray
{
    if (_equipArray == nil) {
        _equipArray = [[NSMutableArray alloc] init];
    }
    return _equipArray;
}

#pragma mark -----------UI-----------
- (void)uiConfig
{
    // 添加搜索框
    [self searchView];
    
    // 添加选择框
    [self addChooseView];
    
    // 添加tableView
    [self addTableView];
}

- (void)searchView
{
    self.searchBar = ({
        UISearchBar *bar = [UISearchBar new];
        bar.delegate = self;
        bar.placeholder = @"请输入关键字";
        bar.searchBarStyle = UISearchBarStyleMinimal;
    
        bar;
    });
    
    self.navigationItem.titleView = self.searchBar;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"      " style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)addChooseView
{
    UILabel *label;
    self.topView = [OtherUtils createViewWithView:self.view tag:0 title:@"所属区县:" hasBtn:YES hasLine:NO showInTop:NO targetLabel:&label];
    self.topView.layer.borderColor = UIColorFromHex(0x0185ce).CGColor;
    self.topView.layer.borderWidth = 1;
    self.regionLabel = label;
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.topView addGestureRecognizer:tap];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).insets(UIEdgeInsetsMake(kPadding, kPadding, 0, kPadding));
        make.height.mas_greaterThanOrEqualTo(40);
    }];
}

- (void)addTableView
{
    self.tableView = ({
        UITableView *table = [UITableView new];
        table.delegate = self;
        table.dataSource = self;
        table.layer.borderColor = [UIColor lightGrayColor].CGColor;
        table.layer.borderWidth = 1;
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
        table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.view addSubview:table];
        
        // 布局
        [table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, kPadding, kPadding, kPadding));
            make.top.equalTo(self.topView.mas_bottom).offset(kPadding);
        }];
        
        table;
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
            make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
        }];
    }
    return _clearView;
}

- (HistoryView *)history
{
    if (_history == nil) {
        _history = ({
            HistoryView *view = [HistoryView new];
            WeakSelf;
            [view setSelect:^(NSInteger index) {
                weakSelf.topView.hidden = NO;
                weakSelf.history.hidden = YES;
                if (index == -1) {
                    // 没有点击cell
                    [weakSelf.searchBar resignFirstResponder];
                } else {
                    if (weakSelf.type == addressTypeChange) {
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:weakSelf.historyArray[index] forKey:@"name"];
                        weakSelf.addressCallBack(dict);
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    } else if (weakSelf.type == addressTypeSearch) {
                        // 拿到地址历史记录
                        NSString *addressID = weakSelf.historyArray[index];
                        NSLog(@"%@", addressID);
                        self.isAddress = NO;
                        [weakSelf loadHistoryData:NO addID:addressID];
                    }
                }
            }];
            [self.view addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
            }];
            
            view;
        });
    }
    return _history;
}

@end
