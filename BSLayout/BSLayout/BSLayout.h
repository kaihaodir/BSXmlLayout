//
//  BSLayout.h
//  BSLayout
//
//  Created by kai on 16/2/4.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BSLayoutItem <NSObject>

@property (assign, nonatomic) CGRect  rect;

@property (assign, nonatomic) CGFloat anchorLeft;
@property (assign, nonatomic) CGFloat anchorTop;
@property (assign, nonatomic) CGFloat anchorRight;
@property (assign, nonatomic) CGFloat anchorBottom;

@property (assign, nonatomic, nullable) NSString* anchors;

@property (assign, nonatomic) CGFloat fixWidth;
@property (assign, nonatomic) CGFloat fixHeight;
@property (assign, nonatomic) CGFloat precentWidth;
@property (assign, nonatomic) CGFloat precentHeight;

@property (assign, nonatomic) BOOL autoResize;

- (void)bsLayout;

@end


@interface BSLayoutBase: NSObject <BSLayoutItem>
@end


/**
 *  占位符
 */
@interface BSLayoutSpacing: BSLayoutBase

@end


typedef NS_ENUM(NSInteger, BSLayoutSize) {
    kBSParentSize   = -1,
};

@interface BSLayout : BSLayoutBase

@property (readonly, nonatomic, nonnull) NSArray *items;

- (void)addLayoutItem:(nonnull id<BSLayoutItem>)item;

- (void)removeLayoutItem:(nonnull id<BSLayoutItem>)item;

- (void)bsLayout;

@end

