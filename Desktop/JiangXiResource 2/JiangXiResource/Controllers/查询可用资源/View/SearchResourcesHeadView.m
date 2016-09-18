//
//  SearchResourcesHeadView.m
//  JiangXiResource
//
//  Created by xinjie on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "SearchResourcesHeadView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"
#import "CommonDefine.h"

@interface SearchResourcesHeadView ()

@property (nonatomic ,strong) UIView *searchBackView;           // 扫码 设备查询 地址查询等搜索按钮 背景view
@property (nonatomic ,strong) UIButton *qRCodeBtn;              // 扫码
@property (nonatomic ,strong) UIButton *equipmentBtn;           // 设备查询
@property (nonatomic ,strong) UIButton *addressBtn;             // 地址查询

@property (nonatomic ,strong) UIView *oldAddressBackView;       // 原地址 原设备 等按钮背景view
@property (nonatomic ,strong) UISegmentedControl *segmentedControl;          // 原地址按钮
@end


@implementation SearchResourcesHeadView
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
    self.searchBackView = [self createBackView];
    self.oldAddressBackView = [self createBackView];
    
    NSArray *bacViewArray = @[self.searchBackView,
                       self.oldAddressBackView];
    [bacViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:0 tailSpacing:0];
    [bacViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
    }];
    
    self.qRCodeBtn = [self createBtnWithTitle:@"扫码" tag:QRCodeBtnTag imageName:@"saomiao"];
    self.equipmentBtn = [self createBtnWithTitle:@"设备" tag:EquipmentBtnTag imageName:@"search_image"];
    self.addressBtn = [self createBtnWithTitle:@"地址" tag:AddressBtnTag imageName:@"search_image"];
    NSArray *searchArray = @[self.qRCodeBtn,
                       self.equipmentBtn,
                       self.addressBtn];
    [searchArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    [searchArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBackView);
        make.bottom.equalTo(self.searchBackView);
    }];

    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"原设备",@"原地址"]];
    [self.oldAddressBackView addSubview:self.segmentedControl];
    //设置默认的选择项
    self.segmentedControl.selectedSegmentIndex = -1;
    self.segmentedControl.tintColor = UIColorFromHex(0x0185ce);
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromHex(0x333333),
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:14],
                         NSFontAttributeName,nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlClick:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.oldAddressBackView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
}

- (void)setSegmentedControlSelectedSegmentIndex{
    self.segmentedControl.selectedSegmentIndex = -1;
}

/**
 *  分段选择器点击事件
 *
 *  @param segmentedControl 分段选择器
 */
- (void)segmentedControlClick:(UISegmentedControl *)segmentedControl{
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        // 原设备按钮点击
        if ([self.delegate respondsToSelector:@selector(searchResourcesHeadViewBtnClick:)]) {
            [self.delegate searchResourcesHeadViewBtnClick:OldEquipmentCodeBtnTag];
        }
    } else {
        // 原地址按钮点击
        if ([self.delegate respondsToSelector:@selector(searchResourcesHeadViewBtnClick:)]) {
            [self.delegate searchResourcesHeadViewBtnClick:OldAddressBtnTag];
        }
    }
}

// 扫码 设备查询 地址查询 按钮点击事件
- (void)btnAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(searchResourcesHeadViewBtnClick:)]) {
        [self.delegate searchResourcesHeadViewBtnClick:button.tag];
    }
}

/**
 *  创建一个backView
 *
 *  @return view
 */
- (UIView *)createBackView{
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    return view;
}

/**
 *  创建一个button
 *
 *  @param title     button Title
 *  @param tag       button Tag （SearchResourcesHeadViewBtnTag）
 *  @param imageName 图片名
 *
 *  @return button
 */
- (UIButton *)createBtnWithTitle:(NSString *)title tag:(NSInteger)tag imageName:(NSString *)imageName
{
    UIButton *button = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.searchBackView addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5.f;
        btn.layer.borderWidth = 1;
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        btn.layer.borderColor = UIColorFromHex(0x0185ce).CGColor;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = tag;
        btn;
    });
    return button;
}


@end
