//
//  DetailView.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/31.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "DetailView.h"
#import "ResourceModel.h"
#import "UIColor+Ext.h"
#import "Masonry.h"
#import "UIView+LJC.h"
#import "MyLabel.h"

#define kPadding 5

@interface DetailView ()
// 上半部分,scrollView显示
@property (nonatomic, strong) UIScrollView *scrollView;         // scrollview，用于滑动显示
@property (nonatomic, strong) UILabel *accountLabel;            // 宽带账号
@property (nonatomic, strong) UILabel *userNameLabel;           // 用户姓名
@property (nonatomic, strong) UILabel *wayLabel;                // 接入方式
@property (nonatomic, strong) UILabel *workNumLabel;            // 工单编号
@property (nonatomic, strong) UILabel *orderNumLabel;           // 订单编号
@property (nonatomic, strong) UILabel *orderStatusLabel;        // 订单状态
@property (nonatomic, strong) UILabel *activeStatusLabel;       // 激活结果
// 下半部分，其他信息
@property (nonatomic, strong) UIView *bottomView;               // 下层View
@property (nonatomic, strong) UILabel *originAddressLabel;      // 原地址
@property (nonatomic, strong) UILabel *addressLabel;            // 新地址
@property (nonatomic, strong) UILabel *originPortalLabel;       // 原端口
@property (nonatomic, strong) UILabel *portalLabel;             // 新端口
@property (nonatomic, strong) UILabel *reasonLabel;             // 更改原因
@end

@implementation DetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self uiConfig];
    }
    return self;
}

- (void)setModel:(ResourceModel *)model
{
    _model = model;
    
    self.accountLabel.text = model.accountName;
    self.userNameLabel.text = model.userName;
    self.wayLabel.text = model.way;
    self.workNumLabel.text = model.workOrderNum;
    self.orderNumLabel.text = model.orderNum;
    self.orderStatusLabel.text = model.orderStatus;
    self.activeStatusLabel.text = model.activeStatus;
    if ([model.activeStatus isEqualToString:@"激活成功!"]) {
        self.activeStatusLabel.textColor = UIColorFromHex(0x0185ce);
    } else if ([model.activeStatus isEqualToString:@"激活失败!"]){
        self.activeStatusLabel.textColor = [UIColor redColor];
    }

    self.originAddressLabel.text = model.originAddressName;
    self.addressLabel.text = model.addressName;
    self.addressLabel.textColor = [UIColor redColor];
    self.originPortalLabel.text = model.originPortName;
    self.portalLabel.text = model.portName;
    self.portalLabel.textColor = [UIColor redColor];
    self.reasonLabel.text = model.changeReason;
}

#pragma mark -----------辅助方法-----------
// 因为model的text内容可能为nil，处理当nil时返回空串
- (NSString *)convertText:(NSString *)text
{
    if (text) {
        return text;
    }
    return @"";
}

/**
 *  初始化Label
 *
 *  @param superView 父视图
 *  @param array     view数组
 *
 *  @return label
 */
- (UILabel *)createLabelWithView:(UIView *)superView array:(NSMutableArray *)array
{
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 20;
    label.font = [UIFont systemFontOfSize:14];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.textColor = UIColorFromHex(0x666666);
    
    [superView addSubview:label];
    [array addObject:label];
    return label;
}

/**
 *  自定义View，添加分割线，向右按钮和一个label,一个title信息
 *
 *  @param superView 父视图
 *  @param array     view数组
 *  @param index     index
 *  @param title     title信息
 *  @param hasBtn    是否有按钮
 *
 *  @return view
 */
- (UIView *)createViewWithView:(UIView *)superView array:(NSMutableArray *)array index:(NSInteger)index title:(NSString *)title hasBtn:(BOOL)hasBtn
{
    UIView *view = ({
        UIView *mainView = [UIView new];
        mainView.tag = index;
        [superView addSubview:mainView];
        
        // 添加分割线
        UILabel *lineLabel = [UILabel new];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [mainView addSubview:lineLabel];
        
        // 添加title信息
        UILabel *titleLabel = ({
            UILabel *label;
            if (hasBtn) {
                label = [UILabel new];
            } else {
                label = [MyLabel new];
                ((MyLabel *)label).verticalAlignment = VerticalAlignmentTop;
            }
            label.textColor = UIColorFromHex(0x0185ce);
            label.text = title;
            label.font = [UIFont systemFontOfSize:15];
            [mainView addSubview:label];
            
            label;
        });
        
        // 添加文字信息
        UILabel *label;
        if (hasBtn) {
            label = [UILabel new];
        } else {
            label = [MyLabel new];
            ((MyLabel *)label).verticalAlignment = VerticalAlignmentTop;
        }
        label.numberOfLines = 0;
        label.preferredMaxLayoutWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 100;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = UIColorFromHex(0x666666);
        [mainView addSubview:label];
        
        UIButton *btn;
        if (hasBtn) {
            // 添加按钮
            btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.userInteractionEnabled = NO;
            [btn setImage:[UIImage imageNamed:@"right-arrow"] forState:UIControlStateNormal];
            [mainView addSubview:btn];
        }

        // 布局
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(mainView).insets(UIEdgeInsetsZero);
            make.height.mas_equalTo(1);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(mainView).insets(UIEdgeInsetsZero);
            make.top.mas_equalTo(lineLabel.mas_bottom).offset(kPadding);
            make.width.mas_equalTo(65);
            if (hasBtn) {
                make.height.mas_greaterThanOrEqualTo(25);
            } else {
                make.height.mas_greaterThanOrEqualTo(10);
            }
            make.centerY.equalTo(label);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(kPadding);
            make.top.mas_equalTo(lineLabel.mas_bottom).offset(kPadding);
            if (hasBtn) {
                make.right.equalTo(btn.mas_left).offset(-kPadding);
            }
        }];
        
        if (hasBtn) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(mainView.mas_right).offset(kPadding);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(30);
                make.centerY.equalTo(label);
            }];
            
            if (index == 0) {
                btn.hidden = YES;
                self.originAddressLabel = label;
            } else if (index == 1) {
                self.addressLabel = label;
                [self addGestureToView:mainView];
            } else if (index == 2) {
                self.originPortalLabel = label;
                btn.hidden = YES;
            } else if (index == 3) {
                self.portalLabel = label;
                [self addGestureToView:mainView];
            } else {
                self.reasonLabel = label;
                [self addGestureToView:mainView];
            }
        } else {
            if (index == 0) {
                self.accountLabel = label;
            } else if (index == 1) {
                self.userNameLabel = label;
            } else if (index == 2) {
                self.wayLabel = label;
            } else if (index == 3) {
                self.workNumLabel = label;
            } else if (index == 4){
                self.orderNumLabel = label;
            } else if (index == 5) {
                self.orderStatusLabel = label;
            } else {
                self.activeStatusLabel = label;
            }
        }
        
        mainView;
    });
    
    [array addObject:view];
    return view;
}


