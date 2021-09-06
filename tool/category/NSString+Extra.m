//
//  NSString+Extra.m
//  CashierChoke
//
//  Created by zjs on 2019/9/16.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "NSString+Extra.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Extra)

// @"(null)", @"null", nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
- (BOOL)dn_isValidString{
    // 判断是否为空
    if (self == nil ||
        self.length == 0 ||
        [self isEqual:[NSNull null]] ||
        [self isEqualToString:@""] ||
        [self isEqual:@"null"] ||
        [self isEqual:@"(null)"]) {
        
        return YES;
    }
    return NO;
}

#pragma mark -- 是否包含某个字符
- (BOOL)dn_containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

#pragma mark -- 去掉头尾两边空格和换行
- (NSString *)dn_stringByTrim {
    NSCharacterSet * set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)dn_cutWihtespace {

    NSMutableString *string = [[NSMutableString alloc] initWithString:self];
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark -- 处理时间 20191128 为 2019-11-28
- (NSString *)dn_dateFormmat {
    
    if (self.length == 8) {
        
        NSString *year = [self substringToIndex:4];
        NSString *mont = [self substringWithRange:NSMakeRange(4, 2)];
        NSString *day  = [self substringWithRange:NSMakeRange(6, 2)];
        
        return [NSString stringWithFormat:@"%@-%@-%@", year, mont, day];
    }
    return self;
}

#pragma mark -- md5 加密
- (NSString *)dn_md5String {
    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    NSString * md5Str = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         result[0],result[1],result[2],result[3],
                         result[4],result[5],result[6],result[7],
                         result[8],result[9],result[10],result[11],
                         result[12],result[13],result[14],result[15]];
    return [md5Str lowercaseString];
}

#pragma mark -- 获取文本字体大小
- (CGSize)dn_getTextSize:(UIFont *)font maxSize:(CGSize)maxSize mode:(NSLineBreakMode)linewdeakMode {
    NSMutableDictionary * attributeDict = [[NSMutableDictionary alloc]init];
    
    attributeDict[NSFontAttributeName] = font;
    if (linewdeakMode != NSLineBreakByWordWrapping) {
        
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = linewdeakMode;
        attributeDict[NSParagraphStyleAttributeName] = paragraphStyle;
    } 
    // 计算文本的 rect
    CGRect rect = [self boundingRectWithSize:maxSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributeDict
                                     context:nil];
    
    return rect.size;
}

#pragma mark -- 获取文本宽度

- (CGFloat)dn_getTextWidth:(UIFont *)font height:(CGFloat)height {
    CGSize size = [self dn_getTextSize:font maxSize:CGSizeMake(MAXFLOAT, height) mode:NSLineBreakByWordWrapping];
    
    return size.width;
}

#pragma mark -- 获取文本高度

- (CGFloat)dn_getTextHeight:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self dn_getTextSize:font maxSize:CGSizeMake(width, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    
    return size.height;
}


///==================================================
///             正则表达式
///==================================================
/** 判断是否是有效的手机号 */
- (BOOL)dn_isValidPhoneNumber {
    NSString *telNumber = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[89]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
     * 电信号段: 133,153,180,181,189,177,173,1700,199
     */
    if (telNumber.length == 11) {
        
//        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";
//        // 移动正则
//        NSString *CM_NUM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
//        // 联通正则
//        NSString *CU_NUM = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
//        // 电信正则
//        NSString *CT_NUM = @"(^1(33|49|53|73|77|8[019]|91|99)\\d{8}$)|(^1700\\d{7}$)";
//
//        if ([self dn_isValidateByRegex:MOBILE] ||
//            [self dn_isValidateByRegex:CM_NUM] ||
//            [self dn_isValidateByRegex:CU_NUM] ||
//            [self dn_isValidateByRegex:CT_NUM]) {
//            return YES;
//
//        } else {
//            return NO;
//        }
        return YES;
    } else {
        return NO;
    }
}

