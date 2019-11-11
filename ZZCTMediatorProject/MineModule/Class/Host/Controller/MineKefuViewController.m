//
//  MineKefuViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/27.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineKefuViewController.h"
#import "MarketPortCell.h"
#import "AppWechatViewController.h"
#import "MineKefuCell.h"

@interface MineKefuViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation MineKefuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的客服";
    
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"kefu_banner")];
    [self.scrollView addSubview:imageView];
    _imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(kScreenWidth-30);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(0);
    }];
    
    [self creatCellView];
}

- (void)creatCellView{
    
    NSString *kefuPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefuPhone"];
    NSString *startTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefuStartTime"];
    NSString *endTimeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefuEndTime"];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@-%@",startTimeStr,endTimeStr];
    
    NSArray *array = @[@{@"title":@"全国服务热线",
                         @"info":kefuPhone,
                         @"icon":@"kefu_kefu",
                         @"moreIcon":@"mineKefu_call",
                         },
                       ];
    
    
    UIView *lastView = _imageView;
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        NSString *title = dic[@"title"];
        NSString *info = dic[@"info"];
        NSString *icon = dic[@"icon"];
        NSString *moreIcon = dic[@"moreIcon"];
        
        MarketPortCell *cell = [MarketPortCell new];
        cell.label_title.text = title;
        cell.label_info.text = info;
        cell.imageView.image = UIImageName(icon);
        cell.moreIcon.image = UIImageName(moreIcon);
        
        if (i == 0) {
            cell.label_subInfo.text = timeStr;
        }
        
        [self.scrollView addSubview:cell];
        
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15*LZScale);
            make.right.mas_equalTo(-15*LZScale);
            make.top.mas_equalTo(lastView.mas_bottom).offset(10);
            make.height.mas_equalTo(90);
        }];
        
        @weakify(self);
        cell.clickBlock = ^(NSString * _Nonnull title) {
            @strongify(self);
            [self cellClickWithTitle:title];
        };
        
        lastView = cell;
        
        cell.lz_setView.lz_shadow(6, rgba(0, 0, 0, 0.09), CGSizeMake(0, 0), 1, 5);
    }
    
    NSString *weixinNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefu_weixinNumber"];
    
    MineKefuCell *weixinCell = [MineKefuCell new];
    weixinCell.label_title.text = @"客服微信";
    weixinCell.label_info.text = [NSString stringWithFormat:@"微信号：%@",weixinNumber];
    weixinCell.imageView.image = UIImageName(@"kefu_weixin");
    [self.scrollView addSubview:weixinCell];
    [weixinCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LZScale);
        make.right.mas_equalTo(-15*LZScale);
        make.top.mas_equalTo(lastView.mas_bottom).offset(10);
        make.height.mas_equalTo(90);
    }];
    weixinCell.lz_setView.lz_shadow(6, rgba(0, 0, 0, 0.09), CGSizeMake(0, 0), 1, 5);
    lastView = weixinCell;
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.scrollView).offset(20);
    }];
    
    
}

- (void)cellClickWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"全国服务热线"]) {
        [AppCenter callKeFu];
    }

}


@end
