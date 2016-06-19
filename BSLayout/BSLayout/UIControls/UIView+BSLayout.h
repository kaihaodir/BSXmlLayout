//
//  UIView+BSLayout.h
//  BSLayout
//
//  Created by kai on 16/1/29.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSLayout.h"

@interface UIView(BSLayout)<BSLayoutItem>

@property (strong, nonatomic) BSLayout *layout;
@property (strong, nonatomic) NSString *name;

@property (assign, nonatomic) BOOL masksToBounds;
@property (assign, nonatomic) CGFloat borderWidth;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (assign, nonatomic) UIColor *borderColor;

- (void)bsLayout;

- (UIView *)viewByName:(NSString *)name;

@end


@interface UIScrollView(BSLayout)
- (void)bsLayout;
@end