//
//  PaySuccessViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "PaySuccessViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"h5PaySuccess.jpg")];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(260, 160));
    }];
    
    self.view.backgroundColor = LZWhiteColor;
    
    self.title = @"支付成功";
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
