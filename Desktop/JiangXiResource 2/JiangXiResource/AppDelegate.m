//
//  AppDelegate.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "AppDelegate.h"
#import "ResourceMainVC.h"
#import "YTKNetworkConfig.h"
#import "YTKNetworkAgent.h"
#import "CommonDefine.h"
#import "CommonLogic.h"
#import "XhNetWorking.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // com.sinceretech.JiangXiResource
    // 测试 com.xinhui.JiangXiResource
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 设置主视图
    ResourceMainVC *mainVC = [[ResourceMainVC alloc] init];
    mainVC.paramsDict = @{@"accountName": @"chen123",
                          @"region": @"南昌县",
                          @"appAccount": @"123",
                          @"name": @"chen",
                          @"cellPhone": @"110"};
    
    // 设置导航栏属性
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"naviBack"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    // 服务器端配置
    [self baseUrlConfig];
    [self loadData];
    
    return YES;
}

- (void)baseUrlConfig
{
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    
    //AFNet支持Https 测试环境下忽略https证书。。
    [agent setValue:@YES forKeyPath:@"_manager.securityPolicy.allowInvalidCertificates"];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = PRE_URL;
}


- (void)loadData{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:@"wuxinjie" forKey:@"username"];
    [parameters setObject:@"asb123" forKey:@"password"];
    [parameters setObject:[NSNumber numberWithBool:true] forKey:@"needPassword"];
    if (!SIMULATOR) {
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:DEVICE_TOKEN];
        if (token != nil) {
            [parameters setObject:token forKey:@"deviceToken"];
        } else {
            [parameters setObject:@"2," forKey:@"deviceToken"];
        }
    }
    // 字典转json
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    // josn数据存入字典
    NSMutableDictionary *dicts = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicts setValue:jsonString forKey:@"params"];
    
    XhNetWorking *request = [XhNetWorking requestUrl:Login params:dicts tag:0];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *dataDic = request.responseJSONObject;
        int state = [dataDic[@"status"] intValue];
        // 请求成功
        if (state == 1) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[dataDic valueForKey:@"json"]];
            
            NSLog(@"%@",dic);
            NSArray *valueArray=[dic allKeys];
            for (NSString *key in valueArray) {
                if ([[dic valueForKey:key] isKindOfClass:[NSNull class]]) {
                    [dic setObject:@"暂无" forKey:key];
                }
            }
            // 记录用户信息 记录登陆状态
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
            [[NSUserDefaults standardUserDefaults] setValue:dic forKey:user_info];
            [[NSUserDefaults standardUserDefaults] setValue:[dataDic valueForKey:@"token"] forKey:user_token];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSString *errorInfo = [request.error localizedDescription];
        NSLog(@"error---> %@", errorInfo);
        [CommonLogic showPromptInfo:@"请求失败，请稍后重试!"];
    }];

}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    /**
     * 先调用openUrl信息，然后再调用didFinishLaunchingWithOptions
     */
    NSLog(@"%@", [url host]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
