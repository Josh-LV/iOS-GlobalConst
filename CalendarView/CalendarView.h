//
//  CalendarView.h
//  CalenlarTest
//
//  Created by Yunyi on 16/5/6.
//  Copyright © 2016年 Yunyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarView;

@protocol CalendarViewDelegate <NSObject>

@optional
- (void)calendarView:(CalendarView *)calendarView date:(NSDate *)date;

@end

@interface CalendarView : UIView

+ (instancetype)calendarView;

@property (nonatomic, weak) id <CalendarViewDelegate> delegate;

@end
