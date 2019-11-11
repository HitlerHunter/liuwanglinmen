//
//  bankCardRealViewController.m
//  zhonxinV2
//
//  Created by 徐迪华 on 2017/12/15.
//  Copyright © 2017年 徐迪华. All rights reserved.
//

#import "bankCardRealViewController.h"

#import "LZAddressCenter.h"

@interface bankCardRealViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,AddressSelectDelegate>
{
    
    __weak IBOutlet UILabel *nameLab;
    
    __weak IBOutlet UILabel *personNumLab;
    
    
    __weak IBOutlet UITextField *bankCardNum;
    
    __weak IBOutlet UITextField *phoneNum;
    
    __weak IBOutlet UITextField *verCodeTexF;
    
    __weak IBOutlet UIButton *getVerCodeBtn;
    __weak IBOutlet UILabel *bankNameLab;
    
    
    __weak IBOutlet UIButton *selectBtn;
    
    
    __weak IBOutlet UIButton *compliteBtn;
    
    
    __weak IBOutlet UIButton *areaBtn;
    
    __weak IBOutlet UILabel *areaLab;
    
    
    UIPickerView *myPicker;
    NSArray *bankNameArr;
    UIView *bgVIew;
    
    NSString *selectBankName;
    NSInteger verCodeTime;
    NSTimer *myTimer;
}
@property (nonatomic, strong) LZAddressCenter *addressCenter;
@end

@implementation bankCardRealViewController
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stopTimer];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     compliteBtn.lz_setView.lz_cornerRadius(5);
     verCodeTime = 60;
     getVerCodeBtn.lz_setView.lz_cornerRadius(5);
     bankNameArr  = @[@"工商银行",@"农业银行",@"中国银行",@"建设银行",@"交通银行",@"中信银行",@"光大银行",@"华夏银行",@"民生银行",@"广发银行",@"平安银行",@"招商银行",@"兴业银行",@"浦东发展银行",@"北京银行",@"恒丰银行",@"浙商银行",@"渤海银行",@"邮政储蓄银行"];
    selectBankName = bankNameArr[0];
    nameLab.text = self.name;
    personNumLab.text = self.personNum;
    
    self.title = @"实名认证";
}


- (IBAction)getVerCodeClick:(UIButton *)sender {
    
    if (phoneNum.text.length != 11) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    
    
    //获取验证码
    sender.highlighted = NO;
    sender.titleLabel.text = [NSString stringWithFormat:@"%ld S",(long)verCodeTime];
    [sender setTitle:[NSString stringWithFormat:@"%ld S",(long)verCodeTime] forState:UIControlStateNormal];
    [self startTimer];
    //获取验证码

    NSDictionary *dict = @{@"usrTel":phoneNum.text,@"smsType":@"1"};
//    [RequestTools postWithUrlString:zzf_YanZhengMa_get parameters:dict success:^(NSDictionary *responseDic) {
//        
//        NSString *str = responseDic[@"resMsg"];
//        NSLog(@"-----duanxin1-----%@",str);
//       
//        NSLog(@"-----str:%@",str);
//        NSString *resCode = responseDic[@"resCode"];
//        if ([resCode isEqualToString:@"0"]) {
//            [SVProgressHUD showSuccessWithStatus:str];
//        }else{
//            
//            [SVProgressHUD showImage:nil status:str];
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"error-----%@",error);
//       
//        [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@",error]];
//        
//    }];
}
-(void)startTimer{
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
    getVerCodeBtn.enabled = NO;
}
-(void)timerClick{
    verCodeTime --;
    
    getVerCodeBtn.titleLabel.text = [NSString stringWithFormat:@"%ld S",(long)verCodeTime];
    [getVerCodeBtn setTitle:[NSString stringWithFormat:@"%ld S",(long)verCodeTime] forState:UIControlStateNormal];
    if (verCodeTime == 0) {
        [self stopTimer];
    }
}
-(void)stopTimer{
    if (myTimer != nil) {
        [myTimer invalidate];
        myTimer = nil;
        [getVerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        getVerCodeBtn.enabled = YES;
        verCodeTime = 60;
    }
}
- (IBAction)bankNameSelect:(UIButton *)sender {
    [self.view endEditing:YES];
    
    selectBtn.enabled = NO;
    selectBtn.userInteractionEnabled = NO;
    
    bgVIew = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-260, kScreenWidth, 260)];
    bgVIew.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgVIew];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
    okBtn.frame = CGRectMake(kScreenWidth - 40, 0, 40, 30);
    [bgVIew addSubview:okBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, 0, 40, 30);
    [bgVIew addSubview:cancelBtn];
    
    
    myPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 260, kScreenWidth, 230)];
    myPicker.delegate = self;
    myPicker.backgroundColor = [UIColor whiteColor];
    myPicker.dataSource = self;
    [bgVIew addSubview:myPicker];
    
    [UIView animateWithDuration:0.5f animations:^{
        myPicker.frame = CGRectMake(0, 30, kScreenWidth, 230);
    }];
    
}
-(void)okClick{
    NSLog(@"ok------");
    selectBtn.enabled = YES;
    selectBtn.userInteractionEnabled = YES;
    bankNameLab.text = selectBankName;
    bankNameLab.font = [UIFont systemFontOfSize:14];
    bankNameLab.font = [UIFont systemFontOfSize:14];
    [self removeViews];
}
-(void)cancelClick{
    NSLog(@"cancel------");
    selectBtn.enabled = YES;
    selectBtn.userInteractionEnabled = YES;
    [self removeViews];
}
- (IBAction)areaClick:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    [LZAddressCenter gotoSelectAddressWithController:self];
    
}

