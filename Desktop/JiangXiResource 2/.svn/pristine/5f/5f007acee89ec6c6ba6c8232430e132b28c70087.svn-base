//
//  SearchEquipmentFootView.h
//  JiangXiResource
//
//  Created by xinjie on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SearchEquipmentFootViewBtnTag) {
    ResetButtonTag,                 // 重置按钮
    SearchButtonTag,                // 查询按钮
};

@protocol SearchEquipmentFootViewDelegate <NSObject>

/**
 *  代理方法 
 *
 *  @param tag SearchEquipmentFootViewBtnTag 区分触发者
 */
- (void)searchEquipmentFootViewBtnClick:(SearchEquipmentFootViewBtnTag)tag;

@end

@interface SearchEquipmentFootView : UIView

@property (nonatomic , weak) id<SearchEquipmentFootViewDelegate>delegate;

@end
