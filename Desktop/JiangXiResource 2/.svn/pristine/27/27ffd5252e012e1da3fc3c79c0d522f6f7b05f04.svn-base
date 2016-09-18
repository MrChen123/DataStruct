//
//  PromptChooseView.h
//  JiangXiResource
//
//  Created by xinjie on 16/8/29.
//  Copyright © 2016年 sinceretech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, PromptChooseViewButtonTag) {
    PromptChooseViewCancelButtonTag,    // 取消按钮
    PromptChooseViewSureButtonTag,      // 确定绑定
    PromptChooseViewRemoveButtonTag     // 清除按钮
};

typedef NS_ENUM(NSUInteger, PromptChooseViewStyle) {
    PromptChooseViewStlyOrNone,         //只有取消功能
    PromptChooseViewStlyOrClean,        // 取消功能 加清除功能
    PromptChooseViewStlyOrMultiSelect   // 支持多选 确认 取消
};

@protocol ChatViewPromptChooseViewDelegate <NSObject>
- (void)refreshView:(id)value;
@end


@interface PromptChooseView : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic , assign) id<ChatViewPromptChooseViewDelegate>delegate;
@property (nonatomic , assign) PromptChooseViewStyle style;
- (void)setListArray:(NSArray *)array;

@end
