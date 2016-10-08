//
//  GlobalConst.h
//  yyt
//
//  Created by Josh_Lv on 16/5/11.
//  Copyright © 2016年 Josh_Lv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



BOOL checkEmail(NSString *emailString);turn isMatch;
}
BOOL checkUrl(NSString *urlString);
BOOL isTelephone(NSString *candidate);
/**
 *  判断中文字符
 *
 *  @param chinaStr 需要判断的中文字符
 *
 *  @return 返回判断结果，true为真
 */
BOOL isChinese(NSString *chinaStr);
/**
 *  得到相同keyValue的字典数组,排序
 *
 *  @param originArr 原始字典数组
 *  @param keyString 需要得到相同字典数组的key值
 *
 *  @return 返回过滤后的字典数组
 */
NSArray *getSameArrWithOriginarr(NSArray *originArr ,NSString *keyString);
/**
 *  格式化时间成字符串
 *
 *  @param date            需要格式化的时间
 *  @param formatterString 格式化的样式
 *
 *  @return 格式化的最终结果
 */
NSString *dateStringFromDate(NSDate *date,NSString *formatterString);
/**
 *  根据formatter获取当前时间
 *
 *  @param formatterString 格式化的样式
 *
 *  @return 格式化的时间
 */
NSString *getCurrentTimeWithFormatter(NSString *formatterString);
/**
 *  字符串时间转换成NSDAte
 *
 *  @param dateString      字符串时间
 *  @param formatterString 时间格式
 *
 *  @return 转换后的时间
 */
NSDate *dateFromDateString(NSString *dateString ,NSString *formatterString);
/**
 *  根据时间格式获取当前时间
 *
 *  @param formatterString 时间格式
 *
 *  @return 当前时间
 */
NSDate *getCurrentDateWithFormatter(NSString *formatterString);
/**
 *  转换为北京时间，一般来说不需要转换,读取到的就是北京时间
 *
 *  @param data 需要转换的时间
 *
 *  @return 转换后的时间
 */
NSDate *UTF8dateForGMT(NSDate *data);
/**
 *  比较两个时间值大小
 *
 *  @param compareDate1 时间1
 *  @param compareDate2 时间2
 *
 *  @return 比较结果
 */
NSComparisonResult compareDate(NSDate *compareDate1,NSDate *compareDate2);
/**
 *  获取两个时间段差值
 *
 *  @param date1
 *  @param date2
 *
 *  @return 差值s
 */
double timeDiff(NSDate *date1, NSDate *date2);
double timeDiffWithTimeString(NSString *dateString1, NSString *dateString2,NSString *formatter);
#pragma mark -- 文件处理
/**
 *  获取Cache文件路径
 */
NSString *getCachePath();
/**
 *  获取Domain文件路径
 */
NSString *getDomainPath();
/**
 *  保存数据到指定路径下
 *
 *  @param pathDircetor 沙盒路径
 *  @param anyData      数据
 *  @param fileName     文件名
 *
 *  @return 是否保存成功
 */
BOOL saveData(NSSearchPathDirectory pathDircetor, id anyData, NSString *fileName);
/**
 *  获取相应路径下的数据
 *
 *  @param pathDircetor 沙河路径
 *  @param fileName     文件名
 *
 *  @return 得到的数据
 */
id getData(NSSearchPathDirectory pathDircetor, NSString *fileName);
/**
 *  删除数据
 *
 *  @param pathDircetor 沙盒路径
 *  @param fileName     文件名
 *
 *  @return true删除成功，false失败
 */
BOOL deleteData(NSSearchPathDirectory pathDircetor, NSString *fileName);
/**
 *  判断时候存在数据
 *
 *  @param pathDircetor 沙盒路径
 *  @param fileName     文件名
 *
 *  @return true存在，false不存在
 */
BOOL isData(NSSearchPathDirectory pathDircetor, NSString *fileName);
/**
 *  根据文字获取高度
 *
 *  @param attribute 文字限定条件
 *  @param width     限定的宽度
 *  @param text      文字
 *
 *  @return 计算后的高度
 */
CGFloat heightWithStringAttribute(NSDictionary *attribute, CGFloat width, NSString *text);
/**
 *  根据文字获取宽度
 *
 *  @param attribute 文字限定条件
 *  @param width     限定的高度
 *  @param text      文字
 *
 *  @return 计算后的宽度
 */
CGFloat widthWithStringAttribute(NSDictionary *attribute, CGFloat height, NSString *text);
/**
 *  得到一行文字的高度
 *
 *  @param attribute 限定条件
 *
 */
CGFloat aLineHeightWithStringAttribute(NSDictionary *attribute);
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
UIImage *generateBarCode(NSString *code,CGFloat width,CGFloat height);
UIImage * imageWithMaxSide(CGFloat length ,UIImage *image);
/**
 *  MD5加密
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密后的字符串
 */
NSString * MD5(NSString *string);
CGFloat getDistance(CGFloat localLatitude,CGFloat localLongitude,CGFloat otherLatitude,CGFloat otherLongitude);
#pragma mark -- 颜色转换
UIColor * colorWithRed(CGFloat red ,CGFloat green ,CGFloat blue ,CGFloat alpha);
UIColor * colorWithHexString(NSString *color ,CGFloat alpha);
/**
 *  身份证的严格判断
 */
BOOL checkIDCard(NSString *sPaperId);
