//
//  CalendarCell.h
//  CalenlarTest
//
//  Created by Yunyi on 16/5/6.
//  Copyright © 2016年 Yunyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowDaymodel;

@interface CalendarCell : UICollectionViewCell

@property (nonatomic, strong) ShowDaymodel *model;

@property (nonatomic, copy) void(^isSelected)(ShowDaymodel *model,BOOL b);

@end
