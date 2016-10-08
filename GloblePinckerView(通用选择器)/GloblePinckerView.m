//
//  GloblePinckerView.m
//  yyt
//
//  Created by Yunyi on 16/5/19.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import "GloblePinckerView.h"

@interface GloblePinckerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, copy) NSString *selectedSex;
@end

@implementation GloblePinckerView

+(instancetype)globlePinckerView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GloblePinckerView" owner:nil options:nil].firstObject;
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    _selectedSex = dataArr[0];
}
- (void)reloadPickerView
{
    [_pickerView reloadAllComponents];
}
#pragma MARK -- UIPickerViewDataSource
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 36.f;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return _dataArr[row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lable = (UILabel *)view;
    if (!lable){
        lable = [[UILabel alloc] init];
        lable.textAlignment = NSTextAlignmentCenter;
        [lable setBackgroundColor:[UIColor clearColor]];
        //        [lable setFont:[UIFont boldSystemFontOfSize:15]];
        lable.font = [UIFont systemFontOfSize:14.f];
    }
    lable.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return lable;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedSex = _dataArr[row];
}
#pragma MARK -- UIBarButton   点击事件
- (IBAction)cancleClick:(id)sender {
    if (_didCancle) {
        _didCancle();
    }
    
}
- (IBAction)sureClick:(id)sender {
    if (_didChoice) {
        _didChoice(_selectedSex);
    }
}

@end
