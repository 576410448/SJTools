//
//  SJStringTools.m
//  SJTools
//
//  Created by shenj on 16/3/7.
//  Copyright © 2016年 shenj. All rights reserved.
//

#import "SJStringTools.h"

@implementation SJStringTools
BOOL isEmptyString(NSString *string) {
    return !string || [string isEqual:[NSNull null]] || ([string isKindOfClass:[NSString class]] && [@"" isEqualToString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]);
}

BOOL isEqualString(NSString *string1, NSString *string2) {
    BOOL isEmpty = isEmptyString(string1);
    if (isEmpty && isEmptyString(string2)) {
        return YES;
    }
    
    if (isEmpty) {
        return NO;
    }
    
    return [string1 isEqualToString:string2];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";


    NSString *CG = @"^((0\\d{2,3})\\-)?(\\d{7,8})?(\\-(\\d{3,}))?$";

    NSPredicate *regextestcCG = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CG];
    return ([regextestcCG evaluateWithObject:mobileNum]) || [SJStringTools isMobilePhoneNumber:mobileNum];
}

+ (BOOL)isMobilePhoneNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,184 补充 152,178，183
     * 联通：130,131,132,155,156,185,186 补充 176,145,147 删除 152
     * 电信：133,1349,153,180,189,181  补充 170,177,134
     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,184 补充 152,178，183
     */
    NSString *CM = @"^((\\+86)|(\\(\\+86\\))|(86))?(1(34(\\-)?[0-8]|3[5-9](\\-)?[0-9]|5[0-27-9](\\-)?[0-9]|8[2-478](\\-)?[0-9]|7[8](\\-)?[0-9]))\\d{3}(\\-?)\\d{4}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186 补充 176,145,147 删除 152
     */
    NSString *CU = @"^((\\+86)|(\\(\\+86\\))|(86))?(1(3[0-2]|5[56]|8[56]|7[6]|4[57]))(\\-)?\\d{4}(\\-)?\\d{4}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189,1811 补充 170,177,134,181
     */
    NSString *CT = @"^((\\+86)|(\\(\\+86\\))|(86))?(1(3[34]|53|8[019]|7[07]))(\\-)?\\d{4}(\\-)?\\d{4}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
    
    //实现手机号前带86或是+86的情况:
    NSString *C86  = @"^((\\+86)|(\\(\\+86\\))|(86))?(1(3[0-9]|5[0-35-9]|8[0-9]))(\\-)?\\d{4}(\\-)?\\d{4}$";
    
    
    
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestc86 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", C86];
    
    if (/*([regextestmobile evaluateWithObject:mobileNum] == YES)
         || */ ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestc86 evaluateWithObject:mobileNum] == YES)) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSString *tempStr4 = [tempStr3 stringByReplacingOccurrencesOfString:@"    " withString:@""];
    NSData *tempData = [tempStr4 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    //NSLog(@"Output = %@", returnStr);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

+ (NSString *)remove0WithFloat:(float)floatValue
{
    NSString *str = [NSString stringWithFormat:@"%f",floatValue];
    NSUInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}


//+ (NSURL *)appendUserTokenToURL:(NSURL *)aURL {
//    NSString *nonce = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
//    NSString *token = [BTDataManager defaultManager].userInfo.token;
//
//    if (!token || [token isEqualToString:@""]) {
//        return aURL;
//    }
//
//    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@", aURL];
//
//    if ([urlString rangeOfString:@"?"].location == NSNotFound) {
//        [urlString appendFormat:@"?"];
//    }
//    else {
//        [urlString appendFormat:@"&"];
//    }
//
//    [urlString appendString:[NSString stringWithFormat:@"nonce=%@&token=%@", nonce, token]];
//
//    return [SJStringTools getUrlWithUserInfoSignatureAppended:[NSURL URLWithString:urlString]];
//}

//+ (NSURL *)getUrlWithUserInfoSignatureAppended:(NSURL *)aURL {
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[SJStringTools dictionaryFromQuery:aURL.query usingEncoding:NSUTF8StringEncoding]];
//
//    //没有参数带进来 无法签名
//    if (!params || params.allKeys.count == 0) {
//        return aURL;
//    }
//
//    NSString *signature = [[BTSecurityManager sharedInstance] MD5SignatureWithUrlEncoded:params withSecret:[BTDataManager defaultManager].userInfo.sd];
//
//    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@", aURL];
//
//    [urlString appendString:[NSString stringWithFormat:@"&sig=%@", signature]];
//
//    return [NSURL URLWithString:urlString];
//}

//获取url中的参数字符串 并且转换成 字典
+ (NSDictionary *)dictionaryFromQuery:(NSString *)query usingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
    NSScanner *scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString *pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray *kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString *key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString *value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

#pragma mark - Firstname & Lastname
+ (NSString *)getNameStringWithFirstname:(NSString *)firstname lastname:(NSString *)lastname {
    if (!firstname) {
        firstname = @"";
    }
    if (!lastname) {
        lastname = @"";
    }
    
    NSString *fullNameString = [NSString stringWithFormat:@"%@%@", firstname, lastname];
    BOOL isEnglishName = NO;
    for (int i = 0; i < fullNameString.length; i++) {
        unichar c  = [fullNameString characterAtIndex:i];
        int asciiIndex = c;
        if (asciiIndex >= 0x4E00 && asciiIndex <= 0x9FFF) {
        }
        else {
            //只要 姓名字符串里有哪怕一个英文字符串，则当成英文名处理
            isEnglishName = YES;
        }
    }
    
    NSString *namestring;
    //根据系统语言是否为中文 来区分顺序
    if (isEnglishName) {
        namestring = [NSString stringWithFormat:@"%@ %@", firstname, lastname];
    }
    else {
        namestring = [NSString stringWithFormat:@"%@%@", lastname, firstname];
    }
    return namestring;
}

