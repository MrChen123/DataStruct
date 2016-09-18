//
//  BaseCell.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/30.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Ext.h"
#import "Masonry.h"

// label与ContentView边距
#define kPadding 5

@interface BaseCell : UITableViewCell
/**
 *  model传入，用于布局
 */
@property (nonatomic, strong) id model;
/**
 *  文字传入
 */
@property (nonatomic, copy) NSString *text;
/**
 *  创建Label
 */
- (UILabel *)createLabel;
@end
