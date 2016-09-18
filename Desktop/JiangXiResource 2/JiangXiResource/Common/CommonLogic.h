//
//  CommonLogic.h
//  JiangXiResource
//
//  Created by 信辉科技 on 16/9/1.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

/**
 *  工具类
 */

#import <Foundation/Foundation.h>

@interface CommonLogic : NSObject
/**
 *  提示错误信息
 *
 *  @param info 错误信息
 */
+ (void)showPromptInfo:(NSString *)info;

/**
 *  判断是否为特殊字符
 *
 *  @param str  string
 *
 *  @return BOOL YES 存在
 */
+ (BOOL)isSpecialCharacter:(NSString *)str;

/**
 *  判断是否为中文
 *
 *  @param str string
 *
 *  @return YES 是
 */
+ (BOOL)isChinese:(NSString *)str;

/**
 *  判断字典中是否存在 key
 *
 *  @param dic  字典
 *  @param info key
 *
 *  @return BOOL YES存在
 */
+ (BOOL)isExistence:(NSDictionary *)dic AndInfo:(NSString *)info;

/**
 *  清除字符串前后空格
 *
 *  @param str string
 *
 *  @return 清除后的str
 */
+ (NSString *)formatStrTrim:(NSString *)str;

/**
 *  字符串拼接 , 号
 *
 *  @param array 字符串数组
 *
 *  @return 拼接好的字符串
 */
+ (NSString *)appendingString:(NSArray *)array;

/**
 *  将json字符串转换为字典
 *
 *  @param jsonStr json字符串
 *
 *  @return 字典
 */
+ (NSDictionary *)convertToDict:(NSString *)jsonStr;
@end