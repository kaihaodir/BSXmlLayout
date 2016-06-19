//
//  BSXmlLayoutUtils.m
//  MakeFriends
//
//  Created by kai on 16/2/23.
//
//

#import "BSXmlLayoutUtils.h"
#import "BSLayout.h"

UIColor* BSColorFromString(NSString *val)
{
    if ([val hasPrefix:@"RGBA"]) {
        
        NSString *color = [val substringWithRange:NSMakeRange(4, val.length - 6)];
        NSArray *valList = [color componentsSeparatedByString:@","];
        
        int r = 0,g = 0,b = 0,a = 1;
        r = [valList[0] intValue];
        g = [valList[1] intValue];
        b = [valList[2] intValue];
        a = [valList[3] intValue];
        
        return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
    }
    
    if ([val hasPrefix:@"RGB"]) {
        NSString *color = [val substringWithRange:NSMakeRange(4, val.length - 5)];
        NSArray *valList = [color componentsSeparatedByString:@","];
        
        int r = 0,g = 0,b = 0;
        r = [valList[0] intValue];
        g = [valList[1] intValue];
        b = [valList[2] intValue];
        
        return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
        
    }
    return nil;
}

CGRect BSRectFromString(NSString *val)
{
    NSArray *valList = [val componentsSeparatedByString:@","];
    if (valList.count != 4) {
        return CGRectZero;
    }
    
    int x = 0, y = 0, w = 0, h = 0;
    x = [valList[0] intValue];
    y = [valList[1] intValue];
    w = [valList[2] intValue];
    h = [valList[3] intValue];
    
    return CGRectMake(x, y, w, h);
}
