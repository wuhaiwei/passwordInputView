//
//  HWPayPasswordView.m
//  PayPasswordView
//
//  Created by  wuhiwi on 16/8/22.
//  Copyright © 2016年 wanglibank. All rights reserved.
//

#import "HWPayPasswordView.h"

@interface HWPayPasswordView () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) NSMutableArray *dataImageViewArray;
@property (nonatomic, strong) NSMutableArray *verticalArray;
@property (nonatomic, strong) NSMutableArray *horizontalArray;

@end


@implementation HWPayPasswordView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.passwordTextField];
    }
    return self;
}

- (void)clearPassword
{
    self.passwordTextField.text = @"";
    [self setDotWithCount:self.passwordTextField.text.length];
}

#pragma mark - setter getter
- (UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.hidden = YES;
        _passwordTextField.delegate = self;
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_passwordTextField becomeFirstResponder];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            if ([note.object isEqual:_passwordTextField]) {
                if (_passwordTextField.text.length <= self.elementCount) {
                    [self setDotWithCount:_passwordTextField.text.length];
                }
                //传值
                !self.passwordBlock ? : self.passwordBlock(_passwordTextField.text);
            }
        }];
    }
    return _passwordTextField;
}


- (NSMutableArray *)dataImageViewArray
{
    if (!_dataImageViewArray) {
        _dataImageViewArray = [NSMutableArray arrayWithCapacity:self.elementCount];
    }
    return _dataImageViewArray;
}

- (NSMutableArray *)verticalArray
{
    if (!_verticalArray) {
        _verticalArray = [NSMutableArray arrayWithCapacity:self.elementCount + 1];
    }
    return _verticalArray;
}

- (NSMutableArray *)horizontalArray
{
    if (!_horizontalArray) {
        _horizontalArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _horizontalArray;
}

- (void)setElementCount:(UInt8)elementCount
{
    _elementCount = (elementCount > 5) ? elementCount : 5;
    if (_elementCount == self.dataImageViewArray.count) {
        //避免重复创建
        return;
    }
    for (NSUInteger index = 0; index < _elementCount; index ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor greenColor];
        imageView.userInteractionEnabled = NO;
        imageView.hidden = YES;
        [self.dataImageViewArray addObject:imageView];
        [self insertSubview:imageView aboveSubview:self.passwordTextField];
    }
    
    for (NSUInteger index = 0; index < _elementCount + 1; index ++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor blackColor];
        line.userInteractionEnabled = NO;
        [self.verticalArray addObject:line];
        [self insertSubview:line aboveSubview:self.passwordTextField];
    }
    
    for (NSUInteger index = 0; index < 2; index ++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor blackColor];
        line.userInteractionEnabled = NO;
        [self.horizontalArray addObject:line];
        [self insertSubview:line aboveSubview:self.passwordTextField];
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    for (UIView *line in self.verticalArray) {
        line.backgroundColor = _lineColor;
    }
    
    for (UIView *line in self.horizontalArray) {
        line.backgroundColor = _lineColor;
    }
}


#pragma mark - system
- (void)layoutSubviews
{
    _passwordTextField.frame = self.bounds;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.bounds.size.width / self.elementCount;
    CGFloat height = self.bounds.size.height;
    for (NSUInteger index = 0; index < self.dataImageViewArray.count; index ++) {
        UIImageView *imageView = (UIImageView *)[self.dataImageViewArray objectAtIndex:index];
        imageView.layer.cornerRadius = width * 1.2;
        imageView.layer.masksToBounds = YES;
        x = index * width;
        imageView.frame = CGRectMake(x, y, width, height);
    }
    
    for (NSUInteger index = 0; index < self.verticalArray.count; index ++) {
        UIView *line = [self.verticalArray objectAtIndex:index];
        x = width * index;
        line.frame = CGRectMake(x, y, 1, height);
    }
    
    for (NSUInteger index = 0; index < self.horizontalArray.count; index ++) {
        UIView *line = [self.horizontalArray objectAtIndex:index];
        x = 0;
        y = index * height;
        line.frame = CGRectMake(x, y, self.bounds.size.width, 1);
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_passwordTextField becomeFirstResponder];
}

#pragma mark - systemDelegate
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //回车键关闭键盘
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    else if (string.length == 0)
    {
        //判断是不是删除键
        return YES;
    }
    else if (textField.text.length >= self.elementCount)
    {
        //输入的字符个数大于elementCount，则无法继续输入，返回NO表示禁止输入
        return NO;
    }else
    {
        return YES;
    }
}

#pragma mark - private
- (void)setDotWithCount:(NSUInteger)count
{
    for (UIImageView *imageView in self.dataImageViewArray) {
        imageView.hidden = YES;
    }
    
    for (NSUInteger index = 0; index < count; index ++) {
        ((UIImageView *)[self.dataImageViewArray objectAtIndex:index]).hidden = NO;
    }
}

@end
