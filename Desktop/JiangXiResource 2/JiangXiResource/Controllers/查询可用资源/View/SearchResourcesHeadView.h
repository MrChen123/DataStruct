//
//  SearchResourcesHeadView.h
//  JiangXiResource
//
//  Created by xinjie on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, SearchResourcesHeadViewBtnTag) {
    QRCodeBtnTag,               // 二维码扫码
    EquipmentBtnTag,            // 设备查询
    AddressBtnTag,              // 地址查询
    OldEquipmentCodeBtnTag,     // 原设备查询
    OldAddressBtnTag            // 原地址查询
};

@protocol SearchResourcesHeadViewDelegate <NSObject>
/**
 *  代理方法。用于 扫码 设备查询 地址查询等 按钮的点击事件
 */

- (void)searchResourcesHeadViewBtnClick:(SearchResourcesHeadViewBtnTag)btnTag;

@end

@interface SearchResourcesHeadView : UIView

@property (nonatomic , weak) id<SearchResourcesHeadViewDelegate>delegate;
/**
 *   设置SegmentedControl的选中按钮
 */
- (void)setSegmentedControlSelectedSegmentIndex;

@end
