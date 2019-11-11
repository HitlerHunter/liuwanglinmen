//
//  BillTableViewCell.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/26.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BillTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *recordId;
@property (weak, nonatomic) IBOutlet UILabel *allMoney;

@property (weak, nonatomic) IBOutlet UIImageView *moreIcon;

@property (weak, nonatomic) IBOutlet UILabel *rightTopTitle;

@end
