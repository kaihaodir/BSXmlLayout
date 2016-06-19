//
//  BSRectLayout.m
//  BSLayout
//
//  Created by kai on 16/2/17.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "BSAnchorLayout.h"

@implementation BSAnchorLayout

- (void)bsLayout
{
    CGRect rc = self.rect;
    
    for (id<BSLayoutItem> item in self.items) {
        CGRect itemRect = item.rect;
        
        if (item.anchorLeft >= 0) {
            itemRect.origin.x = item.anchorLeft + rc.origin.x;
        }
        
        if (item.anchorTop >= 0) {
            itemRect.origin.y = item.anchorTop + rc.origin.y;
        }
        
        if (item.anchorRight >= 0) {
            itemRect.size.width = rc.size.width - item.anchorRight;
        }
        
        if (item.anchorBottom >= 0) {
            itemRect.size.height = rc.size.height - item.anchorBottom;
        }

        if (item.fixWidth > 0) {
            itemRect.size.width = item.fixWidth;
        }
        
        if (item.fixHeight > 0) {
            itemRect.size.height = item.fixHeight;
        }
        
        [item setRect:itemRect];
    }
    
    [super bsLayout];
}

@end
