//
//  SYTJViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/3.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "SYTJViewController.h"

@interface SYTJViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widhtConstraint;

/**
 收款收益
 */
@property (weak, nonatomic) IBOutlet UILabel *label_1;

/**
 还款收益
 */
@property (weak, nonatomic) IBOutlet UILabel *label_2;

/**
 境外收益
 */
@property (weak, nonatomic) IBOutlet UILabel *label_3;

/**
 推荐佣金
 */
@property (weak, nonatomic) IBOutlet UILabel *label_4;

/**
 奖金
 */
@property (weak, nonatomic) IBOutlet UILabel *label_5;

/**
 城市合伙人收益
 */
@property (weak, nonatomic) IBOutlet UILabel *label_6;

@end

@implementation SYTJViewController

- (IBAction)tocash:(id)sender {
//    if (CurrentUser.money<CurrentUser.wdBegAmt) {
//        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"单笔提现不能低于%.2lf元",CurrentUser.wdBegAmt]];
//        return;
//    }
        //提现
//    NSString *url = [NSString stringWithFormat:@"%@?wdFeeAmt=%@",h5_TiXian,CurrentUser.wdFeeAmt];
//    H5CommonViewController *h5VC = [[H5CommonViewController alloc] initWithNoEncodeUrl:url];
//    PushController(h5VC);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.widhtConstraint.constant = kScreenWidth;
    [self requestData];
}

- (void)requestData{
    
//    [RequestTools getWithUrlString:URL_ZZF(@"profit/profitSum") parameters:@{} success:^(NSDictionary *responseDic) {
//        
//        RequestInfoResolve2
//        responseDic = responseDic[@"data"];
//        if (isSuccess) {
//            NSString *payBackProfit = responseDic[@"payBackProfit"];
//            NSString *payProfit = responseDic[@"payProfit"];
//            NSString *overSeasProfit = responseDic[@"overSeasProfit"];
//            NSString *recommedProfit = responseDic[@"recommedProfit"];
//            NSString *lieProfit = responseDic[@"lieProfit"];
//            NSString *awardProfit = responseDic[@"awardProfit"];
//            
//            _label_1.text = [NSString formatFloatString:payProfit];
//            _label_2.text = [NSString formatFloatString:payBackProfit];
//            _label_3.text = [NSString formatFloatString:overSeasProfit];
//            _label_4.text = [NSString formatFloatString:recommedProfit];
//            _label_5.text = [NSString formatFloatString:awardProfit];
//            _label_6.text = [NSString formatFloatString:lieProfit];
//            
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
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
