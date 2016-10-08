//
//  CalendarCell.m
//  CalenlarTest
//
//  Created by Yunyi on 16/5/6.
//  Copyright © 2016年 Yunyi. All rights reserved.
//

#import "CalendarCell.h"
#import "ShowDaymodel.h"

@interface CalendarCell ()

@property (weak, nonatomic) IBOutlet UILabel *weakDay;
@property (weak, nonatomic) IBOutlet UIButton *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *isFullLable;
@property (weak, nonatomic) UIButton *selectedBtn;
@property (nonatomic, strong) NSArray *weakArr;

@end
@implementation CalendarCell

- (NSArray *)weakArr
{
    if (!_weakArr) {
        _weakArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _weakArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)selectedDayClick:(UIButton *)sender {
    NSLog(@"selectedDayClick");
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor colorWithRed:18/255.0 green:142/255.0 blue:238/255.0 alpha:1.0];
    }else{
        sender.backgroundColor = [UIColor clearColor];
    }
    _model.isSelected = sender.selected;
    if (_isSelected) {
        _isSelected(_model,sender.selected);
    }
}


- (void)setModel:(ShowDaymodel *)model
{
    _model = model;
    int num = model.weekDay.intValue;
    _weakDay.text = self.weakArr[num];
    [_dateLable setTitle:model.day forState:UIControlStateNormal];
    if (model.isSelected == true) {
        _dateLable.selected = true;
        _dateLable.backgroundColor = [UIColor colorWithRed:18/255.0 green:142/255.0 blue:238/255.0 alpha:1.0];
    }else{
        _dateLable.selected = false;
        _dateLable.backgroundColor = [UIColor clearColor];
    }
    if (model.isFull) {
        _isFullLable.hidden = false;
    }else{
        _isFullLable.hidden = true;
    }
}
@end
