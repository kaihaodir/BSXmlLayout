//
//  BSGridLayout.h
//  BSLayout
//
//  Created by kai on 16/2/5.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "BSLayout.h"

@interface BSGridLayout : BSLayout

@property (assign, nonatomic) CGFloat itemWidth;
@property (assign, nonatomic) CGFloat itemHeight;

@property (assign, nonatomic) CGFloat topMargin;
@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;
@property (assign, nonatomic) CGFloat bottomMargin;

@property (assign, nonatomic) CGFloat spacing;
@end
