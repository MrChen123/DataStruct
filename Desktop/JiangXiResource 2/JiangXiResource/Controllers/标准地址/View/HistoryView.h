//
//  HistoryView.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/7.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

/**
 *   初次点击查询输入框，显示历史记录
 */

#import <UIKit/UIKit.h>

@interface HistoryView : UIView
/**
 *  历史记录数组
 */
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, copy) void(^select)(NSInteger);
@end
