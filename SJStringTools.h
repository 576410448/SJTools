//
//  SJStringTools.h
//  SJTools
//
//  Created by shenj on 16/3/7.
//  Copyright © 2016年 shenj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SJStringTools : NSObject

#pragma mark - --------------------------字符串常规处理--------------------------
/**
 *  判断字符串是否为空，空字符串或nil返回YES
 *
 *  @param str 传入字符串
 *
 *  @return bool
 */
BOOL isEmptyString(NSString *string);

/**
 *  判断字符串是否相等
 *
 *  @param string1 string1
 *  @param string2 string2
 *
 *  @return 返回bool
 */
BOOL isEqualString(NSString *string1, NSString *string2);

/**
 *  判断是否是电话号码
 *
 *  @param mobileNum 传入电话号码
 *
 *  @return 返回 bool
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  判断是否是手机号
 *
 *  @param mobileNum 传入手机号
 *
 *  @return 返回bool
 */
+ (BOOL)isMobilePhoneNumber:(NSString *)mobileNum;

/**
 *   验证是否是合法的身份证号码
 *
 *   @param value 传入身份证号码
 *
 *   @return 返回bool
 */
+ (BOOL)verifyIDCardNumber:(NSString *)value;

/**
 *  去除转义字符
 *
 *  @param unicodeStr 传入字符
 *
 *  @return 返回处理过的字符
 */
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

/**
 *  去除浮点数多余的0 （20.000 -》 @"20"）
 *
 *  @param floatValue 传入float浮点数
 *
 *  @return 返回字符串
 */
+ (NSString *)remove0WithFloat:(float)floatValue;

#pragma mark - --------------------------功能性扩展---------------------------
#pragma mark - URL 签名
/**
 *  为需要打开的url添加用户的token信息作为参数并进行参数签名
 *  @param aURL 需处理的url
 *  @return 处理过的url
 */
+ (NSURL *)appendUserTokenToURL:(NSURL *)aURL;

/**
 *  为现有的url 添加 参数签名
 *  @param aURL 需处理的url
 *  @return 处理过的url
 */
+ (NSURL *)getUrlWithUserInfoSignatureAppended:(NSURL *)aURL;

/**
 *  通过firstname和lastname来获取通讯录中的完成姓名字符串
 *
 *  @param firstname firstname
 *  @param lastname  lastname
 *
 *  @return fullname
 */
+ (NSString *)getNameStringWithFirstname:(NSString *)firstname lastname:(NSString *)lastname;

/**
 *  改通过carType取车型名称，后台更改车型这里也要同步
 *
 *  @param carTypeIndex 车型
 *
 *  @return 车型名称字符串
 */
+ (NSString *)getCarType:(NSString *)carTypeIndex;

/**
 *  获取星期x
 *
 *  @param weekday 传入字符串 Mon
 *
 *  @return 返回 monday
 */
+ (NSString *)checkWeekday:(NSString *)weekday;

/**
 *  获取日期字符串 如10月8日 8替换成08
 *
 *  @param integer 8
 *
 *  @return 08
 */
+ (NSString *)dateString:(NSInteger)integer;


/**
 *  得到人民币符号切人民币符号比较小的nsmutableAttributedString
 *
 *  @param string   传入字符
 *  @param fontSize 字体大小差异
 *
 *  @return 组合string
 */
+ (NSMutableAttributedString *)rmbSymbolString:(NSString *)string withFontSize:(CGFloat)fontSize;
+ (NSMutableAttributedString *)delLineString:(NSString *)string;
/**
 *  返回前几个字为红色的字符串
 *
 *  @param aString 后面的字符串
 *  @param hString 前面的字符串
 *
 *  @return 目标字符串
 */
+ (NSMutableAttributedString *)trailString:(NSString *)tString appendHeadString:(NSString *)hString;
/**
 *  截取url中特定字段
 *
 *  @param url    urlString
 *  @param needle 分割元素
 *
 *  @return 截取的字段
 */
+ (NSString *)getStringFromUrl: (NSString*) url needle:(NSString *) needle;

/**
 *  去除空白和换行
 */
+ (NSString *)stringByReplaceWhiteSpaceAndNewLineWhiteSpace:(NSString *)oldString;
/**
 *  nsstring转nsdate
 *
 *  @param string         nsstring
 *  @param formaterString dateform
 *
 *  @return nsdate
 */
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormaterString:(NSString *)formaterString;

/**
 *  格式化float类型的数据
 *
 *  @param price    float
 *  @param position 保留的最长位数
 *
 *  @return 格式化后的数据
 */
+ (NSString *)notRounding:(double)price afterPoint:(int)position;

/*
 *   @param stopTime 服务器返回的结束时间
 *
 *   @return 结束时间减去当前时间,得到的时间差,转换成具体天数
 *
 */
+ (NSString *)overdueTimeWith:(NSString *)time;

@end
