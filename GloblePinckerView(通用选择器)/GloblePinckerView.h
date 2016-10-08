//
//  GloblePinckerView.h
//  yyt
//
//  Created by Yunyi on 16/5/19.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GloblePinckerView : UIView

+(instancetype)globlePinckerView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) void(^didChoice)(NSString *sex);
@property (nonatomic, copy) void(^didCancle)();
- (void)reloadPickerView;

@end