/**
 *  给指定视图添加手势
 *
 */
- (void)addGestureToView:(UIView *)view
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
   [view addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(detailInfo:)]) {
        [self.delegate detailInfo:tap.view.tag];
    }
}

#pragma mark -----------UI-----------
- (void)uiConfig
{
    // 上半部分scrollView
    [self configScrollView];
    
    // 下半部分View
    [self configBottomView];
}

- (void)configScrollView
{
    self.scrollView = ({
        UIScrollView *scroll = [UIScrollView new];
        [self addSubview:scroll];
        
        [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(kPadding, kPadding, 0, kPadding));
        }];
        
        scroll;
    });
    // 用于存储所有label
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    NSArray *titles = @[@"宽带账号:",
                        @"用户姓名:",
                        @"接入方式:",
                        @"工单编号:",
                        @"订单编号:",
                        @"订单状态:",
                        @"激活状态"];
    UIView *view1 = [self createViewWithView:self.scrollView array:viewArray index:0 title:titles[0] hasBtn:NO];
    UIView *view2 = [self createViewWithView:self.scrollView array:viewArray index:1 title:titles[1] hasBtn:NO];
    UIView *view3 = [self createViewWithView:self.scrollView array:viewArray index:2 title:titles[2] hasBtn:NO];
    UIView *view4 = [self createViewWithView:self.scrollView array:viewArray index:3 title:titles[3] hasBtn:NO];
    UIView *view5 = [self createViewWithView:self.scrollView array:viewArray index:4 title:titles[4] hasBtn:NO];
    UIView *view6 = [self createViewWithView:self.scrollView array:viewArray index:5 title:titles[5] hasBtn:NO];
    UIView *view7 = [self createViewWithView:self.scrollView array:viewArray index:6 title:titles[6] hasBtn:NO];
    
    [viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView).insets(UIEdgeInsetsZero);
    }];
    
    // 竖直方向上间距固定，大小不固定
    [self.scrollView distributeSpacingVerticallyWith:viewArray];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom);
    }];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom);
    }];
    
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom);
    }];
    
    [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view5.mas_bottom);
    }];
    
    [view7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view6.mas_bottom);
    }];
}

- (void)configBottomView
{
    self.bottomView = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self).insets(UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding));
            make.top.mas_equalTo(self.scrollView.mas_bottom).offset(-kPadding);
        }];
        
        view;
    });
    
    // 用于存储所有View
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    NSArray *titles = @[@"原地址:",
                        @"新地址:",
                        @"原端口:",
                        @"新端口:",
                        @"更改原因:"];
    UIView *view1 = [self createViewWithView:self.bottomView array:viewArray index:0 title:titles[0] hasBtn:YES];
    UIView *view2 = [self createViewWithView:self.bottomView array:viewArray index:1 title:titles[1] hasBtn:YES];
    UIView *view3 = [self createViewWithView:self.bottomView array:viewArray index:2 title:titles[2] hasBtn:YES];
    UIView *view4 = [self createViewWithView:self.bottomView array:viewArray index:3 title:titles[3] hasBtn:YES];
    UIView *view5 = [self createViewWithView:self.bottomView array:viewArray index:4 title:titles[4] hasBtn:YES];
    
    [viewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bottomView).insets(UIEdgeInsetsZero);
    }];
    
    // 竖直方向上间距固定，大小不固定
    [self.bottomView distributeSpacingVerticallyWith:viewArray];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(kPadding);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).offset(kPadding);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom).offset(kPadding);
    }];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).offset(kPadding);
    }];
    
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.mas_bottom).offset(kPadding);
    }];
}

@end
