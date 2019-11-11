//
//  AuthenBankManager.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/23.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenBankManager.h"
#import "SDCityPickerViewController.h"
#import "SDCityModel.h"
#import "SDCityInitial.h"
#import "AuthenMerchantBankController.h"
#import "AMBankBranchViewController.h"

@implementation AuthenBankModel

@end

@interface AuthenBankManager ()

@property (nonatomic, strong) SDCityInitial *hotCityInitial;
@end

@implementation AuthenBankManager

#pragma mark - 银行
+ (void)ShowBankListChoiceController:(UINavigationController *)nav
                               block:(void (^)(NSString *bankName))block{
    
    AuthenMerchantBankController *vc = [[AuthenMerchantBankController alloc] init];
    vc.block = block;
    [nav pushViewController:vc animated:YES];
}

- (void)getBankName:(void (^)(NSArray <AuthenBankModel *> *bankArray))block{
    
    if (self.searchStr.length == 0) {
        if (block) {
            block(@[]);
        }
        return;
    }
    
    NewParams;
    [params setSafeObject:self.searchStr forKey:@"bankName"];
    
    ZZNetWorker.GET.zz_url(@"/merchant-biz/bankInfo/getBankNameBy")
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            NSArray *arr = [AuthenBankModel mj_objectArrayWithKeyValuesArray:model_net.data];
            if (block) {
                block(arr);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

- (void)SearchBankListWithBlock:(void (^)(NSArray *dataArray))block
{
    
    [SVProgressHUD show];
    [self getBankName:^(NSArray<AuthenBankModel *> * _Nonnull bankArray) {
        NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:bankArray.count];
        for (AuthenBankModel *bank in bankArray) {
            [titleArray addObject:bank.bankName];
        }
        
        NSMutableArray *normalDicArr = [NSMutableArray array];
        for (AuthenBankModel *bank in bankArray) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setSafeObject:bank.bankName forKey:@"name"];
            [normalDicArr addObject:dic];
        }
        
        NSMutableArray *cityModels = [NSMutableArray array];
        NSMutableArray *_dataArr = [NSMutableArray array];
        
        [_dataArr addObject:self.hotCityInitial];
        
        
        for (int j = 0; j<normalDicArr.count; j++) {
            SDCityModel *city = [[SDCityModel alloc]initWithCityDict:normalDicArr[j]];
            [cityModels addObject:city];
        }
        
            //获取首字母
        NSArray *indexArr =
        [[cityModels valueForKeyPath:@"firstLetter"] valueForKeyPath:@"@distinctUnionOfObjects.self"];
        indexArr = [indexArr sortedArrayUsingSelector:@selector(compare:)];
            //遍历数组
        for (NSString *indexStr in indexArr) {
            
            SDCityInitial *cityInitial =[[SDCityInitial alloc]init];
            cityInitial.initial = indexStr;
            NSMutableArray *cityArrs =[NSMutableArray array];
            for ( SDCityModel *cityModel in cityModels) {
                if ([indexStr isEqualToString:cityModel.firstLetter]) {
                    [cityArrs addObject:cityModel];
                    
                }
            }
            cityInitial.cityArrs = cityArrs;
            [_dataArr addObject:cityInitial];
        }
        
        [SVProgressHUD dismiss];
        
        if (block) {
            block(_dataArr);
        }
    }];
    
}

- (SDCityInitial *)hotCityInitial{
    if (!_hotCityInitial) {
        
        NSArray *hotArr = @[@"上海浦东发展银行",@"中国农业银行",@"中国建设银行"
                            ,@"中国银行",@"中国邮政储蓄银行",@"交通银行"
                            ,@"招商银行",@"中信银行",@"中国光大银行",@"兴业银行"
                            ,@"中国工商银行",@"中国民生银行",@"平安银行"];
        
        NSMutableArray *hotDicArr = [NSMutableArray array];
        for (NSString *bank in hotArr) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setSafeObject:bank forKey:@"name"];
            [hotDicArr addObject:dic];
        }
        
        NSMutableArray *hotModels = [NSMutableArray array];
        for (int j = 0; j<hotDicArr.count; j++) {
            SDCityModel *city = [[SDCityModel alloc]initWithCityDict:hotDicArr[j]];
            [hotModels addObject:city];
        }
        
        SDCityInitial *cityInitial =[[SDCityInitial alloc]init];
        cityInitial.initial = @"热门银行";
        
        cityInitial.cityArrs = hotModels;
        
        _hotCityInitial = cityInitial;
    }
    return _hotCityInitial;
}

