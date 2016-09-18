//
//  XhNetWorking.m
//  JiangXiResource
//
//  Created by xinjie on 16/9/2.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "XhNetWorking.h"
#import "YTKRequest.h"
#import <AFNetworking/AFURLRequestSerialization.h>

// 下载文件类
@interface DowlodRequest : YTKRequest

@property (nonatomic , copy) NSString *url;
@property (nonatomic , assign) YTKRequestMethod method;

@end

@implementation DowlodRequest

- (instancetype)initWithUrl:(NSString *)url
                        tag:(NSInteger)requestTag
              requestMethod:(YTKRequestMethod)method
{
    self = [super init];
    
    if (self) {
        self.url = url;
        self.tag = requestTag;
        self.method = method;
    }
    return self;
}

/**
 *  请求方式
 *
 *  @return YTKRequestMethod
 */
- (YTKRequestMethod)requestMethod
{
    return self.method;
}

/**
 *  url
 *
 *  @return url
 */
- (NSString *)requestUrl
{
    return self.url;
}

- (BOOL)useCDN {
    return YES;
}


// 开启断点续传功能时需要

  // 当需要断点续传时，指定续传的地址
//- (NSString *)resumableDownloadPath {
//    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *cachePath = [libPath stringByAppendingPathComponent:@"Caches"];
//    NSString *filePath = [cachePath stringByAppendingPathComponent:@"image123"];
//    return filePath;
//}

// // 当需要断点续传时，获得下载进度的回调
//- (AFURLSessionTaskProgressBlock)resumableDownloadProgressBlock{
//    AFURLSessionTaskProgressBlock block = ^(NSProgress *progress){
//        NSLog(@"---->%@",progress);
//    };
//    return block;
//}

@end


@interface XhNetWorking ()

@property (nonatomic , copy) NSString *url;
@property (nonatomic , copy) NSString *imageName;
@property (nonatomic , strong) NSDictionary *params;
@property (nonatomic , assign) YTKRequestMethod method;
@property (nonatomic , strong) UIImage *image;
@property (nonatomic , assign) BOOL useCDN;

@end

@implementation XhNetWorking

- (instancetype)initWithUrl:(NSString *)url
                     params:(NSMutableDictionary *)params
                        tag:(NSInteger)requestTag
              requestMethod:(YTKRequestMethod)method
{
    self = [super init];
    
    if (self) {
        self.url = url;
        self.params = params;
        self.tag = requestTag;
        self.method = method;
    }
    return self;
}

// 上传图片使用的init方法
- (instancetype)initWithUrl:(NSString *)url
                     params:(NSMutableDictionary *)params
                        tag:(NSInteger)requestTag
                      image:(UIImage *)image
                    imageName:(NSString *)imageName
{
    self = [super init];
    
    if (self) {
        self.url = url;
        self.params = params;
        self.tag = requestTag;
        self.imageName = imageName;
        self.image = image;
        self.method = YTKRequestMethodPOST;
    }
    return self;
}



/**
 *  请求方式
 *
 *  @return YTKRequestMethod
 */
- (YTKRequestMethod)requestMethod
{
    return self.method;
}

/**
 *  url
 *
 *  @return url
 */
- (NSString *)requestUrl
{
    return self.url;
}

/**
 *  需要传的字典参数
 *
 *  @return 参数
 */
- (id)requestArgument
{
    return self.params;
}

// 上传图片
- (AFConstructingBlock)constructingBodyBlock {
    if (self.image) {
        return ^(id<AFMultipartFormData> formData) {
            NSData *imageData = UIImageJPEGRepresentation(self.image, 0.9);
            NSString *formKey = @"file";
            NSString *type = @"image/jpeg";
            [formData appendPartWithFileData:imageData name:formKey fileName:self.imageName mimeType:type];
        };
    } else {
        return nil;
    }
}


#pragma mark 请求方法

+ (instancetype)requestUrl:(NSString *)url
                    params:(NSMutableDictionary *)params
                       tag:(NSInteger)requestTag{
    
    return [self requestUrl:url
                     params:params
                        tag:requestTag
              requestMethod:YTKRequestMethodPOST];
}


+ (instancetype)requestUrl:(NSString *)url
                    params:(NSMutableDictionary *)params
                       tag:(NSInteger)requestTag
             requestMethod:(YTKRequestMethod)method{
    
    XhNetWorking *request = [[XhNetWorking alloc] initWithUrl:url
                                                       params:params
                                                          tag:requestTag
                                                requestMethod:method];
    return request;
}

+ (instancetype)uploadRequestUrl:(NSString *)url
                    params:(NSMutableDictionary *)params
                       tag:(NSInteger)requestTag
                     image:(UIImage *)image
                 imageName:(NSString *)imageName{
    
    XhNetWorking *request = [[XhNetWorking alloc] initWithUrl:url
                                                       params:params
                                                          tag:requestTag
                                                        image:image
                                                    imageName:imageName];
    return request;
}

+ (instancetype)downloadRequestUrl:(NSString *)url
                               tag:(NSInteger)requestTag{
    DowlodRequest *working = [[DowlodRequest alloc] initWithUrl:url tag:requestTag requestMethod:YTKRequestMethodGET];
    XhNetWorking *request = (XhNetWorking *)working;
    return request;
}


@end
