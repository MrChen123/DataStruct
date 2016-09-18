//
//  SearchEquipmentHeadView.m
//  JiangXiResource
//
//  Created by xinjie on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "SearchEquipmentHeadView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"
#import "CommonDefine.h"
@interface SearchEquipmentHeadView ()

@property (nonatomic ,strong) UIView *sliderBackView;       // 进度条底部视图
@property (nonatomic ,strong) UISlider *slider;             // 滑块
@property (nonatomic ,strong) UILabel *sliderLabel;         // 滑块的值
@property (nonatomic , strong) NSArray *sliderNumArray;     // 滑块固定值数组

@property (nonatomic ,strong) UIView *cityBackView;         // 所属区县
@property (nonatomic ,strong) UILabel *cityNameLabel;       // 所属区县名称lable

@property (nonatomic ,strong) UIView *equipmentBackView;    // 选择设备底部视图
@property (nonatomic ,strong) UILabel *equipmentNameLB;     // 设备名称

@end

@implementation SearchEquipmentHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xd2d2d2);
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorFromHex(0xd2d2d2).CGColor;

        [self createUI];
    }
    return self;
}

- (void)createUI{

    self.sliderBackView = [self createBackView];
    self.cityBackView = [self createBackView];
    self.cityBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *cityTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityTapClick)];
    [self.cityBackView addGestureRecognizer:cityTap];

    self.equipmentBackView = [self createBackView];
    self.equipmentBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *equipmentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(equipmentTapClick)];
    [self.equipmentBackView addGestureRecognizer:equipmentTap];

    
    NSArray *array = @[self.sliderBackView,
                       self.cityBackView,
                       self.equipmentBackView];
    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
    }];
    
    self.sliderLabel = [self createLabeltext:@"0" backView:self.sliderBackView];
    [self.sliderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sliderBackView.mas_top);
        make.centerX.mas_equalTo(self.sliderBackView.mas_centerX);
    }];
    
    self.slider = [[UISlider alloc] init];
    [self.sliderBackView addSubview:self.slider];
    
    self.sliderNumArray = @[@(0),@(50), @(100), @(150), @(200), @(250), @(300), @(400), @(500), @(600), @(1000), @(1500), @(2000)];

    NSInteger numberOfSteps = ((float)[self.sliderNumArray count] - 1);
    self.slider.maximumValue = numberOfSteps;
    self.slider.minimumValue = 0;
    self.slider.continuous = YES; // NO makes it call only once you let go
    [self.slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];

    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.sliderBackView.mas_bottom).offset(-5);
        make.left.mas_equalTo(self.sliderBackView).offset(10);
        make.right.mas_equalTo(self.sliderBackView).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    self.cityNameLabel = [self createLabeltext:@"所属区县: 南昌县" backView:self.cityBackView];
    [self.cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityBackView).offset(10);
        make.centerY.equalTo(self.cityBackView.mas_centerY);
    }];
    
    self.equipmentNameLB = [self createLabeltext:@"选择设备: BBU" backView:self.equipmentBackView];
    [self.equipmentNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.equipmentBackView).offset(10);
        make.centerY.equalTo(self.equipmentBackView.mas_centerY);
    }];
}

- (void)setSilderValue{
    self.sliderLabel.text = @"0";
    self.slider.value = 0;
    if ([self.delegate respondsToSelector:@selector(passSliderText:)]) {
        [self.delegate passSliderText:self.sliderLabel.text];
    }
}

- (void)setTextString:(NSString *)textString TapViewTag:(TapViewTag)tag{
    if (tag == CityBackViewTag) {
        [self.cityNameLabel setText:[NSString stringWithFormat:@"所属区县: %@",textString]];
    } else {
        [self.equipmentNameLB setText:[NSString stringWithFormat:@"选择设备: %@",textString]];
    }
}

- (void)cityTapClick{
    if ([self.delegate respondsToSelector:@selector(showPromptView:)]) {
        [self.delegate showPromptView:CityBackViewTag];
    }
}

- (void)equipmentTapClick{
    if ([self.delegate respondsToSelector:@selector(showPromptView:)]) {
        [self.delegate showPromptView:EquipmentBackViewTag];
    }
}

// 滑块值变动调用
- (void)valueChanged:(UISlider *)sender {
    // round the slider position to the nearest index of the numbers array
    NSUInteger index = (NSUInteger)(_slider.value + 0.5);
    [self.slider setValue:index animated:NO];
    NSNumber *number = self.sliderNumArray[index];
    NSInteger inde = [number integerValue];
    
    self.sliderLabel.text = [NSString stringWithFormat:@"%@", @(inde)];
    if ([self.delegate respondsToSelector:@selector(passSliderText:)]) {
        [self.delegate passSliderText:self.sliderLabel.text];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[[UIApplication sharedApplication] delegate] window] endEditing:YES];
}


-(UILabel *)createLabeltext:(NSString *)text backView:(UIView *)backView{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = UIColorFromHex(0x0185ce);
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:label];
    return label;
}

- (UIView *)createBackView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    return view;
}

@end
