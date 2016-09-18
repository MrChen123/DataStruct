//
//  CustomSheet.h
//  CustomSheetDemo
//
//  Created by 信辉科技 on 16/8/18.
//  Copyright © 2016年 One. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSheetDelegate <NSObject>
/**
 *  代理返回数据
 *
 *  @param dataArray 选中结果
 */
- (void)resultValue:(NSArray *)dataArray;
/**
 *  上拉下拉刷新
 */
- (void)refresh:(BOOL)isHeader;
@end

@interface CustomSheet : UIView
/**
*  初始化方法
*
*  @param dataArray     用于actionSheet展示的数据
*  @param maxCount      显示最大个数，如果不足该个数的话，显示当前总个数
*  @param allowMultiple 是否允许多选
*  @param btnTitles     用于按钮的title
*  @param title         标题栏title
*  @param lineBreak     是否允许你换行
*  @param canRequest    是否可以上下拉刷新数据
*
*  @return CustomSheet对象
*/
- (instancetype)initWithDataArray:(NSMutableArray *)dataArray
                         maxCount:(NSInteger)maxCount
                    allowMultiple:(BOOL)allowMultiple
                        btnTitles:(NSArray *)btnTitles
                            title:(NSString *)title
                        lineBreak:(BOOL)lineBreak
                       canRequest:(BOOL)canRequest;
/**
 *   显示
 */
- (void)show;
@property (nonatomic, weak) id<CustomSheetDelegate> delegate;
- (void)refreshData:(NSMutableArray *)dataArray;
@end
