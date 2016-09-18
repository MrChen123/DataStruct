//
//  MoreView.m
//  YunNanJK
//
//  Created by 信辉科技 on 16/7/22.
//  Copyright © 2016年 wuxinjie. All rights reserved.
//

#import "MoreView.h"
#import "Masonry.h"

// 自定义高度和宽度
#define kHeight 40
#define kWidth 120

@interface MoreView ()
<
UIGestureRecognizerDelegate
>
@property (nonatomic, strong) UIView *mainView;     // 用于放置所有的按钮
@end

@implementation MoreView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置背景色
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        // 添加手势，用于取消
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];

        // UI布局
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig
{
    self.mainView = ({
        UIView *view = [UIView new];
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 1;
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        
        [self addSubview:view];
        
        view;
    });
}

// 手势取消
- (void)cancel:(id)sender
{
    self.isShow = NO;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kHeight * titleArray.count);
        make.width.mas_equalTo(kWidth);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(64);
    }];
    
    // 存储view
    NSMutableArray *subViews = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *btn = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = i;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.mainView addSubview:button];
            
            button;
        });
        [subViews addObject:btn];
    }
    
    // 布局
    [subViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.mainView).insets(UIEdgeInsetsZero);
    }];
    
    // bug修改，如果titleArray个数为1时, distribute方法会报错
    if (subViews.count == 1) {
        [subViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.mainView).insets(UIEdgeInsetsZero);
        }];
    } else {
        [subViews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    }
    
}

- (void)setIsShow:(BOOL)isShow
{
    _isShow = isShow;
    self.hidden = !isShow;
}

// 点击按钮
- (void)btnAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(clickItem:)]) {
        [self.delegate clickItem:btn.tag];
    }
    self.isShow = !self.isShow;
}


@end
