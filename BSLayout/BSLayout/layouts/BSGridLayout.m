//
//  BSGridLayout.m
//  BSLayout
//
//  Created by kai on 16/2/5.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "BSGridLayout.h"

@implementation BSGridLayout

- (void)bsLayout
{
    CGRect rc = self.rect;
    
    CGFloat left = self.leftMargin + rc.origin.x;
    CGFloat top = self.topMargin + rc.origin.y;
    
    CGFloat base_left = left;
    
    CGFloat itemWidth = self.itemWidth;
    CGFloat itemHeight = self.itemHeight;
    
    for (id<BSLayoutItem> item in self.items) {
        CGRect frame = item.rect;
        
        if (left + itemWidth > rc.size.width) {
            left  = base_left;
            top += itemHeight;
            top += self.spacing;
        }
        
        frame.origin.x = left;
        frame.origin.y = top;
        frame.size.width = itemWidth;
        frame.size.height = itemHeight;
        
        left += frame.size.width;
        left += self.spacing;
        
//        top += frame.size.height;
        
        item.rect = frame;
    }
    
    [super bsLayout];
}
@end
