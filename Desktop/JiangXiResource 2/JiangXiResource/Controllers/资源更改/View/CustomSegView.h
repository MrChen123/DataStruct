//
//  CustomSegView.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/30.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSegViewDelegate <NSObject>
- (void)clickSegItem:(NSInteger)index;// 点了复选框的选项
@end

@interface CustomSegView : UIView
/**
 *  用于按钮显示的信息
 */
@property (nonatomic, strong) NSArray *titleArray;
/**
 *  用于选中和未选中进行区分
 */
@property (nonatomic, assign) BOOL isDifferent;
/**
 *  用于默认进来是否有选中效果
 */
@property (nonatomic, assign) BOOL notHasSelect;
/**
 *  代理，用于按钮点击
 */
@property (nonatomic, weak) id<CustomSegViewDelegate> delegate;
/**
 *  上层滑动视图，分段选择器也跟着变化（用于有多个界面的时候）
 *
 *  @param index index
 */
- (void)scrollToIndex:(NSInteger)index;
/**
 *  更新title信息
 *
 *  @param title 新的title
 *  @param index 修改的位置
 */
- (void)refreshTitle:(NSString *)title WithIndex:(NSInteger)index;
@end
