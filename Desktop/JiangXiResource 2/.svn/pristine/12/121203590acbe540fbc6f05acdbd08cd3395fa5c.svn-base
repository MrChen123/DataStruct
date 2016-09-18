//
//  SearchEquipmentFootView.m
//  JiangXiResource
//
//  Created by xinjie on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "SearchEquipmentFootView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"
#import "CommonDefine.h"

@interface SearchEquipmentFootView ()

@property (nonatomic ,strong) UIButton *searchButton; // 搜索
@property (nonatomic ,strong) UIButton *resetButton;  // 重置

@end

@implementation SearchEquipmentFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = black_color_245;
        [self createUI];
    }
    return self;
}

- (void) createUI{
    self.resetButton = [self createBtnWithTitle:@"重置" tag:ResetButtonTag];
    self.searchButton = [self createBtnWithTitle:@"查询" tag:SearchButtonTag];
    
    NSArray *array = @[self.resetButton,self.searchButton];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:20 tailSpacing:20];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (UIButton *)createBtnWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:UIColorFromHex(0x0185ce)];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5.f;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = tag;
        btn;
    });
    return button;
}

- (void)btnAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(searchEquipmentFootViewBtnClick:)]) {
        [self.delegate searchEquipmentFootViewBtnClick:button.tag];
    }
}


@end
