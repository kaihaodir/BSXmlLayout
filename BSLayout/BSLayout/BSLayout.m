//
//  BSLayout.m
//  BSLayout
//
//  Created by kai on 16/2/4.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "BSLayout.h"

@implementation BSLayoutSpacing

@end

@implementation BSLayoutBase
{
    CGRect  _rect;
    
    CGFloat _fixTop;
    CGFloat _fixLeft;
    CGFloat _fixRight;
    CGFloat _fixBottom;
    
    CGFloat _fixWidth;
    CGFloat _fixHeight;
    CGFloat _precentWidth;
    CGFloat _precentHeight;
    
    BOOL _autoResize;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fixTop = -1;
        _fixLeft = -1;
        _fixRight = -1;
        _fixBottom = -1;
    }
    return self;

}

- (void)setRect:(CGRect)rect
{
    _rect = rect;
}

- (CGRect)rect
{
    return _rect;
}

- (void)setAnchorTop:(CGFloat)anchorTop
{
    _fixTop = anchorTop;
}

- (CGFloat)anchorTop
{
    return _fixTop;
}

- (void)setAnchorLeft:(CGFloat)anchorLeft
{
    _fixLeft = anchorLeft;
}

- (CGFloat)anchorLeft
{
    return _fixLeft;
}

- (void)setAnchorRight:(CGFloat)anchorRight
{
    _fixRight = anchorRight;
}

- (CGFloat)anchorRight
{
    return _fixRight;
}

- (void)setAnchorBottom:(CGFloat)anchorBottom
{
    _fixBottom = anchorBottom;
}

- (CGFloat)anchorBottom
{
    return _fixBottom;
}

- (void)setFixHeight:(CGFloat)fixHeight
{
    _fixHeight = fixHeight;
}

- (CGFloat)fixHeight
{
    return _fixHeight;
}

- (void)setFixWidth:(CGFloat)fixWidth
{
    _fixWidth = fixWidth;
}

- (CGFloat)fixWidth
{
    return _fixWidth;
}

- (void)setPrecentWidth:(CGFloat)precentWidth
{
    _precentWidth = precentWidth;
}

- (CGFloat)precentWidth
{
    return _precentWidth;
}

- (void)setPrecentHeight:(CGFloat)precentHeight
{
    _precentHeight = precentHeight;
}

- (CGFloat)precentHeight
{
    return _precentHeight;
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

- (void)setAutoResize:(BOOL)autoResize
{
    _autoResize = autoResize;
}

- (BOOL)autoResize
{
    return _autoResize;
}
- (void)bsLayout
{
    
}
@end


#pragma mark - BSLayout

@interface BSLayout()

@property (strong, nonatomic) NSMutableArray *layoutItems;

@end

@implementation BSLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layoutItems = [NSMutableArray new];
    }
    
    return self;
}

- (void)addLayoutItem:(BSLayoutBase *)view
{
    [_layoutItems addObject:view];
}

- (void)removeLayoutItem:(BSLayoutBase *)view
{
    [_layoutItems removeObject:view];
}

- (NSArray *)items
{
    return _layoutItems;
}

- (void)bsLayout
{
    for (BSLayoutBase *layoutItem in _layoutItems) {
        [layoutItem bsLayout];
    }
}
@end
