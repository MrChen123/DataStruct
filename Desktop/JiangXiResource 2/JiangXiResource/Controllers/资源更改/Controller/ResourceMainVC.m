//
//  ResourceMainVC.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "ResourceMainVC.h"
#import "ResourceModel.h"
#import "MoreView.h"
#import "UIColor+Ext.h"
#import "CustomSegView.h"
#import "DetailView.h"
#import "ResourceHistoryVC.h"
#import "StandardAddressVC.h"
#import "SearchResourcesViewController.h"
#import "ResourceSearchModel.h"

typedef NS_ENUM(NSInteger, RequestFor) {
    RequestForDetail,           // 根据账号查询详情
    RequestForUpdate,           // 更改详情信息
};

// 边距
#define kPadding 5
// 边框颜色
#define kBorderColor [UIColor colorWithRed:0.00f green:0.51f blue:0.82f alpha:1.00f]
// 按钮颜色
#define kBtnSelectedColor UIColorFromHex(0x0185ce)

@interface ResourceMainVC ()
<
MoreViewDelegate,
UITextFieldDelegate,
CustomSegViewDelegate,
DetailDelegate,
UIActionSheetDelegate
>
// UI部分
@property (nonatomic, strong) UITextField *searchTf;                // 宽带账号
@property (nonatomic, strong) MoreView *moreView;                   // 更多View
@property (nonatomic, strong) UIView *topView;                      // 搜索框和搜索按钮(头视图)
@property (nonatomic, strong) CustomSegView *segView;               // 按钮视图(尾视图)
@property (nonatomic, strong) DetailView *detailView;               // 详细信息View
@property (nonatomic, strong) UIView *clearView;                    // 用于回收键盘
// 数据部分
@property (nonatomic, strong) ResourceSearchModel *searchModel;     // 输入部分
@property (nonatomic, strong) ResourceModel *model;                 // 输出部分 
@property (nonatomic, strong) NSArray *actTitles;                   // 用于actionSheet显示的信息

@end

@implementation ResourceMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"资源更改";
    
    [self dataConfig];
    
    [self uiConfig];
    
    // 自动将装维工单关联宽带账号自动写入到我方客户端的查询条件框内
    self.searchTf.text = self.searchModel.accountName;
    
//    self.detailView.model = self.model;
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
    NSString *urlStr = @"CallTest://";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
        NSString *str = [NSString stringWithFormat:@"%@name=%@&age=%@&phone=%@", urlStr, @"chen", @"25", @"13062663606"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}
// 显示历史记录
- (void)showMore:(UIButton *)btn
{
    self.moreView.isShow = !self.moreView.isShow;
}

// 根据宽带账号搜索
- (void)searchAction:(UIButton *)btn
{
    [self tapAction];
    
    // 发起请求
    [self loadDataWithType:RequestForDetail];
}

// 用于回收键盘
- (void)tapAction
{
    self.clearView.hidden = YES;
    self.searchModel.accountName = self.searchTf.text;
    [self.searchTf resignFirstResponder];
}

/**
 *  1.RequestForDetail
 *      判断宽带账号是否为空
 *  2.RequestForUpdate
 *      新地址为空、新端口为空，用户点击提交按钮时，给出提示“无任何更改，无效提交”，后台不产生更改记录。
 *      新地址为空、新端口有值：用户点击提交按钮时，后台生成新端口的变更记录。需要判断新端口和原地址是否存在覆盖关系，如果不存在则提示“XX设备和XX地址没有覆盖关系，不允许提交”。
 *      新地址有值、新端口为空：用户点击提交按钮时，后台生成新地址的变更记录。需要判断新地址和原端口是否存在覆盖关系，如果不存在则提示“XX设备和XX地址没有覆盖关系，不允许提交。
 *      新地址有值、新端口有值：用户点击提交按钮时，后台生成新地址的变更记录。需要判断新地址和新端口是否存在覆盖关系，如果不存在则提示“XX设备和XX地址没有覆盖关系，不允许提交。
 *      如果用户只修改了地址，且提交成功，给出提示“用户地址更新成功！”
 *      如果用户只修改了端口，且提交成功，给出提示“端口更新成功！”
 *      如果用户同时修改了地址和端口，且提交成功，给出提示“用户地址和端口更新成功！”
 */
- (BOOL)checkValidate:(RequestFor)requestType
{
    if (requestType == RequestForDetail) {
        if (self.searchModel.accountName == nil ||
            self.searchModel.accountName.length == 0) {
            [CommonLogic showPromptInfo:@"请输入宽带账号"];
            return NO;
        }
    } else if (requestType == RequestForUpdate) {
        // TODO: 这些是后台做的吗？？？
    }
    return YES;
}

/**
 *  网络请求
 *
 *  @param requestType  查询详情or更改详情
 */
- (void)loadDataWithType:(RequestFor)requestType
{
    // 验证规则
    if (![self checkValidate:requestType]) {
        return;
    }

    // 开启菊花
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // 请求参数
    NSString *params;
    if (requestType == RequestForDetail) {
        params = [self.searchModel toJSONString];
    } else {
        params = [self.model toJSONString];
    }
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
            
            for (NSDictionary *itemDict in jsonDict[@"row"]) {
                weakSelf.model = [[ResourceModel alloc] initWithDictionary:itemDict error:nil];
            }
            
            // 显示数据
            weakSelf.detailView.model = weakSelf.model;
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
    
}


