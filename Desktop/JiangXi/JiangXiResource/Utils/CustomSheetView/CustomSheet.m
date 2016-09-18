//
//  CustomSheet.m
//  CustomSheetDemo
//
//  Created by 信辉科技 on 16/8/18.
//  Copyright © 2016年 One. All rights reserved.
//

#import "CustomSheet.h"
#import "Masonry.h"
#import "CustomSheetCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CustomModel.h"
#import "MJRefresh.h"

// 自定义CellId
#define kCellId @"cellId"
// 与屏幕边距
#define kPadding 10
// tableView与按钮边距
#define kBtnPadding 5
// 按钮的高度
#define kBtnHeight 45
// 总宽度
#define kScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
// weakSelf
#define WeakSelf __weak typeof(self) weakSelf = self

@interface CustomSheet ()
<
UITableViewDelegate,
UITableViewDataSource,
UIGestureRecognizerDelegate>
// UI相关
@property (nonatomic, strong) UIView *mainView;             // 主事图
@property (nonatomic, strong) UITableView *tableView;       // 显示数据信息
@property (nonatomic, strong) UIView *btnViews;             // 用于显示按钮信息
// 数据相关
@property (nonatomic, strong) NSMutableArray *dataArray;    // 用于actionSheet展示的数据
@property (nonatomic, assign) NSInteger maxCount;           // 显示最大个数，如果不足该个数的话，显示当前总个数
@property (nonatomic, assign) BOOL allowMultiple;           // 是否允许多选
@property (nonatomic, strong) NSArray *btnTitles;           // 用于按钮的title
@property (nonatomic, strong) NSString *title;              // 用于整个标题
@property (nonatomic, assign) BOOL lineBreak;               // 是否允许换行
@property (nonatomic, assign) BOOL canRequest;              // 是否可以上下拉刷新数据
@property (nonatomic, assign) float height;                 // tableView的高度
@property (nonatomic, strong) NSMutableArray *selectIndexs; // 选中的index
@end

@implementation CustomSheet
- (instancetype)initWithDataArray:(NSMutableArray *)dataArray maxCount:(NSInteger)maxCount allowMultiple:(BOOL)allowMultiple btnTitles:(NSArray *)btnTitles title:(NSString *)title lineBreak:(BOOL)lineBreak canRequest:(BOOL)canRequest
{
    self = [super init];
    if (self) {
        // 设置背景色为灰色
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        // 手势点击消失
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        // 数据
        self.maxCount = maxCount;
        self.allowMultiple = allowMultiple;
        self.btnTitles = btnTitles;
        self.title = title;
        self.lineBreak = lineBreak;
        self.canRequest = canRequest;
        
        for (NSString *str in dataArray) {
            [self.dataArray addObject:[CustomModel setModelWithText:str lineBreak:self.lineBreak]];
        }
        
        if (self.dataArray.count > maxCount) {
            for (int i = 0; i < maxCount; i++) {
                CustomModel *model = self.dataArray[i];
                self.height += model.height;
            }
        } else {
            for (int i = 0; i < self.dataArray.count; i++) {
                CustomModel *model = self.dataArray[i];
                self.height += model.height;
            }
        }
        
        [self uiConfig];
    }
    return self;
}

#pragma mark -----------其他方法-----------
- (void)refreshData:(NSMutableArray *)dataArray
{
    // 关闭上拉下拉动画效果
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self.dataArray removeAllObjects];
    self.height = 0;
    
    for (NSString *str in dataArray) {
        [self.dataArray addObject:[CustomModel setModelWithText:str lineBreak:self.lineBreak]];
    }
    
    if (self.dataArray.count > self.maxCount) {
        for (int i = 0; i < self.maxCount; i++) {
            CustomModel *model = self.dataArray[i];
            self.height += model.height;
        }
    } else {
        for (int i = 0; i < self.dataArray.count; i++) {
            CustomModel *model = self.dataArray[i];
            self.height += model.height;
        }
    }
    
    [self.tableView reloadData];

    // 更新UI
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.height);
    }];
}
// 提交数据
- (void)confirm
{
    // 判断有没有选中信息
    if (self.selectIndexs.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择至少一个" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSNumber *indexNum in self.selectIndexs) {
        CustomModel *model = self.dataArray[[indexNum integerValue]];
        [array addObject:model.text];
    }
    
    if ([self.delegate respondsToSelector:@selector(resultValue:)]) {
        [self.delegate resultValue:array];
    }
    [self dismiss];
    
}

