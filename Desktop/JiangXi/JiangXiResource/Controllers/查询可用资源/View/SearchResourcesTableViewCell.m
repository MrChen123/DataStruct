//
//  SearchResourcesTableViewCell.m
//  JiangXiResource
//
//  Created by xinjie on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "SearchResourcesTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Ext.h"

@interface SearchResourcesTableViewCell ()
@property(nonatomic , strong) UILabel *titleLabel;       // title
@property(nonatomic , strong) UIButton *rightBtn;       // 箭头按钮
@end

@implementation SearchResourcesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUi];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)createUi{
    self.titleLabel = [self createLabeltext:@""];
    self.titleLabel.numberOfLines = 0;
    
    self.rightBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"xiangxia"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:btn];
        btn;
    });

    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.right.equalTo(self.rightBtn.mas_left).offset(-10);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    

    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.centerY.equalTo(self.titleLabel);
    }];

}

- (void)setModel:(SearchResourcesListModel *)model{
    self.titleLabel.text = model.titleName;
}

-(UILabel *)createLabeltext:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = UIColorFromHex(0x666666);
    label.text = text;
    [self.contentView addSubview:label];
    return label;
}


@end
