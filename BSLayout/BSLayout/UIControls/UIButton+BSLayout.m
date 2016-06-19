//
//  UIButton+BSLayout.m
//  BSLayout
//
//  Created by kai on 16/2/4.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "UIButton+BSLayout.h"

@implementation UIButton(BSLayout)

- (void)setImageName:(NSString *)imageName
{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (NSString *)imageName
{
    return nil;
}

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (NSString *)title
{
    return self.titleLabel.text;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (UIColor *)titleColor
{
    return nil;
}
@end
