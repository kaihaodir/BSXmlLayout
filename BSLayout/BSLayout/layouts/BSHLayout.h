//
//  BSHLayout.h
//  BSLayout
//
//  Created by kai on 16/2/4.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSLayout.h"

@interface BSHLayout : BSLayout

@property (assign, nonatomic) NSString *margins;

@property (assign, nonatomic) CGFloat topMargin;
@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;
@property (assign, nonatomic) CGFloat bottomMargin;
@property (assign, nonatomic) CGFloat itemSpacing;

@end
