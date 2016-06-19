//
//  BSXmlLayout.h
//  BSLayout
//
//  Created by kai on 16/1/17.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import <Foundation/Foundation.h>

//XmlTagName
extern NSString * const kStyles;
extern NSString * const kXmlStyle;
extern NSString * const kXmlView;

extern NSString * const kStyle;
extern NSString * const kXmlPath;

@class BSLayout;

@interface BSXmlLayout : NSObject

+ (void)initDefaultProperty:(NSString *)defaultValueFile;

+ (UIView *)createFromXml:(NSString *)xmlFile owner:(NSObject *)owner;

+ (UIView *)createFromFile:(NSString *)xmlPath owner:(NSObject *)owner;

+ (UIView *)createFromString:(NSString *)xmlContent owner:(NSObject *)owner;

+ (UITableViewCell *)createCellFromXml:(NSString *)xmlFile
                                 owner:(NSObject *)owner
                            identifier:(NSString *)identifier;

+ (BSLayout *)createLayoutWithXml:(NSString *)xmlFile
                       parentView:(UIView *)parentView;




@end
