//
//  SJUITools.m
//  SJTools
//
//  Created by shenj on 16/3/7.
//  Copyright © 2016年 shenj. All rights reserved.
//

#import "SJUITools.h"
#import "UIImageView+WebCache.h"
#import "UIImage+FromColor.h"
#import <UIView+MGBadgeView/UIView+MGBadgeView.h>
#import "SJStringTools.h"

@implementation SJUITools

+ (void)setImageView:(UIImageView *)imageView WithUrl:(NSString *)url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"product_default_placehoder"]];
}

//这里针对用户头像单独做一个placehoder的方法
+ (void)setUserHeaderView:(UIImageView *)imageView WithUrl:(NSString *)url{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"mc_head_default"]];
}

//设置view的边框宽度，边框颜色，圆角大小
+ (void)setRoundView:(UIView *)view withBorderWidth:(float)width borderColor:(UIColor *)color cornerRadius:(float)round{
    [[view layer] setBorderWidth:width];//画线的宽度
    [[view layer] setBorderColor:color.CGColor];//颜色
    [[view layer] setCornerRadius:round];//圆角
    [view.layer setMasksToBounds:YES];
}
+ (void)setRightTopBadge:(UIView*)view withBadgeValue:(NSInteger )badgeValue{
    [view.badgeView setBadgeValue:badgeValue];
    [view.badgeView setPosition:MGBadgePositionTopRight];
    [view.badgeView setBadgeColor:[UIColor redColor]];
    [view.badgeView setTextColor:[UIColor whiteColor]];
    [view.badgeView setOutlineWidth:0];
    [view.badgeView setMinDiameter:18];
}

+ (void)addSeperatorLineToView:(UIView *)view withWidth:(float)width color:(UIColor *)color inPosition:(SeperatorLinePosition)position{
    CGFloat x, y, w, h;
    switch (position) {
        case SeperatorLinePositionLeft:
        {
            x = 0;
            y = 0;
            w = width;
            h = view.frame.size.height;
        }
            break;
        case SeperatorLinePositionRight:
        {
            x = view.frame.size.width - width;
            y = 0;
            w = width;
            h = view.frame.size.height;
        }
            break;
        case SeperatorLinePositionTop:
        {
            x = 0,
            y = 0,
            w = view.frame.size.width;
            h = width;
        }
            break;
        default:
        {
            x = 0;
            y = view.frame.size.height - width;
            w = view.frame.size.width;
            h = width;
        }
            break;
    }
    
    UIView *vSeperator = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    vSeperator.backgroundColor = color;
    [view addSubview:vSeperator];
}
+ (void)setText:(NSString *)text withHeaderTextRed:(NSString *)headText onTextField:(UITextField *)tf{
    if (isEmptyString(text)) {
        return;
    }
    if (isEmptyString(headText)) {
        return;
    }
    NSString *strNew = [NSString stringWithFormat:@"%@%@", headText, text];
    NSMutableAttributedString *mStrNew = [[NSMutableAttributedString alloc]initWithString:strNew];
    NSRange rg = [strNew rangeOfString:headText];
    [mStrNew addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rg];
    tf.attributedText = mStrNew;
}

//单独定义一个方法，设置UITextField的属性
+ (void)setTextFieldStyle:(UITextField *)texfField withLeftViewName:(NSString *)name leftViewFrame:(CGRect)frame  withBorderColor:(UIColor *)color CornerRadius:(float)width andIsCenter:(BOOL)isCenterModel{
    
    UIImageView *imgv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
    imgv.frame = frame;
    texfField.leftView = imgv;
    texfField.leftViewMode = UITextFieldViewModeAlways;
    if (isCenterModel) {
        imgv.contentMode = UIViewContentModeCenter;
    }
    texfField.layer.borderWidth = width;
    texfField.layer.borderColor = color.CGColor;
}

@end
