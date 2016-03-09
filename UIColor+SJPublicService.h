//
//  UIColor+SJPublicService.h
//  SJTools
//
//  Created by shenj on 16/3/7.
//  Copyright © 2016年 shenj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SJPublicService)

//16进制颜色转UIColor
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
