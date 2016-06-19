//
//  UIView+BSLayout.m
//  BSLayout
//
//  Created by kai on 16/1/29.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//
#import <objc/runtime.h>
#import "BSLayout.h"
#import "UIView+BSLayout.h"
#import "BSXmlLayoutUtils.h"

@interface BSViewLayoutInfo :NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) BSLayout *layout;

@property (assign, nonatomic) CGFloat anchorLeft;
@property (assign, nonatomic) CGFloat anchorTop;
@property (assign, nonatomic) CGFloat anchorRight;
@property (assign, nonatomic) CGFloat anchorBottom;

@property (assign, nonatomic) CGFloat fixWidth;
@property (assign, nonatomic) CGFloat fixHeight;
@property (assign, nonatomic) CGFloat precentWidth;
@property (assign, nonatomic) CGFloat precentHeight;

@property (assign, nonatomic) BOOL autoResize;
@end

@implementation BSViewLayoutInfo
@end


@implementation UIView(BSLayout)

- (void)bsLayout
{
    BSLayout *layout = [self layout];
    if (layout) {
        layout.rect = self.bounds;
        [layout bsLayout];
    }
//    for (id<BSLayoutItem>layoutItem in layout.items) {
//        [layoutItem bsLayout];
//    }
}

- (void)setLayout:(BSLayout *)layout
{
    [self bs_layoutInfo].layout = layout;
}

- (BSLayout *)layout
{
    return [self bs_layoutInfo].layout;
}

- (BSViewLayoutInfo *)bs_layoutInfo
{
    BSViewLayoutInfo *layoutInfo = objc_getAssociatedObject(self, _cmd);
    if (!layoutInfo) {
        layoutInfo = [BSViewLayoutInfo new];
        objc_setAssociatedObject(self, _cmd, layoutInfo, OBJC_ASSOCIATION_RETAIN);
    }
    
    return layoutInfo;
}

- (void)setName:(NSString *)name
{
    [self bs_layoutInfo].name = name;
}

- (NSString *)name
{
    return [self bs_layoutInfo].name;
}

- (UIView *)viewByName:(NSString *)name
{
    for (UIView *subView in self.subviews) {
        if ([subView.name isEqualToString:name]) {
            return subView;
            
        } else {
            return [subView viewByName:name];
        }
    }
    
    return nil;
}
#pragma mark - protocol
- (void)setAnchorTop:(CGFloat)anchorTop
{
    [self bs_layoutInfo].anchorTop = anchorTop;
}
- (CGFloat)anchorTop
{
    return [self bs_layoutInfo].anchorTop;
}
- (void)setAnchorLeft:(CGFloat)anchorLeft
{
    [self bs_layoutInfo].anchorLeft = anchorLeft;
}
- (CGFloat)anchorLeft
{
    return [self bs_layoutInfo].anchorLeft;
}

- (void)setAnchorRight:(CGFloat)anchorRight
{
    [self bs_layoutInfo].anchorRight = anchorRight;
}
- (CGFloat)anchorRight
{
    return [self bs_layoutInfo].anchorRight;
}
- (void)setAnchorBottom:(CGFloat)anchorBottom
{
    [self bs_layoutInfo].anchorBottom = anchorBottom;
}
- (CGFloat)anchorBottom
{
    return [self bs_layoutInfo].anchorBottom;
}

- (void)setAnchors:(NSString *)anchors
{
    NSArray *vals = [anchors componentsSeparatedByString:@","];
    self.anchorLeft = [vals[0] integerValue];
    self.anchorTop = [vals[1] integerValue];
    self.anchorRight = [vals[2] integerValue];
    self.anchorBottom = [vals[3] integerValue];
}

- (NSString *)anchors
{
    return nil;
}

- (void)setFixWidth:(CGFloat)fixWidth
{
    [self bs_layoutInfo].fixWidth = fixWidth;
}

- (CGFloat)fixWidth
{
    return [self bs_layoutInfo].fixWidth;
}

- (void)setFixHeight:(CGFloat)fixHeight
{
    [self bs_layoutInfo].fixHeight = fixHeight;
}
- (CGFloat)fixHeight
{
    return [self bs_layoutInfo].fixHeight;
}

- (void)setPrecentWidth:(CGFloat)precentWidth
{
    [self bs_layoutInfo].precentWidth = precentWidth;
}

- (CGFloat)precentWidth
{
    return [self bs_layoutInfo].precentWidth;
}

- (void)setPrecentHeight:(CGFloat)precentHeight
{
    [self bs_layoutInfo].precentHeight = precentHeight;
}

- (CGFloat)precentHeight
{
    return [self bs_layoutInfo].precentHeight;
}

- (void)setRect:(CGRect)rect
{
    [self layout].rect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    self.frame = rect;
}

- (CGRect)rect
{
    return self.bounds;
}

- (void)setAutoResize:(BOOL)autoResize
{
    [self bs_layoutInfo].autoResize = autoResize;
}

- (BOOL)autoResize
{
    return [self bs_layoutInfo].autoResize;
}

- (BOOL)masksToBounds
{
    return self.layer.masksToBounds;
}
- (void)setMasksToBounds:(BOOL)masksToBounds
{
    self.layer.masksToBounds = masksToBounds;
}

- (CGFloat) borderWidth
{
    return self.layer.borderWidth;
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}
- (UIColor*)borderColor
{
    return nil;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}
@end


@implementation UIScrollView(BSLayout)

- (void)bsLayout
{
    BSLayout *layout = [self layout];
    if (!layout) {
        return;
    }
    
    layout.rect = self.bounds;
    [layout bsLayout];
    
    for (id<BSLayoutItem>layoutItem in layout.items) {
        [layoutItem bsLayout];
    }
    
    if (layout.autoResize) {
        self.contentSize = layout.rect.size;
    }
}

@end