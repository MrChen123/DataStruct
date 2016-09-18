//
//  SearchResourcesPortView.h
//  JiangXiResource
//
//  Created by xinjie on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, SearchResourcesPortViewBtnTag) {
    FreePortBtnTag,                 // 空闲端口
    AllPortBtnTag,                  // 全部端口
    TitleBackViewTag,                // titleBackView手势
};

@protocol SearchResourcesPortViewDelegate <NSObject>

/**
 *  点击cell触发 
 *
 *  @param dataDic 端口信息
 */

- (void)searchResourcesPortViewSelectedCell:(NSDictionary *)dataDic;

/**
 *  点击空闲端口 全部端口 按钮 或者 TitleBackView的手势触发
 *
 *  @param btnTag SearchResourcesPortViewBtnTag 区分触发者
 */
- (void)searchResourcesPortViewBtnClick:(SearchResourcesPortViewBtnTag)btnTag;

@end


@interface SearchResourcesPortView : UIView
/**
 *  titleLabel值 （设备名称）
 */
@property (nonatomic , strong) NSString *string;
@property (nonatomic , weak) id<SearchResourcesPortViewDelegate>delegate;
/**
 *  端口信息数组
 */
@property (nonatomic , strong) NSMutableArray *portListArray;

@end



