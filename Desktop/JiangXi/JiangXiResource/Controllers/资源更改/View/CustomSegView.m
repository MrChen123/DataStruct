//
//  CustomSegView.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/30.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "CustomSegView.h"
#import "Masonry.h"
#import "UIColor+Ext.h"
// 分段选择器按钮选中颜色
#define kBtnSelectedColor UIColorFromHex(0x0185ce)

@interface CustomSegView ()
@property (nonatomic, strong) UIButton *selectBtn;          // 当前选中的按钮，在isDifferent为YES时使用
@property (nonatomic, strong) NSMutableArray *btnArray;     // 用于存储所有按钮
@end

@implementation CustomSegView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    // 清除子视图，重新布局
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    [self.btnArray removeAllObjects];
    
    NSMutableArray *subViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *btn = ({
            UIButton *button;
            
            if (self.isDifferent) {
                // 选中和未选中按钮有不同
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.layer.borderColor = kBtnSelectedColor.CGColor;
                button.layer.borderWidth = 1;
                button.titleLabel.font = [UIFont systemFontOfSize:16];
                [button setTitle:titleArray[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [button setTitleColor:kBtnSelectedColor forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                [button setBackgroundColor:[UIColor whiteColor]];
                button.tag = i;
                if (!self.notHasSelect) {
                    // 刚进来存在选中
                    if (i == 0) {
                        self.selectBtn = button;
                        button.selected = YES;
                        button.backgroundColor = kBtnSelectedColor;
                    }
                }
            } else {
                button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.titleLabel.font = [UIFont systemFontOfSize:16];
                [button setTitle:titleArray[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                if (i == 0) {
                    button.backgroundColor = kBtnSelectedColor;
                } else {
                    button.backgroundColor = [UIColor colorWithRed:1.00f green:0.56f blue:0.55f alpha:1.00f];
                }
                button.tag = i;
            }
            
            [self addSubview:button];
            // 添加到数组里面
            [self.btnArray addObject:button];
            button;
        });
        [subViews addObject:btn];
    }
    
    [subViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).insets(UIEdgeInsetsZero);
    }];
    
    [subViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
}

- (void)btnAction:(UIButton *)btn
{
    if (self.isDifferent) {
        self.selectBtn.selected = NO;
        self.selectBtn.backgroundColor = [UIColor whiteColor];
        
        btn.selected = YES;
        btn.backgroundColor = kBtnSelectedColor;
        self.selectBtn = btn;
    }

    // 使用代理
    if ([self.delegate respondsToSelector:@selector(clickSegItem:)]) {
        [self.delegate clickSegItem:btn.tag];
    }
    
}

- (void)scrollToIndex:(NSInteger)index
{
    self.selectBtn.selected = NO;
    self.selectBtn.backgroundColor = [UIColor whiteColor];
    
    for (UIButton *btn in self.subviews) {
        if (btn.tag == index) {
            btn.selected = YES;
            btn.backgroundColor = kBtnSelectedColor;
            self.selectBtn = btn;
            
            break;
        }
    }
}

- (void)refreshTitle:(NSString *)title WithIndex:(NSInteger)index
{
    UIButton *btn = self.btnArray[index];
    [btn setTitle:title forState:UIControlStateNormal];
}

#pragma mark -----------懒加载-----------
- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}


@end
