//
//  SearchResourcesViewController.m
//  JiangXiResource
//
//  Created by xinjie on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "SearchResourcesViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"
#import "CommonDefine.h"
#import "SearchResourcesHeadView.h"
#import "SearchEquipmentViewController.h"
#import "SearchResourcesListModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SearchResourcesTableViewCell.h"
#import "SearchResourcesPortView.h"
#import "SearchResourcesPortViewListModel.h"
#import "StandardAddressVC.h"
#import "XhNetWorking.h"

@interface SearchResourcesViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
SearchResourcesHeadViewDelegate,
SearchResourcesPortViewDelegate
>
@property (nonatomic , strong) SearchResourcesHeadView *headView; // 头视图
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) SearchResourcesPortView *portView; // 端口view。呈现端口列表
@property (nonatomic , strong) NSMutableArray *resourcesListArray; // 资源数组
@property (nonatomic , strong) NSMutableArray *portListArray; // 端口数组
@end

@implementation SearchResourcesViewController


- (NSMutableArray *)portListArray
{
    if (_portListArray == nil)
    {
        _portListArray = [[NSMutableArray alloc] init];
    }
    return _portListArray;
}

- (NSMutableArray *)resourcesListArray
{
    if (_resourcesListArray == nil)
    {
        _resourcesListArray = [[NSMutableArray alloc] init];
    }
    return _resourcesListArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = black_color_245;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    self.title = @"查询可用资源";
    
    for (NSInteger index = 0; index<10; index++) {
        SearchResourcesListModel *model = [[SearchResourcesListModel alloc] init];
        model.titleName = [NSString stringWithFormat:@"南通市新区万达华府1单元16#分纤箱子南通市新区万达华府1单元16#分纤箱子%@",@(index)];
        [self.resourcesListArray addObject:model];
    }
    
    for (NSInteger index = 20; index<30; index++) {
        SearchResourcesPortViewListModel *model = [[SearchResourcesPortViewListModel alloc] init];
        model.titleName = [NSString stringWithFormat:@"上海新区万达华府1单元16#分纤箱子端口%@",@(index)];
        [self.portListArray addObject:model];
    }

    
    [self createHeadView];  // 头视图创建
    [self createTableView];
}

/**
 *  头视图创建 包含 （扫码 设备查询 地址查询 原设备查询 原地址查询）
 */
- (void)createHeadView{
    self.headView = ({
        SearchResourcesHeadView *view = [[SearchResourcesHeadView alloc] init];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.mas_equalTo(self.view).insets(UIEdgeInsetsMake(10, 10, 0, 10));
            make.height.mas_equalTo(@80);
        }];
        view.delegate = self;
        view;
    });
}


/**
 *  创建搜索结果tabeleView
 */
- (void)createTableView{
    self.tableView = ({
        UITableView *view = [[UITableView alloc] init];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom).offset(10);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        [view registerClass:[SearchResourcesTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = [UIColor whiteColor];
        view.separatorInset = UIEdgeInsetsZero;
        view.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
        view.tableFooterView = footView;
        view;
    });
}

#pragma mark SearchResourcesHeadViewDelegate
- (void)searchResourcesHeadViewBtnClick:(SearchResourcesHeadViewBtnTag)btnTag{
    switch (btnTag) {
        case QRCodeBtnTag:{
            
        }
            break;
        case EquipmentBtnTag:{
            SearchEquipmentViewController *viewController = [[SearchEquipmentViewController alloc] init];
            WeakSelf;
            [viewController setSearchEquipmentViewControllerCallBack:^(NSDictionary *dataDic) {
                // 清空数组 设置分段选择器选择状态 刷新tableview
                [weakSelf.resourcesListArray removeAllObjects];
                [weakSelf.headView setSegmentedControlSelectedSegmentIndex];
                SearchResourcesListModel *model = [[SearchResourcesListModel alloc] init];
                model.titleName = [dataDic valueForKey:@"name"];
                [weakSelf.resourcesListArray addObject:model];
                [weakSelf.tableView reloadData];
                [weakSelf hiddenPortView];
            }];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case AddressBtnTag:{
            StandardAddressVC *standardAddressVC = [[StandardAddressVC alloc] init];
            standardAddressVC.region = @"南昌县";
            standardAddressVC.type = addressTypeSearch;
            WeakSelf;
            [standardAddressVC setAddressCallBack:^(NSMutableDictionary *dict) {
                [weakSelf.resourcesListArray removeAllObjects];
                [weakSelf.headView setSegmentedControlSelectedSegmentIndex];
                SearchResourcesListModel *model = [[SearchResourcesListModel alloc] init];
                model.titleName = [dict valueForKey:@"name"];
                [weakSelf.resourcesListArray addObject:model];
                [weakSelf.tableView reloadData];
                [weakSelf hiddenPortView];
            }];
            [self.navigationController pushViewController:standardAddressVC animated:YES];
        }
            break;
        case OldEquipmentCodeBtnTag:
            [self hiddenPortView];
            break;
        case OldAddressBtnTag:
            [self hiddenPortView];
            break;
        default:
            break;
    }
}

#pragma mark SearchResourcesPortViewDelegate（包含 空闲端口 全部端口）
- (void)searchResourcesPortViewBtnClick:(SearchResourcesPortViewBtnTag)btnTag{
    switch (btnTag) {
        case FreePortBtnTag:{
            NSLog(@"________------------>>>>>>>>空闲端口");
            
            XhNetWorking *request = [XhNetWorking downloadRequestUrl:@"http://www.120ask.com/static/upload/clinic/article/org/201311/201311061651418413.jpg" tag:0];
            [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
                UIImage *image = [UIImage imageWithData:request.responseData];
                NSLog(@"21313");
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                
                NSString *errorInfo = [request.error localizedDescription];
                NSLog(@"error---> %@", errorInfo);
                [CommonLogic showPromptInfo:@"请求失败，请稍后重试!"];
            }];

        }
            break;
        case AllPortBtnTag:{
            NSLog(@"全部端口");
        }
            break;
        case TitleBackViewTag:
            [self hiddenPortView];
            break;
        default:
            break;
    }
}



// 端口选择完成 返回上一层界面 讲端口名等参数带到上级页面
- (void)searchResourcesPortViewSelectedCell:(NSDictionary *)dataDic{
    [self.navigationController popViewControllerAnimated:YES];
    self.searchResourcesViewCallBack(dataDic);
}

#pragma mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resourcesListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"TableViewCell" configuration:^(SearchResourcesTableViewCell *cell) {
        SearchResourcesListModel *model = self.resourcesListArray[indexPath.row];
        cell.model = model;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"TableViewCell";
    SearchResourcesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    SearchResourcesListModel *model = self.resourcesListArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.hidden = YES; // 隐藏tableview
    [self createPortView:indexPath.row];
}

/**
 *  创建PortView （端口列表）
 *
 *  @param row  indexPath.row
 */
- (void)createPortView:(NSInteger)row{
    SearchResourcesListModel *model = self.resourcesListArray[row];
    self.portView = ({
        SearchResourcesPortView *view = [[SearchResourcesPortView alloc] init];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_bottom).offset(10);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        view.string = model.titleName;
        view.portListArray = [[NSMutableArray alloc] initWithArray:self.portListArray];
        view.delegate = self;
        
        view;
    });
}

- (void)hiddenPortView{
    if (!self.portView.hidden && self.portView) {
        self.portView.hidden = YES; // 隐藏portView
        self.tableView.hidden = NO; // 显示tableview
    }
}

@end