- (UIButton *)createBtnWithTitle:(NSString *)title AndIndex:(NSInteger)index
{
    UIButton *button = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = index;
        
        btn;
    });
    return button;
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)btnAction:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"确定"]) {
        [self confirm];
    } else {
        [self dismiss];
    }
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    [window addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(window).insets(UIEdgeInsetsZero);
    }];
    
//    // 动画效果
//    // 告诉self.view约束需要更新
//    [self setNeedsUpdateConstraints];
//    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
//    [self updateConstraintsIfNeeded];
//    
//    [UIView animateWithDuration:0.3 animations:^{
////        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.height.mas_equalTo(self.height);
////        }];
//        [self layoutIfNeeded];
//    }];
    
//    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.3;
//    
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, self.height, 0)]];
//    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.02, 1.02, 1.0)]];
//    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    [self.tableView.layer addAnimation:animation forKey:nil];
    
}

#pragma mark -----------UI-----------
- (void)uiConfig
{
    self.mainView = ({
        UIView *mainView = [UIView new];
        [self addSubview:mainView];
        
        [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(self.height + kPadding * 2 + kBtnHeight);
        }];
        
        // 从下往上布局
        self.btnViews = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 15;
            [mainView addSubview:view];
            
            // 父视图布局
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(mainView).insets(UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding));
                make.height.mas_equalTo(kBtnHeight);
            }];
            
            NSMutableArray *btnArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.btnTitles.count; i++) {
                NSString *title = self.btnTitles[i];
                UIButton *btn = [self createBtnWithTitle:title AndIndex:i];
                [view addSubview:btn];
                [btnArray addObject:btn];
            }
            
            [btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(view).insets(UIEdgeInsetsZero);
            }];
            
            if (btnArray.count == 1) {
                // 按钮个数为1的时候，不用distribute，会报错
                [btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(view).insets(UIEdgeInsetsZero);
                }];
            } else {
                /**
                 *  axisType：对齐方向
                 *  fixedSpacing:间距
                 *  leadSpacing:头部间隔
                 *  tailSpacing:尾部间距
                 */
                [btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
            }
            
            
            view;
        });
        
        self.tableView = ({
            UITableView *table = [UITableView new];
            table.layer.masksToBounds = YES;
            table.layer.cornerRadius = 15;
            [table registerClass:[CustomSheetCell class] forCellReuseIdentifier:kCellId];
            table.delegate = self;
            table.dataSource = self;
            
            // 隐藏空白行
            table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            
            //处理tableview 分割线到头
            if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
                [table setSeparatorInset:UIEdgeInsetsZero];
            }
            
            if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
                [table setLayoutMargins:UIEdgeInsetsZero];
            }
            
            if (self.canRequest) {
                // 给tableView添加刷新视图
                WeakSelf;
                // 下拉刷新
                table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [weakSelf.delegate refresh:YES];
                }];
                
                // 设置自动切换透明度(在导航栏下面自动隐藏)
                table.mj_header.automaticallyChangeAlpha = YES;
                
                // 上拉加载下一页
                table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf.delegate refresh:NO];
                }];
            }
            
            [mainView addSubview:table];
            // 布局
            [table mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(mainView).insets(UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding));
                make.bottom.equalTo(self.btnViews.mas_top).offset(-kBtnPadding);
                make.height.mas_equalTo(self.height);
            }];
            
            table;
        });
        
        mainView;
    });
    
    CATransition *trans = [CATransition animation];
    trans.type = kCATransitionPush;
    trans.duration = 0.3;
    trans.subtype = kCATransitionFromTop;
    
    CALayer *layer = self.mainView.layer;
    [layer addAnimation:trans forKey:@"Transition"];
    
}

#pragma mark -----------代理-----------
#pragma mark -----------处理手势冲突-----------
#pragma mark UIGestureRecognize Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
#pragma mark UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    [cell fillCell:self.dataArray[indexPath.row] lineBreak:self.lineBreak];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allowMultiple) {
        // 选中的时候变红，默认是蓝色
        CustomSheetCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([self.selectIndexs containsObject:@(indexPath.row)]) {
            cell.cellSelect = NO;
        } else {
            [self.selectIndexs addObject:@(indexPath.row)];
            cell.cellSelect = YES;
        }
    } else {
        [self.selectIndexs addObject:@(indexPath.row)];
        [self confirm];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomModel *model = self.dataArray[indexPath.row];
    return model.height;
}

-  (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // iso 7
    if ([cell  respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    // ios 8
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -----------初始化-----------
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)selectIndexs
{
    if (_selectIndexs == nil) {
        _selectIndexs = [[NSMutableArray alloc] init];
    }
    return _selectIndexs;
}
@end
