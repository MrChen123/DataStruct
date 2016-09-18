//
//  PromptChooseView.m
//  JiangXiResource
//
//  Created by xinjie on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "PromptChooseView.h"
#import "UIColor+Ext.h"
#import "PromptChooseTableViewCell.h"
#import "CommonLogic.h"
#import <Masonry/Masonry.h>

@interface PromptChooseView ()

@property (nonatomic , strong) NSMutableArray *inpathArray; // 记录多选cell
@property (nonatomic , strong) NSMutableArray *titleListArray; // 数据源model Array
@property (nonatomic , strong) UIView *backView; // 背景View
@property (nonatomic , strong) UIView *backGroundView; // 背景View
@property (nonatomic , strong) UIView *footView;
@property (nonatomic , strong) UITableView *listTableView;
@property (nonatomic , strong) UIButton *cancelButton; // 取消按钮
@property (nonatomic , strong) UIButton *sureButton; // 确认按钮
@property (nonatomic , strong) UIButton *removeButton; // 清除按钮

@end

@implementation PromptChooseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setListArray:(NSArray *)listArray;
{
    self.titleListArray = [[NSMutableArray alloc] initWithArray:listArray];
    
    [self initWithBackView];
    [self initWithTableView];
    [self initWithButton];
    
    [self layoutIfNeeded];
    [self updateUI]; // 开启动画
}

- (void)initWithBackView{
    float backGroundViewheight = 0;
    if (self.titleListArray.count > 5) {
        backGroundViewheight = 45 * 5;
    } else {
        backGroundViewheight = 45*self.titleListArray.count;
    }
    
    self.backGroundView = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.mas_equalTo(self.mas_bottom).offset((backGroundViewheight+60));
            make.height.mas_equalTo(backGroundViewheight+60);
        }];
        view;
    });
    
    
    self.backView = ({
        UIView *view = [[UIView alloc] init];
        [self.backGroundView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.backGroundView);
            make.bottom.mas_equalTo(self.backGroundView).offset(-60);
            make.height.mas_equalTo(backGroundViewheight);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 15;
        view;
    });
    
    self.footView = ({
        UIView *view = [[UIView alloc] init];
        [self.backGroundView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backGroundView);
            make.right.equalTo(self.backGroundView);
            make.bottom.mas_equalTo(self.backGroundView).offset(-10);
            make.height.mas_equalTo(@45);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 15;
        view;
    });
}

- (void)initWithButton{
    self.cancelButton = [self createBtnWithTitle:@"取消" tag:PromptChooseViewCancelButtonTag];
    
    if (self.style == PromptChooseViewStlyOrMultiSelect && self.titleListArray.count > 0) {
        self.removeButton = [self createBtnWithTitle:@"清除" tag:PromptChooseViewRemoveButtonTag];
        self.sureButton = [self createBtnWithTitle:@"确定" tag:PromptChooseViewSureButtonTag];
        /**
         *  多个控件固定间隔的等间隔排列，变化的是控件的长度或者宽度值
         *
         *  @param axisType        轴线方向
         *  @param fixedSpacing    间隔大小
         *  @param leadSpacing     头部间隔
         *  @param tailSpacing     尾部间隔
         */
        
        NSArray *array = @[self.cancelButton,self.removeButton,self.sureButton];
        [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [array mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.footView);
            make.height.equalTo(self.footView.mas_height);
        }];
    } else if (self.style == PromptChooseViewStlyOrClean){
        self.removeButton = [self createBtnWithTitle:@"清除" tag:PromptChooseViewRemoveButtonTag];
        
        NSArray *array = @[self.removeButton,self.cancelButton];
        [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [array mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.footView);
            make.height.equalTo(self.footView.mas_height);
        }];
        
    } else {
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.footView);
        }];
    }
}


