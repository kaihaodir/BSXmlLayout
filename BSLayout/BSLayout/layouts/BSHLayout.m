//
//  BSHLayout.m
//  BSLayout
//
//  Created by kai on 16/2/4.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "BSHLayout.h"
void getTotalFixWidth(NSArray *items, CGFloat parentWidth, CGFloat *sum, NSUInteger *fixCount)
{
    for (BSLayoutBase *item in items) {
        if (item.fixWidth > 0) {
            *sum += item.fixWidth;
            *fixCount = *fixCount + 1;
            
        } else if (item.precentWidth > 0) {
            item.fixWidth = item.precentWidth * parentWidth;
            
            *sum += item.fixWidth;
            *fixCount += 1;
        }
    }
}

@implementation BSHLayout

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
    
    CGFloat totalFixWidth = 0;
    
    NSUInteger fixWidthCount = 0;
    
    getTotalFixWidth(self.items,size.width, &totalFixWidth, &fixWidthCount);
    
    CGFloat itemWidth = (size.width - self.leftMargin - self.rightMargin - totalFixWidth -
                         self.itemSpacing * (itemCount - 1)) / (itemCount - fixWidthCount);
    
    CGFloat itemHeight = size.height - self.topMargin - self.bottomMargin;
    CGFloat itemSpacing = self.itemSpacing;
    
    for (BSLayoutBase *item in self.items) {
        CGRect frame = item.rect;
        
        frame.origin.x = left;
//        frame.origin.y = top;
        
        if (item.fixWidth > 0) {
            frame.size.width = item.fixWidth;
        } else if (item.fixWidth == -1) {
            frame.size.width = rc.size.width;
        } else {
            frame.size.width = itemWidth;
        }
        
        if (item.fixHeight > 0) {
            frame.size.height = item.fixHeight;
        } else if (item.fixHeight == -1) {
            frame.size.height = rc.size.height;
        } else {
            frame.size.height = itemHeight;
        }
        
        frame.origin.y = top + (size.height - frame.size.height ) / 2;
        
        item.rect = frame;
        
        left += frame.size.width;
        left += itemSpacing;
    }
    
    if (self.autoResize) {
        rc.size = CGSizeMake(left, rc.size.height);
        self.rect = rc;
    }
    
    [super bsLayout];
}


@end
