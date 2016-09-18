//
//  CustomModel.m
//  CustomSheet
//
//  Created by 信辉科技 on 16/9/6.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "CustomModel.h"

@implementation CustomModel
+ (instancetype)setModelWithText:(NSString *)text lineBreak:(BOOL)lineBreak
{
    CustomModel *model = [[CustomModel alloc] init];
    model.text = text;
    if (lineBreak) {
        CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10 * 2 - 5 * 2;
        model.height = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height + 10 * 2;
    } else {
        model.height = 40;
    }
    return model;
}
@end
