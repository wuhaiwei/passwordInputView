//
//  PayPasswordView.m
//  PayPasswordView
//
//  Created by  wuhiwi on 16/8/22.
//  Copyright © 2016年 wanglibank. All rights reserved.
//

#import "PayPasswordView.h"

@interface PayPasswordView ()

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) NSMutableArray *dataTFArray;

@end


@implementation PayPasswordView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.inputTextField];
    }
    return self;
}

- (void)clearText
{
    self.inputTextField.text = nil;
    [self textChange:self.inputTextField];
}

#pragma mark - system
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (self.bounds.size.width - (self.elementCount - 1) * self.elementMargin) / self.elementCount;
    CGFloat h = self.bounds.size.height;
    for (NSUInteger index = 0; index < self.dataTFArray.count; index ++) {
        UITextField *passwordTF = (UITextField *)[self.dataTFArray objectAtIndex:index];
        x = index * (w + self.elementMargin);
        passwordTF.frame = CGRectMake(x, y, w, h);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputTextField becomeFirstResponder];
}

#pragma mark - setter getter
- (UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] initWithFrame:self.bounds];
        _inputTextField.hidden = YES;
        _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_inputTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}

- (NSMutableArray *)dataTFArray
{
    if (!_dataTFArray) {
        _dataTFArray = [NSMutableArray arrayWithCapacity:self.elementCount];
    }
    return _dataTFArray;
}

- (void)setElementCount:(UInt8)elementCount
{
    //默认至少创建五个密码框
    _elementCount = (elementCount > 5) ? elementCount : 5;
    for (int index = 0; index < _elementCount; index ++) {
        UITextField *passwordTF = [[UITextField alloc] init];
        passwordTF.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
        passwordTF.layer.borderWidth = 1.0;
        passwordTF.enabled = NO;
        passwordTF.textAlignment = NSTextAlignmentCenter;
//        passwordTF.secureTextEntry = YES;
        passwordTF.userInteractionEnabled = NO;
        [self.dataTFArray addObject:passwordTF];
        [self insertSubview:passwordTF aboveSubview:self.inputTextField];
    }
}

- (void)setMarginColor:(UIColor *)marginColor
{
    _marginColor = marginColor;
    for (int index = 0; index < _dataTFArray.count; index ++) {
        UITextField *passwordTF = (UITextField *)[_dataTFArray objectAtIndex:index];
        passwordTF.layer.borderColor = _marginColor.CGColor;
    }
}

- (void)setElementMargin:(UInt8)elementMargin
{
    _elementMargin = elementMargin;
    [self setNeedsLayout];
}

#pragma mark - event
- (void)textChange:(UITextField *)textField
{
    NSString *password = textField.text;
    if (password.length > self.elementCount) {
        return;
    }
    
    for (NSUInteger index = 0; index < self.dataTFArray.count; index ++) {
        UITextField *passwordTF = (UITextField *)[self.dataTFArray objectAtIndex:index];
        if (index < password.length) {
            NSString *pwd = [password substringWithRange:NSMakeRange(index, 1)];
            passwordTF.text = pwd;
        }else
        {
            passwordTF.text = nil;
        }
    }
    
    if (password.length == self.dataTFArray.count) {
        [textField resignFirstResponder];
    }
    
    !self.passwordBlock ? : self.passwordBlock(textField.text);
}

@end
