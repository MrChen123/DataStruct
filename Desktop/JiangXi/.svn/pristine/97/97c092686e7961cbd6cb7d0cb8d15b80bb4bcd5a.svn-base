//
//  CommonDefine.h
//  SilkStreet
//
//  Created by retygu on 14-9-3.
//  Copyright (c) 2014年 retygu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceDefine.h"

// 通过宏定义获取服务器路径
//#define PRE_URL                 @"http://192.168.101.162:8030/irm/"       // 赵强本地
#define PRE_URL                 @"http://192.168.120.205:7011/irmds/"       // 上海分支
//#define PRE_URL                 @"http://192.168.120.214:7009/irmds/"   // 云南分支

// 百度地图
#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

// 蒲公英使用AppID,用于检测更新
#define PGY_AppID               @"6d987cf5a738ce686a4482f1a39e673f"

// 友盟退送相关
#define UmenAppKey              @"57a012e8e0f55a2b14000c64"
#define UmenppMasterSecret      @"3s7mvlmkmmjgf5erc5ccvq0vjkzpu20m"

// 登录使用信息
#define IS_LOGIN                @"is_login"          // 是否登录成功
#define is_Remind               @"is_remind"         // 是否提醒手势
#define user_info               @"user_info"
#define user_token              @"user_token"
#define Login_name              @"login_name"
#define Preview_User            @"preview_user"      // 上一个用户
#define user_password           @"user_password"
#define DEVICE_TOKEN            @"deviceToken"

// 获取Token值
#define Token      [[NSUserDefaults standardUserDefaults] objectForKey:user_token]

// 主题颜色
#define THEME_COLOR [UIColor colorWithRed:55/255.0f green:143/255.0f blue:245/255.0f alpha:1.0f]

// 判断真机还是模拟器
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

// 其他定义（系统版本，颜色等等）
#define WeakSelf __weak typeof(self) weakSelf = self

#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7
#define sys_version_ForiOS7  ( [[[UIDevice currentDevice]  systemVersion] floatValue] >= 7.0)
#define SYSTEM_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define LINE_BORDER_WIDTH 1.0
#define scale_width [[UIScreen mainScreen] bounds].size.width/320
#define scale_height [[UIScreen mainScreen] bounds].size.height/568

#define system_color [UIColor colorWithRed:253/255.0f green:95/255.0f blue:232/255.0f alpha:1.0f]
#define login_tf_bgcolor [UIColor colorWithRed:214/255.0 green:213/255.0 blue:204/255.0 alpha:1.0]
#define black_color_36 [UIColor colorWithRed:36/255.0f green:36/255.0f blue:36/255.0f alpha:1.0f]
#define black_color_51 [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f]
#define black_color_102 [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f]
#define black_color_210 [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1.0f]
#define black_color_245 [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f]
#define background_color_242 [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]