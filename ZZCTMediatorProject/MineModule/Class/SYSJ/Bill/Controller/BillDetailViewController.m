//
//  BillDetailViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/3.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "BillDetailViewController.h"

@interface BillDetailViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *ordId;
@property (weak, nonatomic) IBOutlet UILabel *namePhone;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *way;
@property (weak, nonatomic) IBOutlet UILabel *channel;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *acount;
@property (weak, nonatomic) IBOutlet UILabel *profit;

@property (nonatomic, strong) NSString *tranId;
@end

@implementation BillDetailViewController

- (instancetype)initWithOrdId:(NSString *)ordId{
    self = [super init];
    if (self) {
        _tranId = ordId;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.profit.text = [NSString stringWithFormat:@"¥ %@",_profitStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.widthConstraint.constant = kScreenWidth;
    
    self.title = @"订单详情";
    [self requestData];
}

- (void)requestData{
    NewParams;
    [params setSafeObject:_tranId forKey:@"tranId"];
    
//    [RequestTools getWithUrlString:URL_ZZF(@"profit/getBillDetail") parameters:params success:^(NSDictionary *responseDic) {
//        RequestInfoResolve2
//        if (isSuccess) {
//            [self updateUIWithDic:responseDic[@"data"]];
//        }else{
//            [SVProgressHUD showImage:nil status:resMsg];
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
}

- (void)updateUIWithDic:(NSDictionary *)dic{
    
    @try {
        
        _ordId.text = dic[@"tranId"];
        _namePhone.text = [NSString stringWithFormat:@"%@ %@",dic[@"name"],dic[@"tel"]];
        
        NSString *createTm = [[NSString stringWithFormat:@"%@",dic[@"txnTm"]] substringToIndex:10];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTm.integerValue];
        _date.text = [NSString stringWithFormat:@"%@ %@",[date formatYMDWithSeparate:@"-"],[date formatHMS]];
        
        _channel.text = dic[@"cnlNo"];
        _money.text = [NSString stringWithFormat:@"¥ %@",dic[@"txnAmt"]];
        _acount.text = dic[@"txnCardNo"];
        
        /**
         * 交易状态 0未进行 1进行中 2成功 3失败
         */
        NSInteger stauts = [dic[@"tranSts"] integerValue];
        NSString *imageName = @"";
        if (stauts == 0) {
            imageName = @"bill_orderdetails_payment";
        }else if (stauts == 1) {
            imageName = @"bill_orderdetails_bankacceptance";
        }else if (stauts == 2) {
            imageName = @"bill_orderdetails_transfertocard";
        }else if (stauts == 3) {
            imageName = @"";
        }
        _imageView.image = UIImageName(imageName);
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

@end
