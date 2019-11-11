//
//  MineManDetailController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/3.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "MineTeamDetailController.h"

@interface MineTeamDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *realName;
@property (weak, nonatomic) IBOutlet UILabel *boss;

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@end

@implementation MineTeamDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户详情";
    self.widthConstraint.constant = [UIScreen mainScreen].bounds.size.width;
    [self showLoadingDataView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self requestDate];
}

- (void)requestDate{
    
    
    NewParams;
    [params setSafeObject:self.userNo forKey:@"txnUsrNo"];
//    [RequestTools getWithUrlString:URL_ZZF(@"profit/getMerchantInfo") parameters:params success:^(NSDictionary *responseDic) {
//        
//        
//        RequestInfoResolve2
//        responseDic = responseDic[@"data"];
//        if (isSuccess) {
//            NSString *headUrl = responseDic[@"headUrl"];
//            NSString *contribute = responseDic[@"contribute"];
//            NSString *juniorNum = responseDic[@"juniorNum"];
//            NSString *txnContribute = responseDic[@"txnContribute"];
//            NSString *registerTime = [NSString stringWithFormat:@"%@",responseDic[@"registerTime"]];
//            
//            if (IsNull(headUrl)) {
//                headUrl = @"";
//            }
//            
//            if (IsNull(contribute)) {
//                contribute = @"0";
//            }
//            
//            if (IsNull(juniorNum)) {
//                juniorNum = @"0";
//            }
//            
//            if (IsNull(txnContribute)) {
//                txnContribute = @"0";
//            }
//            
//            if (IsNull(registerTime)) {
//                registerTime = @"";
//            }
//            
//            [_avatar sd_setImageWithURL:TLURL(headUrl) placeholderImage:_avatar.image];
//            _name.text = responseDic[@"userName"];
//            _phone.text = [NSString stringWithFormat:@"手机号：%@",responseDic[@"phoneNo"]];
//            
//            if (registerTime.length>10) {
//                registerTime = [registerTime substringToIndex:10];
//            }
//            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[registerTime integerValue]];
//            
//            _date.text = [date formatYMDWithSeparate:@"-"];
//            _realName.text = [responseDic[@"realFlag"] isEqualToString:@"1"]?@"已实名":@"未实名";
//            
//            _boss.text = responseDic[@"refName"];
//            
//            _money.text = [NSString stringWithFormat:@"¥%@",[NSString formatFloatString:txnContribute]];
//            
//            _profitLabel.text = [NSString stringWithFormat:@"¥%@",[NSString formatFloatString:contribute]];
//            
//            _nextCount.text = [NSString stringWithFormat:@"%@名",juniorNum];
//            
//
//            NSInteger level = [responseDic[@"userLvl"] integerValue];
//            NSInteger flag = [responseDic[@"usrLvlFlag"] integerValue];
//            NSString *typeStr = [self userLevelInfoWithLevel:level flag:flag];
//            [_typeBtn setTitle:typeStr forState:UIControlStateNormal];
//            
//        }else{
//            [SVProgressHUD showImage:nil status:resMsg];
//        }
//        
//        [self dismissLoadingDataView];
//        
//    } failure:^(NSError *error) {
//        
//    }];
}

- (NSString *)userLevelInfoWithLevel:(NSInteger)level flag:(NSInteger)flag{
    if (flag == 1) {
        return @"二级代理";
    }
    
    if (level == 0) {
        return @"普通用户";
    }else if (level == 1){
        return @"一级代理";
    }else if (level == 2){
        return @"县级合伙人";
    }else if (level == 3){
        return @"市级合伙人";
    }else if (level == 4){
        return @"省级合伙人";
    }
    
    return @"普通用户";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
