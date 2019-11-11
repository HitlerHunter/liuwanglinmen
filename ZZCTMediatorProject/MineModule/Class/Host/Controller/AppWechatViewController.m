//
//  AppWechatViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "AppWechatViewController.h"
#import "ZZCodeTool.h"

@interface AppWechatViewController ()

@end

@implementation AppWechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"官方微信";
    
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"wechat_banner")];
    [self.scrollView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    UIView *cardView = [UIView new];
    [self.scrollView addSubview:cardView];
    
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(190, 190));
        make.centerX.mas_equalTo(self.scrollView);
    }];
    
    cardView.lz_setView.lz_cornerRadius(10).lz_border(10, rgb(113,174,254));
    
    
    UIImageView *imageView1 = [UIImageView new];
    [cardView addSubview:imageView1];
    
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    
    UILabel *label_info = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"扫描上方二维码，加官方微信" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    [self.scrollView addSubview:label_info];
    
    [label_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cardView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(cardView);
    }];
    
    
    UILabel *label_info2 = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"微信号：" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    [self.scrollView addSubview:label_info2];
    
    [label_info2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_info.mas_bottom).offset(30);
        make.centerX.mas_equalTo(cardView).offset(-20);
        make.bottom.mas_equalTo(self.scrollView).offset(-50);
    }];
    
    UIButton *copyBtn = [UIButton buttonWithFontSize:13 text:@"复制" textColor:rgb(255,0,0)];
    [self.scrollView addSubview:copyBtn];
    
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_info2.mas_right).offset(10);
        make.centerY.mas_equalTo(label_info2);
        make.size.mas_equalTo(CGSizeMake(44, 18));
    }];
    
    copyBtn.lz_setView.lz_cornerRadius(2).lz_border(1, rgb(255,0,0));
    
    [copyBtn addTarget:self action:@selector(copyWechat) forControlEvents:UIControlEventTouchUpInside];
    
    [cardView layoutIfNeeded];
    
    NSString *weixinCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefu_weixinCode"];
    NSString *weixinNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefu_weixinNumber"];
    
    imageView1.image = [ZZCodeTool qrCodeImageWithContent:weixinCode codeImageSize:imageView1.width*1.5 logo:[AppCenter appIcon] logoFrame:CGRectZero red:25/255.0 green:25/255.0 blue:25/255.0];
    
    label_info2.text = [NSString stringWithFormat:@"微信号：%@",weixinNumber];
    
}

- (void)copyWechat{
    
    NSString *weixinNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefu_weixinNumber"];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = weixinNumber;
    
    [self showMessage:@"复制成功"];
}

@end
