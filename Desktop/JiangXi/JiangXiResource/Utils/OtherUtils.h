//
//  OtherUtils.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/2.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

/**
 *  其他辅助类
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OtherUtils : NSObject
/**
 *  创建自定义View
 *
 *  @param superView 父视图
 *  @param index     自定义view的tag
 *  @param title     文字信息
 *  @param hasBtn    是否有按钮显示
 *  @param hasLine   是否有分割线
 *  @param showInTop 是否显示在顶部
 *  @param targetLabel 传递的是引用，不是值
 *
 *  @return 自定义View
 */
+ (UIView *)createViewWithView:(UIView *)superView tag:(NSInteger)index title:(NSString *)title hasBtn:(BOOL)hasBtn hasLine:(BOOL)hasLine showInTop:(BOOL)showInTop targetLabel:(UILabel **)targetLabel;

@end
