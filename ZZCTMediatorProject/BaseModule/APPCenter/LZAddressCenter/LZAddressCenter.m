//
//  LZAddressCenter.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "LZAddressCenter.h"
#import "AddressSelectViewController.h"
#import "LZAddressAPIRequest.h"

@implementation LZAddressCenter
+ (LZAddressCenter *)gotoSelectAddressWithController:(UIViewController <AddressSelectDelegate>*)controller{
    
    return [self gotoSelectAddressWithController:controller type:AddressSelectTypeProvince finishStep:AddressSelectTypeDistrict];
}

+ (LZAddressCenter *)gotoSelectAddressWithController:(UIViewController <AddressSelectDelegate>*)controller
                                          apiRequest:(id <AddressApiProtocol>)apiRequest{
    
    return [self gotoSelectAddressWithController:controller apiRequest:apiRequest type:AddressSelectTypeProvince finishStep:AddressSelectTypeDistrict];
}

+ (LZAddressCenter *)gotoSelectAddressWithController:(UIViewController <AddressSelectDelegate>*)controller
                                                type:(AddressSelectType)type
                                          finishStep:(AddressSelectType)finishStep{
    
    
    return [self gotoSelectAddressWithController:controller apiRequest:nil type:type finishStep:finishStep];
}

+ (LZAddressCenter *)gotoSelectAddressWithController:(UIViewController <AddressSelectDelegate>*)controller
                                          apiRequest:(id <AddressApiProtocol>)apiRequest
                                                type:(AddressSelectType)type
                                          finishStep:(AddressSelectType)finishStep{
    
    LZAddressCenter *center = [LZAddressCenter new];
    [center setApiRequest:apiRequest];
    AddressSelectViewController *address = [[AddressSelectViewController alloc] initWithType:type
                                                                                     superId:@""
                                                                                      center:center];
    
    if (controller.navigationController) {
        [controller.navigationController pushViewController:address animated:YES];
    }else{
        SDBaseNavigationController *nav = [[SDBaseNavigationController alloc] initWithRootViewController:address];
        center.addressNav = nav;
        [controller presentViewController:nav animated:YES completion:nil];
    }
    
    
    center.addressRootController = controller;
    center.finishStep = finishStep;
    return center;
}

- (void)finishBack{
    if (self.addressRootController && self.addressRootController.navigationController) {
        [self.addressRootController.navigationController popToViewController:self.addressRootController animated:YES];
    }else if (self.addressRootController && !self.addressRootController.navigationController) {
        [self.addressNav dismissViewControllerAnimated:YES completion:nil];
    }
    
    if ([self.addressRootController respondsToSelector:@selector(Center:Province:city:district:)]) {
        [self.addressRootController Center:self
                                  Province:self.province
                                      city:self.city
                                  district:self.district];
    }
}

- (void)getDataWithType:(AddressSelectType)type
                superId:(NSString *)superId
                  block:(void (^)(NSArray *datas))block{
    [self.apiRequest getDataWithType:type superId:superId block:block];
}

- (id<AddressApiProtocol>)apiRequest{
    if (!_apiRequest) {
        _apiRequest = [LZAddressAPIRequest new];
    }
    return _apiRequest;
}

- (NSString *)province{
    return self.apiRequest.province;
}

- (NSString *)provinceCode{
    return self.apiRequest.provinceCode;
}

- (NSString *)city{
    return self.apiRequest.city;
}

- (NSString *)cityCode{
    return self.apiRequest.cityCode;
}

- (NSString *)district{
    return self.apiRequest.district;
}

- (NSString *)districtCode{
    return self.apiRequest.districtCode;
}

@end