/** 判断是否是有效的用户密码 */
- (BOOL)dn_isValidPassword {
    // 以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
    NSString *regex = @"^([a-zA-Z]|[a-zA-Z0-9_]|[0-9]){6,18}$";
    return [self dn_isValidateByRegex:regex];
}

- (BOOL)dn_isValidPwdContainNumAndChar {
    // 是否包含一个大写一个小写 6~20 位
    NSString *regex =@"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    return [self dn_isValidateByRegex:regex];
}

/** 判断是否是有效的用户名（20位的中文或英文）*/
- (BOOL)dn_isValidUserName {
    NSString *regex = @"^[a-zA-Z一-龥]{1,20}";
    return [self dn_isValidateByRegex:regex];
}

/** 判断是否是有效的邮箱 */
- (BOOL)dn_isValidEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self dn_isValidateByRegex:regex];
}

/** 判断是否是有效的URL */
- (BOOL)isValidUrl {
    NSString *regex = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    return [self dn_isValidateByRegex:regex];
}

/** 判断是否是有效的银行卡号 */
- (BOOL)dn_isValidBankNumber {
    NSString *regex =@"^\\d{16,19}$|^\\d{6}[- ]\\d{10,13}$|^\\d{4}[- ]\\d{4}[- ]\\d{4}[- ]\\d{4,7}$";
    return [self dn_isValidateByRegex:regex];
}

/** 判断是否是有效的身份证号 */
- (BOOL)dn_isValidIDCardNumber {
    NSString * value = self;
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!value) {
        return NO;
        
    } else {
        length = value.length;
        if (length != 15 && length != 18) {
            return NO;
        }
    }
    //
    NSArray * areaArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString * valueStart = [value substringToIndex:2];
    BOOL areaFlag= NO;
    for (NSString * areaCode in areaArray) {
        
        if ([areaCode isEqualToString:valueStart]) {
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression * regularExpression;
    NSUInteger numberOfMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6, 2)].intValue + 1900;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];;
            }
            numberOfMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if (numberOfMatch > 0) {
                return year;
            } else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];
            }
            numberOfMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if (numberOfMatch > 0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                // 判断校验位
                M = [JYM substringWithRange:NSMakeRange(Y,1)];
                NSString *validateData = [value substringWithRange:NSMakeRange(17,1)];
                validateData = [validateData uppercaseString];
                
                if ([M isEqualToString:validateData]) {
                    return YES;
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
        default:
            return NO;
    }
}

/** 判断是否是有效的IP地址 */
- (BOOL)dn_isValidIPAddress {
    NSString *regex = [NSString stringWithFormat:@"^(\\\\d{1,3})\\\\.(\\\\d{1,3})\\\\.(\\\\d{1,3})\\\\.(\\\\d{1,3})$"];
    BOOL rc = [self dn_isValidateByRegex:regex];
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        return v;
    }
    return NO;
}

/** 判断是否是纯汉字 */
- (BOOL)dn_isValidChinese {
    NSString *regex = @"^[\\u4e00-\\u9fa5]+$";
    return [self dn_isValidateByRegex:regex];
}

/** 判断是否是邮政编码 */
- (BOOL)dn_isValidPostalcode {
    NSString *regex = @"^[0-8]\\\\d{5}(?!\\\\d)$";
    return [self dn_isValidateByRegex:regex];
}

/** 判断是否是工商税号 */
- (BOOL)dn_isValidTaxNo {
    NSString *regex = @"[0-9]\\\\d{13}([0-9]|X)$";
    return [self dn_isValidateByRegex:regex];
}

/** 判断是否是车牌号 */
- (BOOL)dn_isCarNumber {
    // 车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    // 其中\\u4e00-\\u9fa5表示unicode编码中汉字已编码部分，\\u9fa5-\\u9fff是保留部分，将来可能会添加
    NSString *regex = @"^[\\u4e00-\\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\\u4e00-\\u9fff]$";
    return [self dn_isValidateByRegex:regex];
}

