//
//  OtherUtils.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/2.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "OtherUtils.h"
#import "UIColor+Ext.h"
#import "Masonry.h"
#import "MyLabel.h"

#define kPadding 5

@implementation OtherUtils
+ (UIView *)createViewWithView:(UIView *)superView tag:(NSInteger)index title:(NSString *)title hasBtn:(BOOL)hasBtn hasLine:(BOOL)hasLine showInTop:(BOOL)showInTop targetLabel:(UILabel **)targetLabel
{
    UIView *view = ({
        UIView *mainView = [UIView new];
        mainView.tag = index;
        [superView addSubview:mainView];
        
        // 添加title信息
        UILabel *titleLabel = ({
            UILabel *label;
            // showInTop：label的对齐方式
            if (showInTop) {
                label = [MyLabel new];
                ((MyLabel *)label).verticalAlignment = VerticalAlignmentTop;
            } else {
                label = [UILabel new];
            }
            
            label.textColor = UIColorFromHex(0x0185ce);
            label.text = title;
            label.font = [UIFont systemFontOfSize:15];
            
            [mainView addSubview:label];
            
            label;
        });
        
        // 添加文字信息
        UILabel *label = ({
            UILabel *lab = [UILabel new];
            lab.numberOfLines = 0;
            lab.preferredMaxLayoutWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 65 - kPadding * 3;
            lab.lineBreakMode = NSLineBreakByCharWrapping;
            lab.font = [UIFont systemFontOfSize:15];
            lab.textColor = UIColorFromHex(0x666666);
            [mainView addSubview:lab];
            
            lab;
        });
        
        // 传给外部label使用
        *targetLabel = label;
        
        // 添加分割线
        UILabel *lineLabel;
        if (hasLine) {
            lineLabel = [UILabel new];
            lineLabel.backgroundColor = [UIColor lightGrayColor];
            [mainView addSubview:lineLabel];
        }
        
        // 添加按钮
        UIButton *btn;
        if (hasBtn) {
            btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.userInteractionEnabled = NO;
            [btn setImage:[UIImage imageNamed:@"right-arrow"] forState:UIControlStateNormal];
            [mainView addSubview:btn];
        }
        
        // 布局
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(mainView).insets(UIEdgeInsetsZero);
            make.left.equalTo(mainView).offset(kPadding);
            make.width.mas_equalTo(65);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(kPadding);
            make.centerY.equalTo(titleLabel);
            make.height.mas_equalTo(titleLabel.mas_height);
            if (hasBtn) {
                make.right.equalTo(btn.mas_left).offset(-kPadding);
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(mainView.mas_right).offset(kPadding);
                    make.height.mas_equalTo(30);
                    make.width.mas_equalTo(30);
                    make.centerY.equalTo(label);
                }];
            }
            if (hasLine) {
                [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.bottom.equalTo(mainView).insets(UIEdgeInsetsZero);
                    make.height.mas_equalTo(1);
                }];
            }
        }];
        
        MASAttachKeys(titleLabel, label, mainView);
        
        mainView;
    });
    
    return view;
}
@end
