
//
//  CommonLogic.h
//  NTSociety
//
//  Created by retygu on 14-8-19.
//  Copyright (c) 2014年 rety gu. All rights reserved.
//


#import "UIColor+Ext.h"

@implementation UIColor (Ext)

UIColor* UIColorFromHex(NSInteger colorInHex) {
    // colorInHex should be value like 0xFFFFFF
    return [UIColor colorWithRed:((float) ((colorInHex & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((colorInHex & 0xFF00)   >> 8))  / 0xFF
                            blue:((float)  (colorInHex & 0xFF))            / 0xFF
                           alpha:1.0];
}

+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B {
    UIColor *color = [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:1.f];
    return color;
}

+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B withAlhpa:(CGFloat)alpha {
    UIColor *color = [self colorWithR:R/255.f G:G/255.f B:B/255.f withAlhpa:alpha];
    return color;
}

@end