+ (NSString *)getCarType:(NSString *)carTypeIndex {
    int index = [carTypeIndex intValue];
    NSString *carType = @"";
    switch (index) {
        case 1:
            carType = NSLocalizedString(@"economy", nil);
            break;
            
        case 2:
            carType = NSLocalizedString(@"comfort", nil);
            break;
            
        case 3:
            carType = NSLocalizedString(@"businessCarType", nil);
            break;
            
        case 4:
            carType = NSLocalizedString(@"luxury", nil);
            break;
            
        case 5:
            carType = NSLocalizedString(@"economy", nil);   //NSLocalizedString(@"cheapSelf", nil);
            break;
            
        case 6:
            carType = NSLocalizedString(@"comfort", nil);   //NSLocalizedString(@"comfortableSelf", nil);
            break;
            
        case 7:
            carType = NSLocalizedString(@"businessCarType", nil);   //NSLocalizedString(@"business-TypeSelf", nil);
            break;
            
        case 8:
            carType = NSLocalizedString(@"luxury", nil);   //NSLocalizedString(@"luxurySelf", nil);
            
        default:
            break;
    }
    return carType;
}

+ (NSString *)checkWeekday:(NSString *)weekday {
    NSString *backStr = @"";
    
    if ([weekday isEqualToString:@"Mon"]) {
        backStr = NSLocalizedString(@"monday", nil);
    }
    else if ([weekday isEqualToString:@"Tue"]) {
        backStr = NSLocalizedString(@"tuesday", nil);
    }
    else if ([weekday isEqualToString:@"Wed"]) {
        backStr = NSLocalizedString(@"wednesday", nil);
    }
    else if ([weekday isEqualToString:@"Thu"]) {
        backStr = NSLocalizedString(@"thursday", nil);
    }
    else if ([weekday isEqualToString:@"Fri"]) {
        backStr = NSLocalizedString(@"friday", nil);
    }
    else if ([weekday isEqualToString:@"Sat"]) {
        backStr = NSLocalizedString(@"saturday", nil);
    }
    else if ([weekday isEqualToString:@"Sun"]) {
        backStr = NSLocalizedString(@"sunday", nil);
    }
    else {
    }
    
    return backStr;
}

+ (NSString *)dateString:(NSInteger)integer {
    if (integer < 10) {
        return [NSString stringWithFormat:@"0%ld", (long)integer];
    }
    else {
        return [NSString stringWithFormat:@"%ld", (long)integer];
    }
}


+ (NSMutableAttributedString *)rmbSymbolString:(NSString *)string withFontSize:(CGFloat)fontSize{
    NSString *rmbString = [NSString stringWithFormat:@"￥%@",string];
    NSMutableAttributedString *strReturn = [[NSMutableAttributedString alloc]initWithString:rmbString];
    [strReturn addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize - 4] range:NSMakeRange(0, 1)];
    return strReturn;
}
+ (NSMutableAttributedString *)delLineString:(NSString *)string{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *strReturn = [[NSMutableAttributedString alloc]initWithString:string attributes:attribtDic];
    return strReturn;
}
+ (NSMutableAttributedString *)trailString:(NSString *)tString appendHeadString:(NSString *)hString{
    NSString *strNew = [NSString stringWithFormat:@"%@|%@", hString , tString];
    NSMutableAttributedString *mStrNew = [[NSMutableAttributedString alloc]initWithString:strNew];
    NSRange rg = [strNew rangeOfString:hString];
    [mStrNew addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rg];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];//调整行间距
    [mStrNew addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [strNew length])];
    return mStrNew;
}
+ (NSString *) getStringFromUrl: (NSString*) url needle:(NSString *) needle {
    NSString * str = nil;
    NSRange start = [url rangeOfString:needle];
    if (start.location != NSNotFound) {
        NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
        NSUInteger offset = start.location+start.length;
        str = end.location == NSNotFound
        ? [url substringFromIndex:offset]
        : [url substringWithRange:NSMakeRange(offset, end.location)];
        str = str.stringByRemovingPercentEncoding;
    }
    return (str == nil||[str isEqual:[NSNull null]])?@"":str;
}
+ (NSString *)stringByReplaceWhiteSpaceAndNewLineWhiteSpace:(NSString *)oldString{
    NSString *strReturn = [oldString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [strReturn stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormaterString:(NSString *)formaterString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formaterString];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}
+ (NSString *)notRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

/**
 *
 * 验证身份证
 * 必须满足以下规则
 * 1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
 * 2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
 * 3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
 * 4. 第17位表示性别，双数表示女，单数表示男
 * 5. 第18位为前17位的校验位
      算法如下：
 * （1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
 * （2）余数 ＝ 校验和 % 11
 * （3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
 * 6. 出生年份的前 必须是19或20
 *
 */
+ (BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

+ (NSString *)overdueTimeWith:(NSString *)time {
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //得到两个日期对象
    NSDate *date=[NSDate date];
    NSString *curdate=[dateFormatter stringFromDate:date];
    NSDate *dateOver=[dateFormatter dateFromString:[NSString stringWithFormat:@"%@",time]];
    NSDate *currentDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",curdate]];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval overTime=[dateOver timeIntervalSinceDate:currentDate];
    
    int days=((int)overTime)/(3600*24);
    days = days + 1;//这里考虑到剩余为0天的情况，也就是只剩当天一天，故加1//
    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i",days];
    return dateContent;
}
@end
