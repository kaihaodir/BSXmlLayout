//
//  BSXmlLayout.m
//  BSLayout
//
//  Created by kai on 16/1/17.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "BSXmlLayout.h"
#import "UIView+BSLayout.h"
#import "BSXmlLayoutUtils.h"
#import "TBXML.h"

NSString * const kStyles    = @"Styles";
NSString * const kXmlStyle  = @"XmlStyle";
NSString * const kXmlView   = @"XmlView";

NSString * const kStyle     = @"style";
NSString * const kXmlPath   = @"path";


@interface BSXmlLayout()

@property (assign, nonatomic) TBXMLElement *styleInfo;
@property (strong, nonatomic) NSMutableArray<TBXML *> *externStyleInfo;

@end

@implementation BSXmlLayout

+ (void)initDefaultProperty:(NSString *)defaultValueFile
{
    NSError *error = nil;
    TBXML *xml = [TBXML newTBXMLWithXMLFile:defaultValueFile error:&error];
    if (error) {
        NSLog(@"parse xml file error:%@", error);
    }
    
    NSMutableDictionary *dic = [self defaultValueDic];
    TBXMLElement *element = xml.rootXMLElement->firstChild;
    while (element) {
        NSString *key = [TBXML elementName:element];
        NSString *val = [TBXML valueOfAttributeNamed:@"value" forElement:element];
        if (key && val) {
            dic[key] = val;
        }
        element = element->nextSibling;
    }
}

+ (NSMutableDictionary *)defaultValueDic
{
    static NSMutableDictionary *__defaultDic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __defaultDic = [NSMutableDictionary new];
    });
    
    return __defaultDic;
}

+ (NSString *)GetAttributeValue:(NSString *)val
{
    NSDictionary *dic = [self defaultValueDic];
    NSString *attValue = dic[val];
    if (attValue) {
        return attValue;
    }
    
    return val;
}


+ (UIView *)createFromString:(NSString *)xmlContent owner:(NSObject *)owner
{
    NSError *error = nil;
    TBXML *xml = [TBXML newTBXMLWithXMLString:xmlContent error:&error];
    if (error) {
        NSLog(@"parse xml file error:%@", error);
        return nil;
    }
    
    return [self createWithXml:xml
                         owner:owner
                    parentView:nil
                  parentLayout:nil
                   constructor:nil];
}

+ (UIView *)createFromFile:(NSString *)xmlPath owner:(NSObject *)owner
{
    NSString *xmlContent = [NSString stringWithContentsOfFile:xmlPath encoding:NSUTF8StringEncoding error:nil];
    if (xmlContent.length == 0) {
        return nil;
    }
    
    return [self createFromString:xmlContent owner:owner];
}


+ (UIView *)createFromXml:(NSString *)xmlFile owner:(NSObject *)owner
{
    NSLog(@"being createFromXml:%@", xmlFile);
    
    id view = [self createFromXml:xmlFile owner:owner parentView:nil parentLayout:nil constructor:nil];
    if ([view isKindOfClass:[UIView class]]) {
        NSLog(@"finish createFromXml");
        return view;
    }
    return nil;
}

