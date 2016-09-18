//
//  BaseViewController.m
//  JiangXiResource
//
//  Created by 信辉科技 on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeTop;
    }
    
    // 返回按钮样式变更
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitle:(NSString *)title
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160*scale_width, 44*scale_height)];
    titleView.autoresizesSubviews = YES;
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160*scale_width, 44*scale_height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17*scale_width];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    //表示行数
    titleLabel.numberOfLines = 0;
    titleLabel.text = title;
    // Add as the nav bar's titleview
    [titleView addSubview:titleLabel];
    
    // 设置titleView
    self.navigationItem.titleView = titleView;
}

- (NSString *)convertToJsonString:(NSMutableDictionary *)dict
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    return  [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
}

@end
