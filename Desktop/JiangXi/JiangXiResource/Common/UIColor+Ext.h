//
//  CommonLogic.h
//  NTSociety
//
//  Created by retygu on 14-8-19.
//  Copyright (c) 2014年 rety gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Ext)

UIColor* UIColorFromHex(NSInteger colorInHex);

/**
 * 根据 RGB 获取颜色值
 */
+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;

+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B withAlhpa:(CGFloat)alpha;

@end