/** 通过身份证获取性别（1:男, 2:女） */
- (nullable NSNumber *)dn_getGenderFromIDCard {
    if (self.length < 16) return nil;
    NSUInteger lenght = self.length;
    NSString *sex = [self substringWithRange:NSMakeRange(lenght - 2, 1)];
    if ([sex intValue] % 2 == 1) {
        return @1;
    }
    return @2;
}

- (NSString *)dn_secretBankCardNumber {
    
    if (self.length < 4) {
        return self;
    }
    NSString *backStr = [self substringFromIndex:(self.length - 4)];
    return [NSString stringWithFormat:@"****     ****     ****     %@", backStr];
}

/** 隐藏证件号指定位数字（如：360723********6341） */
- (nullable NSString *)dn_hideCharacters:(NSUInteger)location length:(NSUInteger)length {
    if (self.length > length && length > 0) {
        if (self.length >= location+length) {
            NSMutableString *str = [[NSMutableString alloc] init];
            for (NSInteger i = 0; i < length; i++) {
                [str appendString:@"*"];
            }
            return [self stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:[str copy]];
        } else {
            return self;
        }
    }
    return self;
}

#pragma mark - 匹配正则表达式的一些简单封装
- (BOOL)dn_isValidateByRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}


- (RangeFormatType)checkRange:(NSRange)range {
    NSInteger loc = range.location;
    NSInteger len = range.length;
    
    if (loc >= 0 && len > 0) {
        
        if (loc + len <= self.length) {
            
            return RangeCorrect;
        }else{
            DNLog(@"The range out-of-bounds!");
            return RangeOut;
        }
    }else{
        DNLog(@"The range format is wrong: NSMakeRange(a,b) (a>=0,b>0). ");
        return RangeError;
    }
}

#pragma mark - 改变单个范围字体的大小和颜色
// 单个范围设置字体颜色
- (NSMutableAttributedString *)dn_changeColor:(UIColor *)color andRange:(NSRange)range {
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:self];       
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributedStr;
}
// 单个范围内设置字体大小
- (NSMutableAttributedString *)dn_changeFont:(UIFont *)font andRange:(NSRange)range {
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    
    if ([self checkRange:range] == RangeCorrect) {
        
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:range];
        } else {
            DNLog(@"font is nil...");
        }
    }
    return attributedStr;
}
// 单个范围设置字体颜色和大小
- (NSMutableAttributedString *)dn_changeColor:(UIColor *)color andColorRang:(NSRange)colorRange andFont:(UIFont *)font andFontRange:(NSRange)fontRange {
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    
    if ([self checkRange:colorRange] == RangeCorrect) {
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
        } else {
            DNLog(@"color is nil");
        }
    }
    
    if ([self checkRange:fontRange] == RangeCorrect) {
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:fontRange];
        } else {
            DNLog(@"font is nil...");
        }
    }
    return attributedStr;
}

