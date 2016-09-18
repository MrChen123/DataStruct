//
//  AddressCell.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/30.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

/**
 *  用于其他信息展示
 */

#import "BaseCell.h"
#import "SearchResourcesListModel.h"

@class ResourceModel;

@interface AddressCell : BaseCell
/**
 *  用于文字显示
 *
 *  @param Model   model
 *  @param index   index
 */
- (void)setModel:(ResourceModel *)model AndIndex:(NSInteger)index;

@end
