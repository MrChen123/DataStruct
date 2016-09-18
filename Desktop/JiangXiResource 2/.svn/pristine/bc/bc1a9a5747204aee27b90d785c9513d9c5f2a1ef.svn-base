//
//  CommonLogic.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "CommonLogic.h"
#import "STTextHudTool.h"

@implementation CommonLogic
+ (void)showPromptInfo:(NSString *)info
{
    [STTextHudTool showText:info];
}

+ (BOOL)isSpecialCharacter:(NSString *)str{
    
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [str rangeOfCharacterFromSet:nameCharacters];
    // 存在特殊字符
    if (userNameRange.location != NSNotFound) {
        return YES;
    }
    // 不存在特殊字符
    return NO;
}

+ (BOOL)isChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        // 中文区间
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isExistence:(NSDictionary *)dic AndInfo:(NSString *)info{
    // 拿到所以的key
    NSArray *keyArray = [dic allKeys];
    // 判断是否存在points数组  如果存在则表示是线段  如果不存在则是资源点
    BOOL isExistence = [keyArray containsObject:info];
    if (isExistence) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)formatStrTrim:(NSString *)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)appendingString:(NSArray *)array{
    NSString *newStr = @"";
    for (NSInteger index = 0; index < array.count; index++) {
        if (index == array.count - 1) {
            newStr = [newStr stringByAppendingString:[NSString stringWithFormat:@"%@",array[index]]];
        }else{
            newStr = [newStr stringByAppendingString:[NSString stringWithFormat:@"%@,",array[index]]];
        }
    }
    return newStr;
}

+ (NSDictionary *)convertToDict:(NSString *)jsonStr
{
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return dict;
}

@end