#pragma mark - 改变多个范围内的字体和颜色
// 多个范围设置字体颜色
- (NSMutableAttributedString *)dn_changeColor:(UIColor *)color andRanges:(NSArray<NSValue *> *)ranges {
    __block NSMutableAttributedString * attrinbutedStr = [[NSMutableAttributedString alloc]initWithString:self];
    
    if (color) {
        [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSRange range = [(NSValue *)obj rangeValue];
            if ([self checkRange:range] == RangeCorrect) {
                [attrinbutedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            } else {
                DNLog(@"index:%lu",(unsigned long)idx);
            }
        }];
    } else {
        
        DNLog(@"color is nil...");
    }
    return attrinbutedStr;
}
// 多个范围设置字体大小
- (NSMutableAttributedString *)dn_changeFont:(UIFont *)font andRanges:(NSArray<NSValue *> *)ranges {
    __block NSMutableAttributedString * attrinbutedStr = [[NSMutableAttributedString alloc]initWithString:self];
    
    if (font) {
        [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSRange range = [(NSValue *)obj rangeValue];
            if ([self checkRange:range] == RangeCorrect) {
                [attrinbutedStr addAttribute:NSFontAttributeName value:font range:range];
            } else {
                DNLog(@"index:%lu",(unsigned long)idx);
            }
        }];
    } else {
        
        DNLog(@"font is nil...");
    }
    return attrinbutedStr;
}
// 多个范围设置字体颜色和大小
- (NSMutableAttributedString *)dn_changeColorAndFont:(NSArray<NSDictionary *> *)changes {
    __block NSMutableAttributedString * attrinbutedStr = [[NSMutableAttributedString alloc]initWithString:self];
    [changes enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIColor *color = obj[XCColorKey];
        UIFont *font = obj[XCFontKey];
        NSArray<NSValue *> *ranges = obj[XCRangeKey];
        
        if (!color) {
            DNLog(@"warning: NSColorKey -> nil! index:%lu",(unsigned long)idx);
        }
        if (!font) {
            DNLog(@"warning: NSFontKey -> nil! index:%lu",(unsigned long)idx);
        }
        
        if (ranges.count > 0) {
            [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSRange range = [obj rangeValue];
                if ([self checkRange:range] == RangeCorrect) {
                    
                    if (color) {
                        [attrinbutedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                    }
                    if (font) {
                        [attrinbutedStr addAttribute:NSFontAttributeName value:font range:range];
                    }
                } else {
                    DNLog(@"index:%lu",(unsigned long)idx);
                }
            }];
        } else {
            DNLog(@"warning: NSRangeKey -> nil! index:%lu",(unsigned long)idx);
        }
    }];
    return attrinbutedStr;
}

#pragma mark - 给字符串添加中划线
/** 添加中划线 */
- (NSMutableAttributedString *)dn_addCenterLine {
    NSDictionary * attributeDict = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attributeDict];
    
    return attributedStr;
}

#pragma mark - 给字符串添加下划线
/** 添加下划线 */
- (NSMutableAttributedString *)dn_addDownLine {
    NSDictionary * attributeDict = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attributeDict];
    
    return attributedStr;
}

+ (NSString *)dn_timeWithTimeIntervalString:(NSString *)timeString {
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)dn_timeSSWithTimeIntervalString:(NSString *)timeString {
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

- (NSString *)dn_timeWithTimeFormmater:(NSString *)formatterStr {
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatterStr];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

- (NSString *)dn_dateRangeForUnit:(NSCalendarUnit)calendarUnit format:(NSString *)format {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    NSDate *newDate = [dateFormat dateFromString:self];
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:calendarUnit startDate:&beginDate interval:&interval forDate:newDate];

    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString   = [myDateFormatter stringFromDate:endDate];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@ %@",beginString,endString];

    return dateStr;
}

//对非法字符串进行处理
- (NSString *)stringConvertSafeContent {
    NSString *string;
    if ([self isEqual:[NSNull null]]) {
        string = @"";
    } else {
        if (self == nil) {
            string = @"";
        } else {
            string = self;
        }
    }
    return string;
}

/// 需要该字符是否为中文
/// @param firstStr 所需判断的字符
-(BOOL)isChineseFirst:(NSString *)firstStr
{
    //是否以中文开头(unicode中文编码范围是0x4e00~0x9fa5)
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength->buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [firstStr getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        return YES;
    else
        return NO;
}

/// 判断字符串中是否包含数字
- (BOOL)containtValidateNumber {
    BOOL res = NO;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789一二三四五六七八九十"];
    int i = 0;
    while (i < self.length) {
        NSString *string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length > 0) {
            res = YES;
            break;
        }
        i++;
    }
    return res;
}
- (NSString *)contentTranslationChinese {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
}

- (BOOL)isPureNumandCharacters:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0) {
        return NO;
    }
    return YES;
}

+ (NSString *)stringWitnNum:(NSInteger)num {
    NSString *content;
    if (num > 99) {
        content = @"99+";
    } else {
        if (num == 0) {
            content = nil;
        } else {
            content = [NSString stringWithFormat:@"%tu", num];
        }
    }
    return content;
}

@end
