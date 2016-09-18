//
//  ResourceModel.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

/**
 *  查询产品配置信息-接口输出
 */

#import "BaseModel.h"

@interface ResourceModel : BaseModel
@property (nonatomic, copy) NSString *accountName;            // 宽带账号
@property (nonatomic, copy) NSString *userName;               // 用户姓名（保留第一个字，后面的用星号代替）
@property (nonatomic, copy) NSString *way;                    // 接入方式
@property (nonatomic, copy) NSString *workOrderNum;           // 配置工单编号（最新的）
@property (nonatomic, copy) NSString *workOrderID;            // 配置工单ID
@property (nonatomic, copy) NSString *orderNum;               // 订单编号(最新的)
@property (nonatomic, copy) NSString *orderStatus;            // 订单状态(最新的)
@property (nonatomic, copy) NSString *originAddressName;      // 原地址名称
@property (nonatomic, copy) NSString *originAddressID;        // 原地址ID
@property (nonatomic, copy) NSString *addressName;            // 新地址名称
@property (nonatomic, copy) NSString *addressID;              // 新地址ID
@property (nonatomic, copy) NSString *originPortName;         // 原端口名称
@property (nonatomic, copy) NSString *originPortID;           // 原端口ID
@property (nonatomic, copy) NSString *portName;               // 新端口名称
@property (nonatomic, copy) NSString *portID;                 // 新端口ID
@property (nonatomic, copy) NSString *ponID;                  // PON口ID
@property (nonatomic, copy) NSString *oltID;                  // OLT设备ID
@property (nonatomic, copy) NSString *activeStatus;           // 激活结果
@property (nonatomic, copy) NSString *changeReason;           // 更改原因
@end
