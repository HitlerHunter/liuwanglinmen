//
//  BillRepayCell.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/18.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillRepayCell : LZBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *status;

/**
 手续费
 */
@property (weak, nonatomic) IBOutlet UILabel *sxf;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *channel;
@property (weak, nonatomic) IBOutlet UILabel *ordId;
@property (weak, nonatomic) IBOutlet UILabel *cardNumber;
/**
 结算卡号
 */
@property (weak, nonatomic) IBOutlet UILabel *jsCardNumber;
@property (weak, nonatomic) IBOutlet UILabel *errorText;

@end
