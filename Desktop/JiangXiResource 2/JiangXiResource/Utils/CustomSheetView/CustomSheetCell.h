//
//  CustomSheetCell.h
//  CustomSheetDemo
//
//  Created by 信辉科技 on 16/8/18.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomModel.h"
@interface CustomSheetCell : UITableViewCell
/**
 *  cell是否选中了
 */
@property (nonatomic, assign) BOOL cellSelect;
/**
 *  填充数据
 *
 *  @param model      文字信息
 *  @param lineBreak 是否允许换行
 */
- (void)fillCell:(CustomModel *)model lineBreak:(BOOL)lineBreak;
@end
