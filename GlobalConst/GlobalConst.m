//
//  GlobalConst.m
//
//
//  Created by Josh_Lv on 16/5/11.
//  Copyright © 2016年 Josh_Lv. All rights reserved.
//

#import "GlobalConst.h"

#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

#pragma mark -- 正则表达式进行的判断
BOOL checkEmail(NSString *emailString)
{
    NSString * regex = @"^([a-z0-9A-Z]+[-|\\._]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:emailString];
    return isMatch;
}
BOOL checkUrl(NSString *urlString)
{
    
    NSString * regex = @"^\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:urlString];
    return isMatch;
    
}
BOOL isTelephone(NSString *candidate)
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString * China = @"\\d{3}-\\d{8}|\\d{4}-\\d{7}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regextestchina = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", China];
    
    return  [regextestmobile evaluateWithObject:candidate]   ||
    [regextestphs evaluateWithObject:candidate]      ||
    [regextestct evaluateWithObject:candidate]       ||
    [regextestcu evaluateWithObject:candidate]       ||
    [regextestcm evaluateWithObject:candidate]       ||
    [regextestchina evaluateWithObject:candidate];
}
/**
 *  判断中文字符
 *
 *  @param chinaStr 需要判断的中文字符
 *
 *  @return 返回判断结果，true为真
 */
BOOL isChinese(NSString *chinaStr)
{
    
    NSString * MOBILE = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:chinaStr];
}
/**
 *  得到相同keyValue的字典数组,排序
 *
 *  @param originArr 原始字典数组
 *  @param keyString 需要得到相同字典数组的key值
 *
 *  @return 返回过滤后的字典数组
 */
NSArray *getSameArrWithOriginarr(NSArray *originArr ,NSString *keyString)
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:originArr];
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = array[i];
        NSString *string = [dict valueForKey:keyString];
        
        NSMutableArray *tempArray = [@[] mutableCopy];
        
        [tempArray addObject:dict];
        
        for (int j = i+1; j < array.count; j ++) {
            NSDictionary *dict1 = array[j];
            NSString *jstring = [dict1 valueForKey:keyString];
            
            if([string isEqualToString:jstring]){
                [tempArray addObject:dict1];
                [array removeObjectAtIndex:j];
                j -= 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    return dateMutablearray;
}
#pragma mark -- NSDate处理
/**
 *  格式化时间成字符串
 *
 *  @param date            需要格式化的时间
 *  @param formatterString 格式化的样式
 *
 *  @return 格式化的最终结果
 */
NSString *dateStringFromDate(NSDate *date,NSString *formatterString)
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterString];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
/**
 *  根据formatter获取当前时间
 *
 *  @param formatterString 格式化的样式
 *
 *  @return 格式化的时间
 */
NSString *getCurrentTimeWithFormatter(NSString *formatterString)
{
    NSString* currentDate;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:formatterString];
    currentDate = [formatter stringFromDate:[NSDate date]];
    
    return currentDate;
}
/**
 *  字符串时间转换成NSDAte
 *
 *  @param dateString      字符串时间
 *  @param formatterString 时间格式
 *
 *  @return 转换后的时间
 */
NSDate *dateFromDateString(NSString *dateString ,NSString *formatterString)
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:formatterString];
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
}
/**
 *  根据时间格式获取当前时间
 *
 *  @param formatterString 时间格式
 *
 *  @return 当前时间
 */
NSDate *getCurrentDateWithFormatter(NSString *formatterString)
{
    NSString *currentString = getCurrentTimeWithFormatter(formatterString);
    NSDate *date = dateFromDateString(currentString, formatterString);
    return date;
}
/**
 *  转换为北京时间，一般来说不需要转换,读取到的就是北京时间
 *
 *  @param data 需要转换的时间
 *
 *  @return 转换后的时间
 */
NSDate *UTF8dateForGMT(NSDate *data)
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:data];
    
    NSDate *localeDate = [data  dateByAddingTimeInterval:interval];
    
    return localeDate;
}
/**
 *  比较两个时间值大小
 *
 *  @param compareDate1 时间1
 *  @param compareDate2 时间2
 *
 *  @return 比较结果
 */
NSComparisonResult compareDate(NSDate *compareDate1,NSDate *compareDate2)
{
    switch ([compareDate1 compare:compareDate2]) {
        case NSOrderedSame:return NSOrderedSame;break;
        case NSOrderedAscending:return NSOrderedAscending;break;
        case NSOrderedDescending:return NSOrderedDescending; break;
        default:NSLog(@"时间非法");break;
    }
    return NSOrderedSame;
}
/**
 *  获取两个时间段差值
 *
 *  @param date1
 *  @param date2
 *
 *  @return 差值s
 */
double timeDiff(NSDate *date1, NSDate *date2)
{
    NSTimeInterval timeDiff = 0.0;
    timeDiff = [date2 timeIntervalSinceDate:date1];
    return timeDiff;
}
double timeDiffWithTimeString(NSString *dateString1, NSString *dateString2,NSString *formatter)
{
    NSTimeInterval time = 0.0;
    
    NSDateFormatter *forM = [[NSDateFormatter alloc] init];
    [forM setDateFormat:formatter];
    
    NSDate *date1 = [forM dateFromString:dateString1];
    NSDate *date2 = [forM dateFromString:dateString2];
    time= timeDiff(date1, date2);
    return time;
}
#pragma mark -- 文件处理
/**
 *  获取Cache文件路径
 */
