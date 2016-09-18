//
//  BaseViewController.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"
#import "Masonry.h"
#import "UIColor+Ext.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "CommonLogic.h"
#import "XhNetWorking.h"

@interface BaseViewController : UIViewController
- (void)setTitle:(NSString *)title;
/**
 *  将字典转换为json字符串
 *
 *  @param dict 字典
 *
 *  @return json字符串
 */
- (NSString *)convertToJsonString:(NSMutableDictionary *)dict;
@end
