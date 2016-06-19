//
//  UILabel+BSLayout.m
//  BSLayout
//
//  Created by kai on 16/2/4.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "UILabel+BSLayout.h"
#import "UIView+BSLayout.h"

@implementation UILabel(BSLayout)

- (void)setFontSize:(CGFloat)fontSize
{
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (CGFloat)fontSize
{
    return self.font.pointSize;
}
@end
