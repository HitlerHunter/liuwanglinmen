//
//  OrdDetailTKViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/23.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "OrdDetailTKViewController.h"

@interface OrdDetailTKViewController ()

@property (weak, nonatomic) IBOutlet UILabel *rightLabel1;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel2;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel3;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel4;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel5;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel6;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel7;

@property (weak, nonatomic) IBOutlet UIButton *toCardBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@end

@implementation OrdDetailTKViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.ordDic) {
        [self updateUI:self.ordDic];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    self.widthConstraint.constant = kScreenWidth;
    self.toCardBtn.lz_setView.lz_cornerRadius(self.toCardBtn.height*0.5);
    
}

- (IBAction)toCard:(id)sender {
    
}




- (void)updateUI:(NSDictionary *)dic{
    
    self.rightLabel1.text = [NSString stringWithFormat:@"¥ %@",[NSString formatFloatString:dic[@"orderAmount"]]];
    self.rightLabel2.text = StrObj(self.ordId);
    self.rightLabel3.text = dic[@"createTime"];
    self.rightLabel4.text = dic[@"createTime"];
    self.rightLabel5.text = !IsNull(dic[@"operatorName"])?dic[@"operatorName"]:@"";
    self.rightLabel6.text = StrObj(dic[@"payTypeName"]);
    self.rightLabel7.text = [self getStatus:[dic[@"status"] integerValue]];
    
}

- (NSString *)getStatus:(NSInteger)status{
        //状态看上面
    NSString *statuText = @"";
    UIColor *color = UIColorHex(0x696969);
    switch (status) {
        case 0:{
            statuText = @"支付失败";
        }break;
        case 1:{
            statuText = @"支付成功";
            color = UIColorHex(0xE62D08);
        }break;
        case 2:{
            statuText = @"支付失败";
        }break;
        case 3:{
            statuText = @"支付失败";
        }break;
        case 4:{
            statuText = @"支付中";
        }break;
        case 5:{
            statuText = @"支付失败";
        }break;
        case 100:{
            statuText = @"已退款";
        }break;
        case 101:{
            statuText = @"未退款";
        }break;
        default:
            break;
    }
    
    self.rightLabel7.textColor = color;
    
    return statuText;
}
@end
