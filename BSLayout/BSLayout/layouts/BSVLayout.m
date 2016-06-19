//
//  BSVLayout.m
//  BSLayout
//
//  Created by kai on 16/2/4.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "BSVLayout.h"

void sumFixHeight(NSArray *items, CGFloat *sum, NSUInteger *fixCount)
{
    for (BSLayoutBase *item in items) {
        if (item.fixHeight > 0) {
            *sum += item.fixHeight;
            *fixCount = *fixCount + 1;
        }
    }
}

@implementation BSVLayout
- (void)setMargins:(NSString *)margins
{
    NSArray *vals = [margins componentsSeparatedByString:@","];
    self.leftMargin = [vals[0] integerValue];
    self.topMargin = [vals[1] integerValue];
    self.rightMargin = [vals[2] integerValue];
    self.bottomMargin = [vals[3] integerValue];
}

- (NSString *)margins
{
    return nil;
}
- (void)bsLayout
{
    CGRect rc = self.rect;
    CGSize size = rc.size;
    
    CGFloat left = self.leftMargin + rc.origin.x;
    CGFloat top = self.topMargin + rc.origin.y;
    
    NSInteger itemCount = self.items.count;
    
    NSUInteger fixHeightCount = 0;
    
    CGFloat totalFixHeight = 0.0;
    
    
    sumFixHeight(self.items, &totalFixHeight, &fixHeightCount);
    
    CGFloat itemHeight = (size.height - self.topMargin - self.bottomMargin - totalFixHeight -
                          self.itemSpacing * (itemCount - 1)) / (itemCount - fixHeightCount);
    
    CGFloat itemWidth = size.width - self.leftMargin - self.rightMargin;
    CGFloat itemSpacing = self.itemSpacing;
    
    for (BSLayoutBase *item in self.items) {
        CGRect frame = item.rect;
        
//        frame.origin.x = left;
        frame.origin.y = top;
        
        if (item.fixWidth > 0) {
            frame.size.width = item.fixWidth;
        } else {
            frame.size.width = itemWidth;
        }
        
        if (item.fixHeight > 0) {
            frame.size.height = item.fixHeight;
            
        } else {
            frame.size.height = itemHeight;
        }
        
        frame.origin.x = ( size.width - frame.size.width ) / 2 + left;
        item.rect = frame;
        
        top += frame.size.height;
        top += itemSpacing;
    }
    
    if (self.autoResize) {
        top += self.bottomMargin;
        rc.size = CGSizeMake(rc.size.width, top);
        self.rect = rc;
    }
    
    [super bsLayout];
}

@end
