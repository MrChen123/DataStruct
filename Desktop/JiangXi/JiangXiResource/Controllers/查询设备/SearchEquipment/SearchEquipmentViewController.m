//
//  SearchEquipmentViewController.m
//  JiangXiResource
//
//  Created by xinjie on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "SearchEquipmentViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"
#import "CommonDefine.h"
#import "SearchEquipmentHeadView.h"
#import "SearchEquipmentFootView.h"
#import "PromptChooseView.h"
#import "BaseViewController.h"
#import "SearchEquipmentListModel.h"
#import "SearchEquipmentTableViewCell.h"

@interface SearchEquipmentViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
SearchEquipmentHeadViewDelegate,
ChatViewPromptChooseViewDelegate,
UISearchBarDelegate,
SearchEquipmentFootViewDelegate
>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) SearchEquipmentHeadView *headView; // 头视图
@property (nonatomic , strong) SearchEquipmentFootView *footView; // 尾视图
@property (nonatomic , strong) PromptChooseView *promptChooseView; // 选择框
@property (nonatomic , strong) NSMutableArray *listArray; // 列表数据数组
@property (nonatomic, strong) UISearchBar *searchBar;       // 搜索框

@end

@implementation SearchEquipmentViewController

- (NSMutableArray *)listArray
{
    if (_listArray == nil)
    {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[[UIApplication sharedApplication] delegate] window] endEditing:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = black_color_245;
    
    for (NSInteger index = 0; index<10; index++) {
        SearchEquipmentListModel *model = [[SearchEquipmentListModel alloc] init];
        model.titleName = [NSString stringWithFormat:@"南通市新区万达华府1单元16#分纤箱子南通市新区万达华府1单元16#分纤箱子%@",@(index)];
        [self.listArray addObject:model];
    }
    
    [self createSearchView]; // 创建搜索框
    [self createHeadView];   // 头视图创建
    [self createTableView];  // tableview 创建
    [self createFootView];   // 尾视图创建
}

/**
 *  创建一个搜索输入框
 */
- (void)createSearchView
{
    self.searchBar = ({
        UISearchBar *bar = [UISearchBar new];
        bar.delegate = self;
        bar.placeholder = @"请输入关键字";
        bar.searchBarStyle = UISearchBarStyleMinimal;
        
        bar;
    });
    
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"  " style:UIBarButtonItemStylePlain target:self action:nil];
}


/**
 *  创建头视图 SearchEquipmentHeadView 包含 slider 与 区县,设备的选择
 */
- (void)createHeadView{
    self.headView = [[SearchEquipmentHeadView alloc] init];
    [self.view addSubview:self.headView];
    self.headView.delegate = self;
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.view).insets(UIEdgeInsetsMake(10, 10, 0, 10));
        make.height.mas_equalTo(@135);
    }];
}

/**
 *  创建搜索结果tabeleView
 */
- (void)createTableView{
    self.tableView = ({
        UITableView *view = [[UITableView alloc] init];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor redColor];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom).offset(10);
            make.left.right.equalTo(self.headView);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        }];
        [view registerClass:[SearchEquipmentTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        view.delegate = self;
        view.dataSource = self;
        view.hidden = YES;
        view.backgroundColor = [UIColor whiteColor];
        view.separatorInset = UIEdgeInsetsZero;
        view.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
        view.tableFooterView = footView;
        view;
    });
}

/**
 *  创建尾视图 包含重置 查询
 */
- (void)createFootView{
    self.footView = ({
        SearchEquipmentFootView *view = [[SearchEquipmentFootView alloc] init];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView.mas_bottom).offset(10);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        view.delegate = self;
        view;
    });
}

#pragma mark 头视图代理 SearchEquipmentHeadViewDelegate（所属区县等）
- (void)showPromptView:(TapViewTag)tag{
    // 关闭键盘
    [[[[UIApplication sharedApplication] delegate] window] endEditing:YES];
    
    self.promptChooseView = ({
        PromptChooseView *view = [[PromptChooseView alloc] init];
        [self.navigationController.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.navigationController.view);
        }];
        view.style = PromptChooseViewStlyOrNone;
        view.delegate = self;
        view;
    });

    if (tag == CityBackViewTag) {
        self.promptChooseView.tag = 100;
        [self.promptChooseView setListArray:@[@"南通市",@"如东县",@"掘港镇",@"三桥村"]];
    } else {
        self.promptChooseView.tag = 200;
        [self.promptChooseView setListArray:@[@"BBU",@"BBQ",@"AAQ",@"WWD"]];
    }
}

#pragma mark 尾视图代理 （重置按钮）

- (void)searchEquipmentFootViewBtnClick:(SearchEquipmentFootViewBtnTag)tag{
    switch (tag) {
        case ResetButtonTag:
            self.tableView.hidden = YES;
            [self.headView setTextString:@"" TapViewTag:CityBackViewTag];
            [self.headView setSilderValue];
            break;
            
        case SearchButtonTag:
            self.tableView.hidden = NO;
            break;
            
        default:
            break;
    }
}

#pragma mark 传递滑块值 SliderTex
- (void)passSliderText:(NSString *)text{
    NSLog(@"滑块值 ------>>> %@",text);
}

#pragma mark promptChooseView 选择提示框代理
- (void)refreshView:(id)value{
    NSString *textStr = value;
    if (self.promptChooseView.tag == 100) {
        [self.headView setTextString:textStr TapViewTag:CityBackViewTag];
    } else {
        [self.headView setTextString:textStr TapViewTag:EquipmentBackViewTag];
    }
}


#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"TableViewCell" configuration:^(SearchEquipmentTableViewCell *cell) {
        SearchEquipmentListModel *model = self.listArray[indexPath.row];
        cell.model = model;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"TableViewCell";
    SearchEquipmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    if (self.listArray.count > 0) {
        SearchEquipmentListModel *model = self.listArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchEquipmentListModel *model = self.listArray[indexPath.row];
    NSDictionary *dic = @{@"name": model.titleName};
    self.searchEquipmentViewControllerCallBack(dic);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
