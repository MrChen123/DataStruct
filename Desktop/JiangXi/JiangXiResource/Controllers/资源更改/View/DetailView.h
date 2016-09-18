//
//  DetailView.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/31.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResourceModel;

typedef NS_ENUM(NSInteger, clickType) {
    clickTypeNewAddress = 1,        // 新地址
    clickTypeNewPort = 3,           // 新端口
    clickTypeNewReason = 4          // 更改原因
};

@protocol DetailDelegate <NSObject>
/**
 *  点击右侧箭头，跳转或者显示信息
 *
 *  @param type  clickType
 */
- (void)detailInfo:(clickType)type;
@end

@interface DetailView : UIView
@property (nonatomic, strong) ResourceModel *model;
@property (nonatomic, weak) id<DetailDelegate> delegate;
@end