#pragma mark - 支行

+ (void)ShowBankBranchListChoiceControllerWithBankName:(NSString *)bankName
                                                   nav:(UINavigationController *)nav
                                                 block:(void (^)(NSString *bankName))block{
    
    AMBankBranchViewController *vc = [[AMBankBranchViewController alloc] initWithBankName:bankName];
    vc.block = block;
    [nav pushViewController:vc animated:YES];
}

- (void)getBankBranchWithBankName:(NSString *)bankName
                            block:(void (^)(NSArray <AuthenBankModel *> *bankBranchArray))block{
    
    if (self.searchStr.length == 0) {
        if (block) {
            block(@[]);
        }
        return;
    }
    
    NewParams;
    [params setSafeObject:self.searchStr forKey:@"bankBranch"];
    [params setSafeObject:bankName forKey:@"bankName"];
    
    ZZNetWorker.GET.zz_url(@"/merchant-biz/bankInfo/getBankBranchBy")
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            NSArray *arr = [AuthenBankModel mj_objectArrayWithKeyValuesArray:model_net.data];
            if (block) {
                block(arr);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model_net.message];
        }
        
    });
}

- (void)SearchBankBranchListWithBankName:(NSString *)bankName
                                   block:(void (^)(NSArray *dataArray))block
{
    
    [SVProgressHUD show];
    [self getBankBranchWithBankName:bankName block:^(NSArray<AuthenBankModel *> * _Nonnull bankArray) {
        NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:bankArray.count];
        for (AuthenBankModel *bank in bankArray) {
            [titleArray addObject:bank.bankBranch];
        }
        
        NSMutableArray *normalDicArr = [NSMutableArray array];
        for (AuthenBankModel *bank in bankArray) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setSafeObject:bank.bankBranch forKey:@"name"];
            [normalDicArr addObject:dic];
        }
        
        NSMutableArray *cityModels = [NSMutableArray array];
        NSMutableArray *_dataArr = [NSMutableArray array];
        
        //热门
        SDCityInitial *cityInitial = [[SDCityInitial alloc] init];
        cityInitial.cityArrs = [NSMutableArray arrayWithCapacity:1];
        [_dataArr addObject:cityInitial];
        
        for (int j = 0; j<normalDicArr.count; j++) {
            SDCityModel *city = [[SDCityModel alloc]initWithCityDict:normalDicArr[j]];
            [cityModels addObject:city];
        }
        
            //获取首字母
        NSArray *indexArr =
        [[cityModels valueForKeyPath:@"firstLetter"] valueForKeyPath:@"@distinctUnionOfObjects.self"];
        indexArr = [indexArr sortedArrayUsingSelector:@selector(compare:)];
            //遍历数组
        for (NSString *indexStr in indexArr) {
            
            SDCityInitial *cityInitial =[[SDCityInitial alloc]init];
            cityInitial.initial = indexStr;
            NSMutableArray *cityArrs =[NSMutableArray array];
            for ( SDCityModel *cityModel in cityModels) {
                if ([indexStr isEqualToString:cityModel.firstLetter]) {
                    [cityArrs addObject:cityModel];
                    
                }
            }
            cityInitial.cityArrs = cityArrs;
            [_dataArr addObject:cityInitial];
        }
        
        [SVProgressHUD dismiss];
        
        if (block) {
            block(_dataArr);
        }
    }];
    
}


@end
