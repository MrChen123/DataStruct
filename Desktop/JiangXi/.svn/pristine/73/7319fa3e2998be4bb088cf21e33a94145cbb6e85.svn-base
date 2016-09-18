//
//  PromptChooseTableViewCell.m
//  JiangXiResource
//
//  Created by xinjie on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "PromptChooseTableViewCell.h"
#import "UIColor+Ext.h"
#import "CommonDefine.h"
#import <Masonry/Masonry.h>

@implementation PromptChooseTableViewCell

- (void)setCellTitle:(NSArray *)titleArray indexPath:(NSInteger )indexpath{
    
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = UIColorFromHex(0x0758EA);
        label.text = titleArray[indexpath];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = UIColorFromHex(0xF6F6F6);
        label;
    });
    [self.contentView addSubview:_titleLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
