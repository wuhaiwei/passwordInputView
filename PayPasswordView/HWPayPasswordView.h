//
//  HWPayPasswordView.h
//  PayPasswordView
//
//  Created by  wuhiwi on 16/8/22.
//  Copyright © 2016年 wanglibank. All rights reserved.
//
/**
 *  第二种方式创建 密码输入框View
 */
#import <UIKit/UIKit.h>

@interface HWPayPasswordView : UIView

@property (nonatomic, strong) void(^passwordBlock)(NSString *password);
/**
 *  elementCount 显示框的个数，默认最少是5个
 */
@property (nonatomic, assign) UInt8 elementCount;
/**
 *  默认是黑色的
 */
@property (nonatomic, strong) UIColor *lineColor;


/**
 *  清除密码框
 */
- (void)clearPassword;

@end
