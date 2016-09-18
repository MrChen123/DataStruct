//
//  CustomSheetCell.m
//  CustomSheetDemo
//
//  Created by 信辉科技 on 16/8/18.
//  Copyright © 2016年 One. All rights reserved.
//

#import "CustomSheetCell.h"
#import "Masonry.h"
#import "UIColor+Ext.h"

#define kPadding 5

@interface CustomSheetCell ()
@property (nonatomic, strong) UILabel *nameLabel;       // 显示详细信息Label
@end

@implementation CustomSheetCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig
{
    self.nameLabel = ({
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = UIColorFromHex(0x0758EA);
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding));
        }];
        label;
    });
}

- (void)fillCell:(CustomModel *)model lineBreak:(BOOL)lineBreak
{
    if (lineBreak) {
        self.nameLabel.numberOfLines = 0;
    }
    self.nameLabel.text = model.text;
}

- (void)setCellSelect:(BOOL)select
{
    _cellSelect = select;
    if (select) {
        self.nameLabel.textColor = [UIColor redColor];
    } else {
        self.nameLabel.textColor = UIColorFromHex(0x0758EA);
    }
}

@end
