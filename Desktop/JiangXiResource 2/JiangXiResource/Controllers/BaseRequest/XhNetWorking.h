//
//  XhNetWorking.h
//  JiangXiResource
//
//  Created by xinjie on 16/9/2.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YTKRequest.h"

@interface XhNetWorking : YTKRequest


/**
 *  请求
 *
 *  @param url        url
 *  @param params     params
 *  @param requestTag tag值
 *  @param method     post/get
 *
 *  @return   YTKRequest
 */
+ (instancetype)requestUrl:(NSString *)url
                    params:(NSMutableDictionary *)params
                       tag:(NSInteger)requestTag;

/**
 *  请求
 *
 *  @param url        url
 *  @param params     params
 *  @param requestTag tag值
 *  @param method     post/get
 *
 *  @return   YTKRequest
 */
+ (instancetype)requestUrl:(NSString *)url
                    params:(NSMutableDictionary *)params
                       tag:(NSInteger)requestTag
             requestMethod:(YTKRequestMethod)method;

/**
 *  上传图片
 *
 *  @param url        url
 *  @param params     params
 *  @param requestTag tag值
 *  @param image      图片
 *  @param imageName  imageName
 *
 *  @return   YTKRequest
 */
+ (instancetype)uploadRequestUrl:(NSString *)url
                    params:(NSMutableDictionary *)params
                       tag:(NSInteger)requestTag
                     image:(UIImage *)image
                 imageName:(NSString *)imageName;

/**
 *  下载文件
 *
 *  @param url        url地址
 *  @param requestTag requestTag
 *
 *  @return YTKRequest
 */
+ (instancetype)downloadRequestUrl:(NSString *)url
                       tag:(NSInteger)requestTag;


@end
