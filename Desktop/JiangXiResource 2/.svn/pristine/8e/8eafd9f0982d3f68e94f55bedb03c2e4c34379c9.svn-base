//
//  AddressCell.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/30.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "AddressCell.h"
#import "ResourceModel.h"

@interface AddressCell ()
@property (nonatomic, strong) UILabel *label;       // 用于显示信息
@property (nonatomic, strong) UIButton *rightBtn;   // 向右的箭头按钮
@end

@implementation AddressCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self uiConfig];
    }
    return self;
}

- (void)setModel:(ResourceModel *)model AndIndex:(NSInteger)index
{
    // 用于label显示信息
    NSString *text = @"";
    if (index == 0) {
        // 原地址
        text = [NSString stringWithFormat:@"原地址:%@",[self convertText:model.originAddressName]];
        self.rightBtn.hidden = YES;
    } else if (index == 1) {
        // 新地址
        text = [NSString stringWithFormat:@"新地址:%@",[self convertText:model.addressName]];
        self.rightBtn.hidden = NO;
    } else if (index == 2) {
        // 原端口
        text = [NSString stringWithFormat:@"原端口:%@",[self convertText:model.originPortName]];
        self.rightBtn.hidden = YES;
    } else if (index == 3) {
        // 新端口
        text = [NSString stringWithFormat:@"新端口:%@",[self convertText:model.portName]];
        self.rightBtn.hidden = NO;
    } else if (index == 4) {
        // 更改原因
        text = [NSString stringWithFormat:@"更改原因:%@",[self convertText:model.changeReason]];
        self.rightBtn.hidden = NO;
    }
    
    // 设置label
    self.label.text = text;
    
}


// 因为model的text内容可能为nil，处理当nil时返回空串
- (NSString *)convertText:(NSString *)text
{
    if (text) {
        return text;
    }
    return @"";
}

#pragma mark -----------UI-----------
- (void)uiConfig
{
    self.label = ({
        UILabel *lab = [self createLabel];
        lab;
    });
    
    self.rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"right-arrow"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:btn];
        btn;
    });
    
    // 布局
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding));
        make.right.equalTo(self.rightBtn.mas_left).offset(kPadding);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(kPadding);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(50);
        make.centerY.equalTo(self.label);
    }];
}
@end
