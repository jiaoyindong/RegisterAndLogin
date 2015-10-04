//
//  Factory.m
//  StopWatchDemo
//
//  Created by Hailong.wang on 15/7/28.
//  Copyright (c) 2015年 Hailong.wang. All rights reserved.
//

#import "Factory.h"

@implementation Factory

+ (UIButton *)createButtonWithTitle:(NSString *)title
                              frame:(CGRect)frame
                             target:(id)target
                           selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    //按钮的圆角
    button.layer.cornerRadius = 3.f;
    button.layer.masksToBounds = YES;
    
    button.backgroundColor = [UIColor colorWithRed:0.3 green:0.8f blue:1.f alpha:1.f];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame {
    return [self createLabelWithTitle:title frame:frame fontSize:14.f];
}

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color {
    return [self createLabelWithTitle:title frame:frame textColor:color fontSize:14.f];
}

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame fontSize:(CGFloat)size {
    return [self createLabelWithTitle:title frame:frame textColor:[UIColor blackColor] fontSize:size];
}

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    //字体的大小
    label.font = [UIFont systemFontOfSize:size];
    //return [label autorelease];
    return label;
}

+ (UIView *)createViewWithBackgroundColor:(UIColor *)color frame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    //return [view autorelease];
    return view;
}

+ (UITextField *)createViewWithText:(NSString *)text frame:(CGRect)frame placeholder:(NSString *)placeholder textColor:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    //占位符
    textField.placeholder = placeholder;
    //textField的边框类型
    textField.borderStyle = borderStyle;
    textField.text = text;
    textField.textColor = color;
    //return [textField autorelease];
    return textField;
}

@end