+ (UITableViewCell *)createCellFromXml:(NSString *)xmlFile owner:(NSObject *)owner identifier:(NSString *)identifier
{
    id view = [self createFromXml:xmlFile owner:owner parentView:nil parentLayout:nil constructor:^id(UITableViewCell *obj) {
        return [obj initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }];
    
    if ([view isKindOfClass:[UIView class]]) {
        NSLog(@"finish createFromXml");
        return view;
    }
    return nil;
}

+ (BSLayout *)createLayoutWithXml:(NSString *)xmlFile
                       parentView:(UIView *)parentView
{
    id layout = [self createFromXml:xmlFile owner:parentView parentView:parentView parentLayout:nil constructor:nil];
    if ([layout isKindOfClass:[BSLayout class]]) {
        return layout;
    }
    return nil;
}


+ (id)createFromXml:(NSString *)xmlFile
              owner:(NSObject *)owner
         parentView:(UIView *)parentView
       parentLayout:(BSLayout *)parentLayout
        constructor:(id(^)(id obj))constructor
{
    NSError *error = nil;
    TBXML *xml = [TBXML newTBXMLWithXMLFile:xmlFile error:&error];
    if (error) {
        NSLog(@"parse xml file error:%@", error);
        return nil;
    }
    
    return [self createWithXml:xml
                         owner:owner
                    parentView:parentView
                  parentLayout:parentLayout
                   constructor:constructor];
}


+ (id)createWithXml:(TBXML *)xml
              owner:(NSObject *)owner
         parentView:(UIView *)parentView
       parentLayout:(BSLayout *)parentLayout
        constructor:(id(^)(id obj))constructor
{
    BSXmlLayout *layoutObj = [BSXmlLayout new];
    
    TBXMLElement *xmlElement = xml.rootXMLElement;
    TBXMLElement *childElement = xmlElement->firstChild;
    TBXMLElement *viewElement = childElement;
    
    if ([[TBXML elementName:childElement] isEqualToString:kStyles]) {
        layoutObj.styleInfo = childElement;
        viewElement = childElement->nextSibling;
        
        TBXMLElement *styleChild = childElement->firstChild;
        while (styleChild) {
            NSString *styleChildName = [TBXML elementName:styleChild];
            if ([styleChildName isEqualToString:kXmlStyle]) {
                NSString *path = [TBXML valueOfAttributeNamed:kXmlPath forElement:styleChild];
                if (path) {
                    [layoutObj addExternStyleWithPath:path];
                }
            }
            styleChild = styleChild->nextSibling;
        }
    }
    
    if (!viewElement) {
        return nil;
    }
    
    id view = [layoutObj parseXmlElement:viewElement
                                   owner:owner
                              parentView:parentView
                            parentLayout:parentLayout
                             constructor:constructor];
    
    layoutObj.styleInfo = NULL;
    
    if ([view isKindOfClass:[UIView class]]) {
        return view;
    }
    return nil;
}

- (id)parseXmlElement:(TBXMLElement *)element
                      owner:(NSObject *)owner
                 parentView:(UIView *)parentView
               parentLayout:(BSLayout *)parentLayout
          constructor:(id(^)(id obj))constructor
{
    id obj = nil;
    
    NSString *elementName = [TBXML elementName:element];
    if ([elementName isEqualToString:kXmlView]) {
        NSString *path = [TBXML valueOfAttributeNamed:kXmlPath forElement:element];
        if (path) {
            obj = [BSXmlLayout createFromXml:path owner:owner parentView:parentView parentLayout:parentLayout constructor:nil];
        }
    }  else {
        if (constructor) {
            obj = constructor( [NSClassFromString(elementName) alloc] );
        } else {
            obj = (id)[[NSClassFromString(elementName) alloc] init];
        }
    }
    
    if (!obj) {
        return nil;
    }
    
    if ([obj isKindOfClass:[UIView class]]) {
        
        [TBXML iterateAttributesOfElement:element withBlock:^(TBXMLAttribute *attribute, NSString *attributeName, NSString *attributeValue) {
            [self setAttributeForView:obj withKey:attributeName value:attributeValue owner:owner];
        }];
        
        [parentLayout addLayoutItem:obj];
        [parentView addSubview:obj];
        
        
        // auto link property to root view.
        if (!owner && !parentView) {
            owner = obj;
        }
        
        TBXMLElement *child = element->firstChild;
        while (child) {
            [self parseXmlElement:child owner:owner parentView:obj parentLayout:nil constructor:nil];
            child = child->nextSibling;
        }
        
    } else {
        [TBXML iterateAttributesOfElement:element withBlock:^(TBXMLAttribute *attribute, NSString *attributeName, NSString *attributeValue) {
            [self setAttributeForLayout:obj withKey:attributeName value:attributeValue];
        }];
        
        if (!parentView.layout) {
            parentView.layout = obj;
        }
        [parentLayout addLayoutItem:obj];
        
        TBXMLElement *child = element->firstChild;
        while (child) {
            [self parseXmlElement:child owner:owner parentView:parentView parentLayout:obj constructor:nil];
            child = child->nextSibling;
        }
    }
    return obj;
}

- (NSMutableArray *)externStyleInfo
{
    if (!_externStyleInfo) {
        _externStyleInfo = [[NSMutableArray alloc] init];
    }
    return _externStyleInfo;
}

-(void)addExternStyleWithPath:(NSString *)xmlPath
{
    NSError *error = nil;
    TBXML *xml = [TBXML newTBXMLWithXMLFile:xmlPath error:&error];
    if (error) {
        NSLog(@"parse xml file error:%@", error);
        return;
    }
    
    [self.externStyleInfo addObject:xml];
}

- (void)setAttributeForLayout:(BSLayout *)layout withKey:(NSString *)key value:(NSString *)val
{
    id value = [BSXmlLayout GetAttributeValue:val];
    
    if ([value isEqualToString:@"YES"]) {
        value = @(YES);
        
    } else if ([value isEqualToString:@"NO"]) {
        value = @(NO);
        
    }
    
    if ([key isEqualToString:kStyle]) {
        [self setLayoutStyle:layout withStyle:val];
        
    } else if ([layout respondsToSelector:NSSelectorFromString(key)]) {
        [layout setValue:value forKey:key];
    }
}

-(void)setAttributeForView:(UIView *)view withKey:(NSString *)name value:(NSString *)val owner:(NSObject *)owner
{
    id value = [BSXmlLayout GetAttributeValue:val];
    
    if ([value isEqualToString:@"YES"]) {
        value = @(YES);
        
    } else if ([value isEqualToString:@"NO"]) {
        value = @(NO);
        
    } else if ([value hasPrefix:@"RGB"]) {
        value = BSColorFromString(value);
    }
    
    if ([name isEqualToString:@"rect"]) {
        [view setRect:BSRectFromString(value)];
        
    } else if ([name isEqualToString:@"linkProperty"]) {
        if ([owner respondsToSelector:NSSelectorFromString(value)]) {
            [owner setValue:view forKey:value];
        }
        
    } else if ([name isEqualToString:@"action"]) {
        SEL aSelector = NSSelectorFromString(value);
        if ([owner respondsToSelector:aSelector]) {
            [((UIControl *)view) addTarget:owner action:aSelector forControlEvents:UIControlEventTouchUpInside];
        }
        
    } else if ([name isEqualToString:@"switchChangeAction"]) {
        SEL aSelector = NSSelectorFromString(value);
        if ([owner respondsToSelector:aSelector]) {
            [((UIControl *)view) addTarget:owner action:aSelector forControlEvents:UIControlEventValueChanged];
        }
    } else if ([name isEqualToString:@"style"]) {
        [self setViewStyle:view withStyle:value];
        
    } else {
        if ([view respondsToSelector:NSSelectorFromString(name)]) {
            [view setValue:value forKey:name];
        }
    }
}

- (void)setLayoutStyle:(BSLayout *)layout withStyle:(NSString *)styleName
{
    if (!_styleInfo) {
        return;
    }
    
    TBXMLElement *styleElement = [TBXML childElementNamed:styleName parentElement:_styleInfo];
    if (styleElement) {
        [self setLayoutAttribyte:layout withElement:styleElement];
        return;
    }
    
    for (TBXML *xml in _externStyleInfo) {
        TBXMLElement *element = [TBXML childElementNamed:styleName parentElement:xml.rootXMLElement];
        if (element) {
            [self setLayoutAttribyte:layout withElement:element];
            return;
        }

    }
}

- (void)setLayoutAttribyte:(BSLayout *)layout withElement:(TBXMLElement *)element
{
    [TBXML iterateAttributesOfElement:element
                                withBlock:^(TBXMLAttribute *attribute, NSString *attributeName, NSString *attributeValue) {
                                    [self setAttributeForLayout:layout withKey:attributeName value:attributeValue];
                                }];
}

- (void)setViewStyle:(UIView *)view withStyle:(NSString *)styleName
{
    if (!_styleInfo) {
        return;
    }
    
    TBXMLElement *styleElement = [TBXML childElementNamed:styleName parentElement:_styleInfo];
    if (styleElement) {
        [TBXML iterateAttributesOfElement:styleElement
                                withBlock:^(TBXMLAttribute *attribute, NSString *attributeName, NSString *attributeValue) {
                                    [self setAttributeForView:view withKey:attributeName value:attributeValue owner:nil];
                                }];
        return;
    }
    
    for (TBXML *xml in _externStyleInfo) {
        TBXMLElement *element = [TBXML childElementNamed:styleName parentElement:xml.rootXMLElement];
        if (element) {
            [TBXML iterateAttributesOfElement:element
                                    withBlock:^(TBXMLAttribute *attribute, NSString *attributeName, NSString *attributeValue) {
                                        [self setAttributeForView:view withKey:attributeName value:attributeValue owner:nil];
                                    }];
            return;
        }
    }
}
@end
