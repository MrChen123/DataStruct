//
//  ResourceHistoryCell.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "ResourceHistoryCell.h"
#import "OtherUtils.h"
#import "UIView+LJC.h"
#import "ResourceHistoryModel.h"

@interface ResourceHistoryCell ()
@property (nonatomic, strong) UILabel *accountLabel;                // 宽带账号
@property (nonatomic, strong) UILabel *timeLabel;                   // 提交时间
@property (nonatomic, strong) UILabel *addressLabel;                // 装机地址
@property (nonatomic, strong) UILabel *activeStatusLabel;           // 激活结果
@end

@implementation ResourceHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

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

- (void)setModel:(ResourceHistoryModel *)model
{
    super.model = model;
    
    self.accountLabel.text = model.account;
    self.timeLabel.text = model.time;
    self.addressLabel.text = model.address;
    self.activeStatusLabel.text = model.activeStatus;
    self.activeStatusLabel.textColor = [UIColor blueColor];
}

#pragma mark -----------UI-----------
- (void)uiConfig
{
    NSArray *titles = @[@"宽带账号:",
                        @"提交时间:",
                        @"装机地址:",
                        @"激活结果:"];
    
    UILabel *label1;
    UIView *view1 = [OtherUtils createViewWithView:self.contentView tag:0 title:titles[0] hasBtn:NO hasLine:NO showInTop:YES targetLabel:&label1];
    self.accountLabel = label1;
 
    UILabel *label2;
    UIView *view2 = [OtherUtils createViewWithView:self.contentView tag:0 title:titles[1] hasBtn:NO hasLine:NO showInTop:YES targetLabel:&label2];
    self.timeLabel = label2;
    
    UILabel *label3;
    UIView *view3 = [OtherUtils createViewWithView:self.contentView tag:0 title:titles[2] hasBtn:NO hasLine:NO showInTop:YES targetLabel:&label3];
    self.addressLabel = label3;
    
    UILabel *label4;
    UIView *view4 = [OtherUtils createViewWithView:self.contentView tag:0 title:titles[3] hasBtn:NO hasLine:NO showInTop:YES targetLabel:&label4];
    self.activeStatusLabel = label4;
    
    NSArray *views = @[view1, view2, view3, view4];
    
    // 布局
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).insets(UIEdgeInsetsZero);
    }];
    
    // 竖直方向上间距固定，大小不固定
    [self.contentView distributeSpacingVerticallyWith:views];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(2);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom).offset(2);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom).offset(2);
    }];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).offset(2);
    }];
    
}

@end
