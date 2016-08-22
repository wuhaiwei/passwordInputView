//
//  PayPasswordView.h
//  PayPasswordView
//
//  Created by  wuhiwi on 16/8/22.
//  Copyright © 2016年 wanglibank. All rights reserved.
//
/**
 *  类似支付宝支付时的密码输入框 View
 */
#import <UIKit/UIKit.h>

@interface PayPasswordView : UIView

@property (nonatomic, strong) void(^passwordBlock)(NSString *password);
@property (nonatomic, assign) UInt8 elementCount;
@property (nonatomic, strong) UIColor *marginColor;
@property (nonatomic, assign) UInt8 elementMargin;


/**
 *  清空密码框
 */
- (void)clearText;

@end