NSString *getCachePath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    
    NSString *cachesDir = [paths objectAtIndex:0];
    
    return cachesDir;
}
/**
 *  获取Domain文件路径
 */
NSString *getDomainPath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *dominDir = [paths objectAtIndex:0];
    
    return dominDir;
}
/**
 *  保存数据到指定路径下
 *
 *  @param pathDircetor 沙盒路径
 *  @param anyData      数据
 *  @param fileName     文件名
 *
 *  @return 是否保存成功
 */
BOOL saveData(NSSearchPathDirectory pathDircetor, id anyData, NSString *fileName)
{
    BOOL b;
    //获得沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(pathDircetor, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fileN = [path stringByAppendingPathComponent:fileName];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    
    if (!dic) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm createFileAtPath:fileN contents:nil attributes:nil];
        NSData *data = [NSJSONSerialization dataWithJSONObject:anyData options:NSJSONWritingPrettyPrinted error:nil];
        
        b = [data writeToFile:fileN atomically:YES];
        
    }
    return b;
}
/**
 *  获取相应路径下的数据
 *
 *  @param pathDircetor 沙河路径
 *  @param fileName     文件名
 *
 *  @return 得到的数据
 */
id getData(NSSearchPathDirectory pathDircetor, NSString *fileName)
{
    //获得沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(pathDircetor, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fileN = [path stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:fileN];
    return data;
}
/**
 *  删除数据
 *
 *  @param pathDircetor 沙盒路径
 *  @param fileName     文件名
 *
 *  @return true删除成功，false失败
 */
BOOL deleteData(NSSearchPathDirectory pathDircetor, NSString *fileName)
{
    //获得沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(pathDircetor, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fileN = [path stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:fileN];
    if (data) {
        NSFileManager *fm = [NSFileManager defaultManager];
        return [fm removeItemAtPath:fileName error:nil];
    }
    return true;
}
/**
 *  判断时候存在数据
 *
 *  @param pathDircetor 沙盒路径
 *  @param fileName     文件名
 *
 *  @return true存在，false不存在
 */
BOOL isData(NSSearchPathDirectory pathDircetor, NSString *fileName)
{
    //获得沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(pathDircetor, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fileN = [path stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:fileN];
    if (data) {
        return true;
    }
    return false;
}
#pragma mark -- NSString处理
/**
 *  根据文字获取高度
 *
 *  @param attribute 文字限定条件
 *  @param width     限定的宽度
 *  @param text      文字
 *
 *  @return 计算后的高度
 */
CGFloat heightWithStringAttribute(NSDictionary *attribute, CGFloat width, NSString *text)
{
    CGFloat height = 0.f;
    
    if (text.length) {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        
        height = rect.size.height;
    }
    return height;
}

/**
 *  根据文字获取宽度
 *
 *  @param attribute 文字限定条件
 *  @param width     限定的高度
 *  @param text      文字
 *
 *  @return 计算后的宽度
 */
CGFloat widthWithStringAttribute(NSDictionary *attribute, CGFloat height, NSString *text)
{
    CGFloat width = 0.f;
    
    if (text.length) {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        
        width = rect.size.height;
    }
    return width;
}
/**
 *  得到一行文字的高度
 *
 *  @param attribute 限定条件
 *
 */
CGFloat aLineHeightWithStringAttribute(NSDictionary *attribute)
{
    CGFloat height = 0;
    CGRect rect    = [@"Miss" boundingRectWithSize:CGSizeMake(100, MAXFLOAT)
                                           options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil];
    
    height = rect.size.height;
    return height;
}
#pragma mark -- 图像处理
/**
 *  根据数字内容生成相应二维码图标
 *
 *  @param code   需要生成的条形码数字
 *  @param width  需要条形码的宽度
 *  @param height 需要条形码的高度
 *
 *  @return 返回经过128编码后的条形码
 */
UIImage *generateBarCode(NSString *code,CGFloat width,CGFloat height)
{
    // 生成二维码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}
UIImage * imageWithMaxSide(CGFloat length ,UIImage *image){
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = SizeReduce(image.size, length);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);  // 创建一个 bitmap context
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
    
    img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    
    return img;
}
CGSize SizeReduce(CGSize size, CGFloat limit){   // 按比例减少尺寸
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    
    return imgSize;
}
#pragma mark -- MD5加密
/**
 *  MD5加密
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
NSString * MD5(NSString *string)
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 * 根据两地经纬度，计算两地距离
 */
CGFloat getDistance(CGFloat localLatitude,CGFloat localLongitude,CGFloat otherLatitude,CGFloat otherLongitude){
    if (localLatitude == 0 || localLongitude == 0 || otherLatitude == 0 || otherLongitude== 0) {
        return 0;
    }
    CLLocation * originLocation = [[CLLocation alloc] initWithLatitude:localLatitude longitude:localLongitude];
    CLLocation *desLocation = [[CLLocation alloc] initWithLatitude:otherLatitude longitude:otherLongitude];
    
    CGFloat distance = [originLocation distanceFromLocation:desLocation]/1000 ;
    return distance;
}
#pragma mark -- 颜色转换
/**
 * 颜色转换
 */
UIColor * colorWithRed(CGFloat red ,CGFloat green ,CGFloat blue ,CGFloat alpha)
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}
UIColor * colorWithHexString(NSString *color ,CGFloat alpha)
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
