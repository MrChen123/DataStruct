//
//  SearchResourcesPortViewTableViewCell.m
//  JiangXiResource
//
//  Created by xinjie on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "SearchResourcesPortViewTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"

@interface SearchResourcesPortViewTableViewCell ()
@property(nonatomic , strong) UILabel *titleLabel;       // title
@end

@implementation SearchResourcesPortViewTableViewCell
- (void)layoutSubviews {
    //1. 执行 [super layoutSubviews];
    [super layoutSubviews];
    //2. 设置preferredMaxLayoutWidth: 多行label约束的完美解决
    self.titleLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
    //3. 设置preferredLayoutWidth后，需要再次执行 [super layoutSubviews];
    //其实在实际中这步不写，也不会出错，官方解释是说设置preferredLayoutWidth后需要重新计算并布局界面，所以这步最好执行
    [super layoutSubviews];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUi];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createUi{
    self.titleLabel = [self createLabeltext:@""];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
}

- (void)setModel:(SearchResourcesPortViewListModel *)model{
    self.titleLabel.text = model.titleName;
}

-(UILabel *)createLabeltext:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = UIColorFromHex(0x666666);
    label.text = text;
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    return label;
}

@end
