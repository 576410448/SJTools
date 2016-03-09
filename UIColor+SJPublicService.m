//
//  UIColor+SJPublicService.m
//  SJTools
//
//  Created by shenj on 16/3/7.
//  Copyright © 2016年 shenj. All rights reserved.
//

#import "UIColor+SJPublicService.h"

@implementation UIColor (SJPublicService)

// 16进制颜色转UIColor
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSString	*cString			= [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    UIColor		*DEFAULT_VOID_COLOR = [UIColor clearColor];
    
    if ([cString length] < 6) {
        return DEFAULT_VOID_COLOR;
    }
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    if ([cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    NSString *alpha = @"FF";
    
    if ([cString length] == 8) {
        alpha	= [cString substringToIndex:2];
        cString = [cString substringFromIndex:2];
    }
    
    if ([cString length] != 6) {
        return DEFAULT_VOID_COLOR;
    }
    
    NSRange range;
    range.location	= 0;
    range.length	= 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:alpha] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                         green		:((float)g / 255.0f)
                          blue		:((float)b / 255.0f)
                         alpha		:((float)a / 255.0f)];
}

@end