- (void)Center:(LZAddressCenter *)center
      Province:(NSString *)province
          city:(NSString *)city
      district:(NSString *)district{
    
    areaLab.text = [NSString stringWithFormat:@"%@-%@-%@",province,city,district];
    self.addressCenter = center;
}

-(void)removeViews{
    
    [bgVIew removeFromSuperview];
}
- (IBAction)compliteClick:(UIButton *)sender {
    
    
    NSString *userName = CurrentUser.phone;
    NSString *ssId = @"";
    
    if (phoneNum.text.length != 11) {
        [SVProgressHUD showImage:nil status:@"请输入正确的手机号码"];
        return;
    }
    if ([verCodeTexF.text length] == 0) {
        [SVProgressHUD showImage:nil status:@"验证码为空"];
        return;
    }
    if (bankCardNum.text.length == 0) {
        [SVProgressHUD showImage:nil status:@"请填写银行卡号"];
        return;
    }
    
    if (areaLab.text.length == 0) {
        [SVProgressHUD showImage:nil status:@"请选择开户行所在地"];
        return;
    }
    
        //验证验证码
    [SVProgressHUD show];
    NSDictionary *dict2 = @{@"usrTel":phoneNum.text,@"smsType":@"1",@"smsCode":verCodeTexF.text};
//    [RequestTools postWithUrlString:zzf_YanZhengMa_check parameters:dict2 success:^(NSDictionary *responseDic) {
//        NSLog(@"sucess---%@",responseDic);
//        
//        NSString *resCode = responseDic[@"resCode"];
//        NSString *resMsg = responseDic[@"resMsg"];
//
//        if ([resCode isEqualToString:@"0"]) {
//            
//            //省市区信息
//            NSString *prov = self.addressCenter.province;
//            NSString *city = self.addressCenter.city;
//            NSString *zone = self.addressCenter.district;
//            prov = prov?prov:@"";
//            city = city?city:@"";
//            zone = zone?zone:@"";
//            
//            //银行卡实名认证
//            NSDictionary *dict = @{@"usrTel":userName,@"cardNo":bankCardNum.text,@"bankNm":bankNameLab.text,@"resTel":phoneNum.text,@"sessionId":ssId,@"prov":prov,@"city":city,@"zone":zone};
//            
//            
//            [RequestTools postWithUrlString:zzf_real2 parameters:dict success:^(NSDictionary *responseDic) {
//            
//                [SVProgressHUD dismiss];
//                
//                NSLog(@"sucess-------%@",responseDic);
//                NSString *str = responseDic[@"resMsg"];
//                NSLog(@"bank--------%@",str);
//                NSString *resCode = responseDic[@"resCode"];
//                NSString *resMsg = responseDic[@"resMsg"];
//
//                if ([resCode isEqualToString:@"0"]) {
//                    
//                    CurrentUser.relAuthFlag = YES;
//                    
//                    [SVProgressHUD showImage:nil status:@"实名认证成功!"];
//                    
////                    [self.navigationController popToRootViewControllerAnimated:YES];
//                    [self lineBackWithId:LinearBackId_realName];
//                }else{
//                    [SVProgressHUD showImage:nil status:resMsg];
//                    [self stopTimer];
//                    
//                }
//                
//            } failure:^(NSError *error) {
//                NSLog(@"error-------%@",error);
//                
//                [SVProgressHUD dismiss];
//                
//            }];
//            
//        }else{
//            [SVProgressHUD dismiss];
//            [SVProgressHUD showImage:nil status:resMsg];
//        }
//    } failure:^(NSError *error) {
//         [SVProgressHUD dismiss];
//    }];
    
   
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;

}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return bankNameArr.count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED{
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text = bankNameArr[row];
    lab.font = [UIFont systemFontOfSize:18];
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    return lab;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    
    selectBankName = bankNameArr[row];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
@end
