//
//  StandardAddressVC.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, addressType){
    addressTypeSearch,              // 查询设备
    addressTypeChange,              // 更改地址
};

@interface StandardAddressVC : BaseViewController
/**
 *  页面类型
 */
@property (nonatomic, assign) addressType type;
/**
 *  如果新端口已有值，则根据新端口关联的设备自动带出满足条件的标准地址。
 *  如果新端口无值，则自己输入关键值查询
 */
@property (nonatomic, copy) NSString *portNewValue;
/**
 *  所属区县
 */
@property (nonatomic, copy) NSString *region;
/**
 *  回调函数
 */
@property (nonatomic, copy) void(^addressCallBack)(NSMutableDictionary *);
@end
