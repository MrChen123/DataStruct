//
//  SearchResourcesViewController.h
//  JiangXiResource
//
//  Created by xinjie on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResourcesViewController : BaseViewController

/**
 *  回调方法 端口选择完成 返回上一层界面 讲端口名等参数带到上级页面
 *  @param NSDictionary 端口信息
 */
@property (nonatomic, copy) void(^searchResourcesViewCallBack)(NSDictionary *);

@end
