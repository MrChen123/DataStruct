//
//  HistorySearchModel.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/2.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

/**
 *  历史记录页面请求的参数
 */

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, request) {
    requestThreeDays = 0,       // 最近三天
    requestOneWeek,             // 最近一周
    requestToday,               // 今天的记录
};

@interface HistorySearchModel : BaseModel
@property (nonatomic, copy) NSString *account;          // 宽带账号
@property (nonatomic, copy) NSString *person;           // 装维系统账号
@property (nonatomic, assign) NSInteger requestDay;     // 请求天数(今天，3天，一周)
@property (nonatomic, assign) NSInteger currentPage;    // 请求页数
@end