- (void)initWithTableView{
    self.listTableView = ({
        UITableView *view = [[UITableView alloc] init];
        [self.backView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.backView);
        }];
        [view registerClass:[PromptChooseTableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = UIColorFromHex(0xF6F6F6);
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 15;
        //处理tableview 分割线到头
        if ([view respondsToSelector:@selector(setSeparatorInset:)]) {
            [view setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([view respondsToSelector:@selector(setLayoutMargins:)]) {
            [view setLayoutMargins:UIEdgeInsetsZero];
        }
        view;
    });
}

- (void)updateUI{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                         
                         [self.backGroundView mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.bottom.mas_equalTo(self.mas_bottom).offset(0);
                         }];
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                     }];
}

// 按钮的点击事件
- (void)btnAction:(UIButton *)button{
    
    switch (button.tag) {
            
        case PromptChooseViewCancelButtonTag:
            [self removeViewIsSelf];
            break;
        case PromptChooseViewSureButtonTag:{
            if (self.inpathArray.count == 0 || self.inpathArray == nil) {
                [CommonLogic showPromptInfo:@"请选择"];
                return;
            }
            NSString *text = @"";
            
            for (NSInteger index = 0; index < self.inpathArray.count; index++) {
                NSInteger indexs = [self.inpathArray[index] integerValue];
                if (index == self.inpathArray.count - 1) {
                    text = [text stringByAppendingString:[NSString stringWithFormat:@"%@",self.titleListArray[indexs]]];
                }else{
                    text = [text stringByAppendingString:[NSString stringWithFormat:@"%@,",self.titleListArray[indexs]]];
                }
            }
            if ([self.delegate respondsToSelector:@selector(refreshView:)])
            {
                [self.delegate refreshView:text];
                [self removeViewIsSelf];
            }
            break;
        }
        case PromptChooseViewRemoveButtonTag:
            if ([self.delegate respondsToSelector:@selector(refreshView:)])
            {
                [self.delegate refreshView:@""];
                [self removeViewIsSelf];
            }
            break;
            
        default:
            break;
    }
}

// sele的手势点击
- (void)tapClick{
    [self removeViewIsSelf];
}

- (void)removeViewIsSelf{
    [UIView animateWithDuration:0.3 animations:^(void){
        [self.backGroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).offset((400));
        }];
        [self layoutIfNeeded]; // 立即生效 不加这句话会出现2秒无效的情况
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (UIButton *)createBtnWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.footView addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromHex(0x0758EA) forState:UIControlStateNormal];
        btn.backgroundColor =UIColorFromHex(0xF6F6F6);
        btn.tag = tag;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    return button;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] || [touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return  YES;
}


- (NSMutableArray *)inpathArray
{
    if (_inpathArray == nil)
    {
        _inpathArray = [NSMutableArray array];
    }
    return _inpathArray;
}

#pragma mark tableview 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"TableViewCell";
    PromptChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    if (self.titleListArray.count > 0 ) {
        [cell setCellTitle:self.titleListArray indexPath:indexPath.row];
    }
    // 如果处于多选状态 找到选择的indexpath(滚动触发)
    if (self.inpathArray.count > 0) {
        for (NSNumber *number in self.inpathArray) {
            NSInteger index = [number integerValue];
            if (indexPath.row == index) {
                cell.titleLabel.textColor = [UIColor redColor];
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleListArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.style == PromptChooseViewStlyOrMultiSelect) {
        BOOL isExistence = [self.inpathArray containsObject:[NSNumber numberWithInteger:indexPath.row]];
        PromptChooseTableViewCell *cell = [_listTableView cellForRowAtIndexPath:indexPath];
        if (isExistence) {
            cell.titleLabel.textColor = UIColorFromHex(0x0758EA);
            [self.inpathArray removeObject:[NSNumber numberWithInteger:indexPath.row]];
        } else {
            cell.titleLabel.textColor = [UIColor redColor];
            [self.inpathArray addObject:[NSNumber numberWithInteger:indexPath.row]];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(refreshView:)])
        {
            [self.delegate refreshView:self.titleListArray[indexPath.row]];
            [self removeViewIsSelf];
        }
    }
}

//处理cell的线到头
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
