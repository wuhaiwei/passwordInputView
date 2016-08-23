//
//  SecondViewController.m
//  PayPasswordView
//
//  Created by  wuhiwi on 16/8/22.
//  Copyright © 2016年 wanglibank. All rights reserved.
//

#import "SecondViewController.h"
#import "HWPayPasswordView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    HWPayPasswordView *passwordView = [[HWPayPasswordView alloc] initWithFrame:CGRectMake(30, 100, self.view.bounds.size.width - 60, 50)];
    passwordView.elementCount = 6;
    passwordView.lineColor = [UIColor blueColor];
    [self.view addSubview:passwordView];
    
    passwordView.passwordBlock = ^(NSString *password){
        NSLog(@"%@",password);
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
