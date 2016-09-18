//
//  SearchEquipmentHeadView.h
//  JiangXiResource
//
//  Created by xinjie on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TapViewTag) {
    CityBackViewTag,            // 所属区县
    EquipmentBackViewTag,       // 选择设备
};

@protocol SearchEquipmentHeadViewDelegate <NSObject>
/**
 *  展示选择框
 *
 *  @param tag TapViewTag
 */
- (void)showPromptView:(TapViewTag)tag;

/**
 *  传递滑块的值
 *
 *  @param text 滑块值
 */
- (void)passSliderText:(NSString *)text;

@end

@interface SearchEquipmentHeadView : UIView

@property (nonatomic , weak) id<SearchEquipmentHeadViewDelegate>delegate;

/**
 *  改变cityNameLabel和equipmentNameLB的值
 *
 *  @param textString 改变的值
 *  @param tag        TapViewTag 对应label
 */
- (void)setTextString:(NSString *)textString TapViewTag:(TapViewTag)tag;

/**
 *  改变Silder的值 ，用于重置功能
 */
- (void)setSilderValue;

@end