#pragma mark -----------代理-----------
#pragma mark MoreViewDelegate
- (void)clickItem:(NSInteger)index
{
    ResourceHistoryVC *history = [[ResourceHistoryVC alloc] init];
    [self.navigationController pushViewController:history animated:YES];
}

#pragma mark UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 发起请求
    [self searchAction:nil];
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
    if (index == 0) {
        self.model.addressName = @"的垃圾分类卡时间的离开房间爱离开市领导及法律";
    } else {
        self.model.portName = @"的垃圾分类卡时间的离开房间爱离开市领导及法律";
    }
    
    self.detailView.model = self.model;
}

#pragma mark Detail Delegate
- (void)detailInfo:(clickType)type
{
    WeakSelf;
    if (type == clickTypeNewAddress) {
        NSLog(@"新地址");
        StandardAddressVC *vc = [[StandardAddressVC alloc] init];
        vc.portNewValue = self.model.portName;
        vc.type = addressTypeChange;
        vc.region = self.searchModel.region;
        [vc setAddressCallBack:^(NSMutableDictionary *dataDic) {
            weakSelf.model.addressName = dataDic[@"name"];
            weakSelf.detailView.model = weakSelf.model;
        }];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (type == clickTypeNewPort) {
        NSLog(@"新端口");
        SearchResourcesViewController *vc = [[SearchResourcesViewController alloc] init];
        [vc setSearchResourcesViewCallBack:^(NSDictionary *dataDic) {
            weakSelf.model.portName = dataDic[@"name"];
            weakSelf.detailView.model = weakSelf.model;
        }];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (type == clickTypeNewReason) {
        NSLog(@"更改原因");
        UIActionSheet *act = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"装机地址错误", @"接入方式错误", @"端口损坏", nil];
        [act showInView:self.view];
    }
}

#pragma mark UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != self.actTitles.count) {
        self.model.changeReason = self.actTitles[buttonIndex];
        self.detailView.model = self.model;
    }
}

#pragma mark -----------数据初始化-----------
- (void)dataConfig
{
    self.model = [[ResourceModel alloc] init];
    self.model.accountName = @"13912345678";
    self.model.userName = @"张三";
    self.model.way = @"FITH";
    self.model.workOrderNum = @"JKGD-20160823-001,南昌市新区万达华府1单元301室";
    self.model.orderNum = @"JKGD-20160823-001,JKGD-20160823-001,JKGD-20160823-001,JKGD-20160823-001,JKGD-20160823-001,";
    self.model.orderStatus = @"归档";
    self.model.activeStatus = @"激活成功!";
    self.model.originAddressName = @"南昌市新区万达华府1单元301室";
    self.model.originPortName = @"南昌市新区万达华府1单元12#分纤箱-1-1-1";
    self.model.changeReason = @"端子损坏";
}

- (ResourceSearchModel *)searchModel
{
    if (_searchModel == nil) {
        _searchModel = [[ResourceSearchModel alloc] initWithDictionary:self.paramsDict error:nil];
    }
    return _searchModel;
}

- (NSArray *)actTitles
{
    if (_actTitles == nil) {
        _actTitles = @[@"装机地址错误", @"接入方式错误", @"端口损坏"];
    }
    return _actTitles;
}

#pragma mark -----------UI-----------
- (void)uiConfig
{
    // 右侧导航栏添加更多按钮
    [self navigateConfig];
    
    /* 
     * 分上中下三部分，
     * 上半部分搜索框，中间TableView，下半部分两个按钮
     */
    [self configTop];
    
    [self configBottom];
    
    [self configMiddle];
    
}

- (void)navigateConfig
{
    // 左侧返回
    UIButton *backBtn = ({
        UIButton *btn = [UIButton new];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    // 右侧更多
    UIButton *button = ({
        UIButton *btn = [UIButton new];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setImage:[UIImage imageNamed:@"track_icon_more"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
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
    self.detailView = ({
        DetailView *view = [DetailView new];
        view.delegate = self;
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 1;
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView.mas_bottom).offset(kPadding);
            make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, kPadding, 0, kPadding));
            make.bottom.equalTo(self.segView.mas_top).offset(-kPadding);
        }];
        
        view;
    });
}

- (void)configBottom
{
    self.segView = ({
        CustomSegView *seg = [CustomSegView new];
        [self.view addSubview:seg];
        
        [seg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, kPadding, kPadding, kPadding));
            make.height.mas_equalTo(40);
        }];
        
        seg.isDifferent = NO;
        seg.titleArray = @[@"提交",
                           @"刷新"];
        seg.delegate = self;
        
        seg;
    });
}

- (MoreView *)moreView
{
    if (_moreView == nil) {
        _moreView = ({
            MoreView *view = [MoreView new];
            
            // 定义显示内容
            NSArray *titleArray = @[@"历史记录"];
            
            UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
            [window addSubview:view];
            
            // 布局
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(window).insets(UIEdgeInsetsZero);
            }];
            
            view.titleArray = titleArray;
            view.delegate = self;
            
            view;
        });
    }
    return _moreView;
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
