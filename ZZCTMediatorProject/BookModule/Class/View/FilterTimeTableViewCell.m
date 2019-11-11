//
//  FilterTimeTableViewCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "FilterTimeTableViewCell.h"
#import "HooDatePicker.h"

typedef NS_ENUM(NSUInteger, FilterTimeStyle) {
    FilterTimeStyleStart = 1,
    FilterTimeStyleEnd,
    FilterTimeStyleMS,
    FilterTimeStyleYMD,
};

@interface FilterTimeTableViewCell ()<HooDatePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *startYMDTextField;
@property (weak, nonatomic) IBOutlet UITextField *endYMDTextField;
@property (weak, nonatomic) IBOutlet UITextField *startMSTextField;
@property (weak, nonatomic) IBOutlet UITextField *endMSTextField;

@property (nonatomic, strong) HooDatePicker *YMDPicker;
@property (nonatomic, strong) HooDatePicker *MSPicker;

@property (nonatomic, assign) FilterTimeStyle selectStyle;
@property (nonatomic, assign) FilterTimeStyle YMDStyle;
@property (nonatomic, assign) FilterTimeStyle MSStyle;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@end

@implementation FilterTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"FilterClearAllNotificationName" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.startYMDTextField.text = @"";
        self.endYMDTextField.text = @"";
        self.startMSTextField.text = @"";
        self.endMSTextField.text = @"";
        
        self.startDate = nil;
        self.endDate = nil;
    }];
    
    
}

- (IBAction)showStartYMDPicker:(id)sender {
    
    if (self.endDate){
        self.YMDPicker.maximumDate = self.endDate;
    }
    
    self.selectStyle = FilterTimeStyleYMD;
    self.YMDStyle = FilterTimeStyleStart;
    [self.YMDPicker show];
    
}

- (IBAction)showEndYMDPicker:(id)sender {
    
    if (self.startDate){
        self.YMDPicker.minimumDate = self.startDate;
    }
    
    self.selectStyle = FilterTimeStyleYMD;
    self.YMDStyle = FilterTimeStyleEnd;
    [self.YMDPicker show];
}
- (IBAction)showStartMSPicker:(id)sender {
    
    self.selectStyle = FilterTimeStyleMS;
    self.MSStyle = FilterTimeStyleStart;
    [self.MSPicker show];
}

- (IBAction)showEndMSPicker:(id)sender {
    
    self.selectStyle = FilterTimeStyleMS;
    self.MSStyle = FilterTimeStyleEnd;
    [self.MSPicker show];
}

#pragma mark - dateDelegate
- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date{
    
    if (self.selectStyle == FilterTimeStyleYMD) {
        NSString *dateStr = [date formatYMDWithSeparate:@"-"];
        if (self.YMDStyle == FilterTimeStyleStart) {
            self.startDate = date;
            self.startYMDTextField.text = dateStr;
        }else if (self.YMDStyle == FilterTimeStyleEnd){
            self.endDate = date;
            self.endYMDTextField.text = dateStr;
        }
    }else if (self.selectStyle == FilterTimeStyleMS){
        NSString *dateStr = [date formatHM];
        if (self.MSStyle == FilterTimeStyleStart) {
            self.startMSTextField.text = dateStr;
        }else if (self.MSStyle == FilterTimeStyleEnd){
            self.endDate = date;
            self.endMSTextField.text = dateStr;
        }
    }
    
}

- (NSString *)start{
    NSString *startYMD = self.startYMDTextField.text;
    NSString *startMS = self.startMSTextField.text;
    if (startYMD.length) {
        if (!startMS.length) {
            startMS = @"00:00";
        }
        return [NSString stringWithFormat:@"%@ %@:00",startYMD,startMS];
    }
    
    return nil;
}

- (NSString *)end{
    NSString *endYMD = self.endYMDTextField.text;
    NSString *endMS = self.endMSTextField.text;
    if (endYMD.length) {
        if (!endMS.length) {
            endMS = @"23:59";
            return [NSString stringWithFormat:@"%@ %@:59",endYMD,endMS];
        }
        return [NSString stringWithFormat:@"%@ %@:00",endYMD,endMS];
    }
    
    return nil;
}

- (HooDatePicker *)YMDPicker{
    if (!_YMDPicker) {
        _YMDPicker = [[HooDatePicker alloc] initWithSuperView:KeyWindow];
        _YMDPicker.delegate = self;
        _YMDPicker.timeZone = [NSTimeZone localTimeZone];
    }
    return _YMDPicker;
}

- (HooDatePicker *)MSPicker{
    if (!_MSPicker) {
        _MSPicker = [[HooDatePicker alloc] initDatePickerMode:HooDatePickerModeTime andAddToSuperView:KeyWindow];
        _MSPicker.delegate = self;
        _MSPicker.timeZone = [NSTimeZone systemTimeZone];
    }
    return _MSPicker;
}
@end
