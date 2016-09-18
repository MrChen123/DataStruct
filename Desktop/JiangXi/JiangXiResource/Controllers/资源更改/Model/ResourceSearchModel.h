//
//  ResourceSearchModel.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/30.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

/**
 *  查询产品配置信息-接口输入
 */

#import "BaseModel.h"

@interface ResourceSearchModel : BaseModel
@property (nonatomic, copy) NSString *accountName;          // 宽带账号
@property (nonatomic, copy) NSString *region;               // 所属区县
@property (nonatomic, copy) NSString *appAccount;           // 装维手机APP账号
@property (nonatomic, copy) NSString *name;                 // 装维人员姓名
@property (nonatomic, copy) NSString *cellPhone;            // 装维人员手机号
@end
