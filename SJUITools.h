//
//  SJUITools.h
//  SJTools
//
//  Created by shenj on 16/3/7.
//  Copyright © 2016年 shenj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SeperatorLinePosition) {
    SeperatorLinePositionLeft,
    SeperatorLinePositionRight,
    SeperatorLinePositionTop,
    SeperatorLinePositionBottom,
};

@interface SJUITools : NSObject
//这里针对用户头像单独做一个placehoder的方法
+ (void)setUserHeaderView:(UIImageView *)imageView WithUrl:(NSString *)url;
+ (void)setImageView:(UIImageView *)imageView WithUrl:(NSString *)url;
//设置view的边框宽度，边框颜色，圆角大小
+ (void)setRoundView:(UIView *)view withBorderWidth:(float)width borderColor:(UIColor *)color cornerRadius:(float)round;
+ (void)setRightTopBadge:(UIView*)view withBadgeValue:(NSInteger )badgeValue;
//设置分割线
+ (void)addSeperatorLineToView:(UIView *)view withWidth:(float)width color:(UIColor *)color inPosition:(SeperatorLinePosition)position;

//单独定义一个方法，设置UITextField的属性
+ (void)setTextFieldStyle:(UITextField *)texfField withLeftViewName:(NSString *)name leftViewFrame:(CGRect)frame  withBorderColor:(UIColor *)color CornerRadius:(float)width andIsCenter:(BOOL)isCenterModel;

@end
