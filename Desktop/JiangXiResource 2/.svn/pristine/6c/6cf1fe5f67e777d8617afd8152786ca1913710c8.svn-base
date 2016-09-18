//
//  MoreView.h
//  YunNanJK
//
//  Created by 信辉科技 on 16/7/22.
//  Copyright © 2016年 wuxinjie. All rights reserved.
//

/**
 *  右上角弹出视图
 */

#import <UIKit/UIKit.h>

@protocol MoreViewDelegate <NSObject>
- (void)clickItem:(NSInteger)index;// 点击了某个index，交由上个页面处理
@end

@interface MoreView : UIView
@property (nonatomic, strong) NSArray *titleArray;// 显示的信息
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, weak) id<MoreViewDelegate> delegate;// 代理
@end
