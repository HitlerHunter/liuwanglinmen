//
//  FeedbackViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "FeedbackViewController.h"
#import "CMInputView.h"

@interface FeedbackViewController ()

@property (nonatomic, strong) CMInputView *textView;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    
    [self initTextView];
    
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"提交反馈" textColor:LZWhiteColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.superview.mas_bottom).offset(30);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(40);
    }];
    [btn setDefaultGradientWithCornerRadius:20];
}

- (void)initTextView{
    
    UIView *inputBgView = [UIView new];
    inputBgView.backgroundColor = LZWhiteColor;
    [self.view addSubview:inputBgView];
    
    [inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.base_navigationbarHeight+10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(200);
    }];
    
    //输入框
    CMInputView *inputView = [[CMInputView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-50, 170)];
    inputView.backgroundColor = LZWhiteColor;
    inputView.placeholder = @"请输入反馈内容，我们会为您更好的服务";
    inputView.placeholderFont = Font_PingFang_SC_Regular(16);
    inputView.font = Font_PingFang_SC_Regular(16);
    inputView.placeholderColor = rgb(152,152,152);
    inputView.maxTextNumber = 200;
    
    _textView = inputView;
    [inputBgView addSubview:inputView];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(170);
    }];
    
    //字数
    NSString *maxNumber = [NSString stringWithFormat:@"0/%ld",self.textView.maxTextNumber];
    UILabel *lab = [UILabel labelWithFontSize:14 text:maxNumber textAlignment:NSTextAlignmentRight];
    lab.textColor = rgb(152,152,152);
    _numberLabel = lab;
    [inputBgView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    @weakify(self);
    inputView.textValueDidChanged = ^(NSString *text) {
        @strongify(self);
        self.numberLabel.text = [NSString stringWithFormat:@"%ld/%ld",text.length,self.textView.maxTextNumber];
    };
}

- (void)submit{
    
    NSString *text = self.textView.text;
    if (text.length == 0) {
        return;
    }
    
    NewParams;
    [params setSafeObject:text forKey:@"content"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"usrNo"];
    
        ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/outside-biz/feedBack")
        .zz_completion(^(NSDictionary *data, NSError *error) {
            ZZNetWorkModelWithJson(data);

            if (model_net.success) {
                [self addSuccessView];
            }else{
                [self showMessage:model_net.message];
            }
        });
    
}

- (void)addSuccessView{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, kScreenHeight, kScreenWidth, self.contentHeight);
    view.backgroundColor = LZBackgroundColor;
    [self.view addSubview:view];
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"")];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(84);
        make.size.mas_equalTo(CGSizeMake(58, 58));
    }];
    
    UILabel *lab1 = [UILabel labelWithFontSize:19 text:@"反馈成功" textAlignment:NSTextAlignmentCenter];
    [view addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom).offset(25);
    }];
    
    UILabel *lab2 = [UILabel labelWithFontSize:14 text:@"感谢你对六旺的关注与支持，我们会认真处理你的\
反馈，尽快修复和完善相关功能" textAlignment:NSTextAlignmentCenter];
    lab2.textColor = rgb(101,101,101);
    lab2.numberOfLines = 3;
    [view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(lab1.mas_bottom).offset(10);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        view.top = self.base_navigationbarHeight;
    }];
}

@end
