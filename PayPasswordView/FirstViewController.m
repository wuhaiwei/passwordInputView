//
//  FirstViewController.m
//  PayPasswordView
//
//  Created by  wuhiwi on 16/8/22.
//  Copyright © 2016年 wanglibank. All rights reserved.
//

#import "FirstViewController.h"
#import "PayPasswordView.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    CGFloat width = self.view.bounds.size.width;
    PayPasswordView *payPasswordView = [[PayPasswordView alloc] init];
    payPasswordView.frame = CGRectMake((width - 300) / 2, 100, 300, 50);
    payPasswordView.elementCount = 6;
    payPasswordView.marginColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.view addSubview:payPasswordView];
    
    payPasswordView.passwordBlock = ^(NSString *password){
        NSLog(@"%@",password);
    };
}

@end
