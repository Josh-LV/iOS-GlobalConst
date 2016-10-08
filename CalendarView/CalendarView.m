//
//  CalendarView.m
//  CalenlarTest
//
//  Created by Yunyi on 16/5/6.
//  Copyright © 2016年 Yunyi. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarCell.h"
#import "ShowDaymodel.h"


#define ShowDayNumber  30

@interface CollectionFlow : UICollectionViewFlowLayout


@end

@implementation CollectionFlow

- (void)prepareLayout
{
    CGFloat width = self.collectionView.frame.size.width / 7;
    self.itemSize = CGSizeMake(width,88);
    
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //    self.collectionView.pagingEnabled = true;
    self.collectionView.bounces = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
}
@end

@interface CalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) NSDateComponents *comps;
@property (nonatomic, strong) NSCalendar *calender;
@property (nonatomic, strong) NSArray * weekdays;
@property (nonatomic, strong) NSTimeZone *timeZone;
@property (nonatomic, strong) NSArray *OutDateArray;
@property (nonatomic, strong) NSArray *selectedData;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) ShowDaymodel *selectedModel;
@end
@implementation CalendarView

#pragma mark ---
#pragma mark --- 初始化
- (NSTimeZone*)timeZone
{
    
    if (_timeZone == nil) {
        [UIColor blueColor];
        _timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    }
    return _timeZone;
}


- (NSArray*)weekdays
{
    
    if (_weekdays == nil) {
        
        _weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
        
    }
    return _weekdays;
}
- (NSCalendar*)calender
{
    
    if (_calender == nil) {
        
        _calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return _calender;
}
- (NSDateComponents*)comps
{
    
    if (_comps == nil) {
        
        _comps = [[NSDateComponents alloc] init];
        
    }
    
    return _comps;
}
- (NSDateFormatter*)formatter
{
    
    if (_formatter == nil) {
        
        _formatter =[[NSDateFormatter alloc]init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _formatter;
}
#pragma mark ---
#pragma mark --- 各种方法
/**
 *  根据当前月获取有多少天
 *
 *  @param dayDate 但前时间
 *
 *  @return 天数
 */
- (NSInteger)getNumberOfDays:(NSDate *)dayDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:dayDate];
    
    return range.length;
    
}
/**
 *  根据前几月获取时间
 *
 *  @param date  当前时间
 *  @param month 第几个月 正数为前  负数为后
 *
 *  @return 获得时间
 */
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month

{
    [self.comps setMonth:month];
    
    NSDate *mDate = [self.calender dateByAddingComponents:self.comps toDate:date options:NSCalendarWrapComponents];
    return mDate;
    
}



/**
 *  根据时间获取周几
 *
 *  @param inputDate 输入参数是NSDate，
 *
 *  @return 输出结果是星期几的字符串。
 */
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    [self.calender setTimeZone: self.timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [self.calender components:calendarUnit fromDate:inputDate];
    
    return [self.weekdays objectAtIndex:theComponents.weekday];
    
}
/**
 *  获取第N个月的时间
 *
 *  @param currentDate 当前时间
 *  @param index 第几个月 正数为前  负数为后
 *
 *  @return @“2016年3月”
 */
- (NSArray*)timeString:(NSDate*)currentDate many:(NSInteger)index;
{
    
    NSDate *getDate =[self getPriousorLaterDateFromDate:currentDate withMonth:index];
    
    NSString  *str =  [self.formatter stringFromDate:getDate];
    
    return [str componentsSeparatedByString:@"-"];
}

/**
 *  根据时间获取第一天周几
 *
 *  @param dateStr 时间
 *
 *  @return 周几
 */
- (NSString*)getMonthBeginAndEndWith:(NSDate *)dateStr{
    
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:dateStr];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    
    return   [self weekdayStringFromDate:beginDate];
}
+ (instancetype)calendarView
{
    return [[NSBundle mainBundle] loadNibNamed:@"CalendarView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CalendarCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //    [self.collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.collectionViewLayout = [[CollectionFlow alloc] init];
    
    _date = [NSDate date];
    
    [self setDataArr];
}
- (void)setDataArr
{
    int i = 0;
    NSMutableArray *arr = [NSMutableArray array];
    while (i < ShowDayNumber) {
//        NSDate*dateList = [self getPriousorLaterDateFromDate:_date withMonth:0];
        
        NSArray*array = [self timeString:[NSDate dateWithTimeInterval:24*60*60*i sinceDate:_date] many:0];
        
        NSString *weakDay = [self weekdayStringFromDate:[NSDate dateWithTimeInterval:24*60*60*i sinceDate:_date]];
//        NSArray *list = @[ array[0], array[1], array[2],weakDay,@(false)];
        ShowDaymodel *model = [[ShowDaymodel alloc] init];
        model.year = array[0];
        model.month = array[1];
        model.day = array[2];
        model.weekDay = weakDay;
        if (i == 0) {
            model.isSelected = true;
        }else{
            model.isSelected = false;
        }
        [arr addObject:model];
        i ++;
    }
    _dataArr = arr;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ShowDaymodel *model = _dataArr[indexPath.row];
    if (model.isSelected) {
        _selectedModel = model;
        _selectedModel.selectedIndexPath = indexPath;
    }
    model.selectedIndexPath = indexPath;
    cell.model = model;
    cell.isSelected = ^(ShowDaymodel *model ,BOOL b){
        
        if ([weakSelf.delegate respondsToSelector:@selector(calendarView:date:)]) {
            NSString *str = [NSString stringWithFormat:@"%@-%@-%@",model.year,model.month,model.day];
            [weakSelf.delegate calendarView:weakSelf date:[weakSelf dateFromString:str]];
        }
        if (!b) {
            weakSelf.selectedModel = nil;
            return ;
        }
        if (weakSelf.selectedModel == nil) {
            weakSelf.selectedModel = model;
        }else{
            NSIndexPath *path = weakSelf.selectedModel.selectedIndexPath;
            weakSelf.selectedModel.isSelected = false;
            weakSelf.selectedModel = model;
            
            [weakSelf.collectionView reloadItemsAtIndexPaths:@[path,model.selectedIndexPath]];
        }
    };
    return cell;
}
- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];

    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}
@end
