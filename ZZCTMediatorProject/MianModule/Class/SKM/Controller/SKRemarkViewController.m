//
//  SKRemarkViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/15.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SKRemarkViewController.h"
#import "CMInputView.h"

@interface SKRemarkViewController ()
@property (nonatomic, strong) RemarkFinishReturn block;
@property (nonatomic, strong) CMInputView *textView;
@end

@implementation SKRemarkViewController

- (instancetype)initWithBlock:(RemarkFinishReturn)block{
    self = [super init];
    if (self) {
        _block = block;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"备注";
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"清空" font:nil color:nil block:^{
        @strongify(self);
        self.textView.text = @"";
    }];
    
    CMInputView *inputView = [[CMInputView alloc] initWithFrame:CGRectMake(15, LZApp.shareInstance.app_navigationBarHeight+10, kScreenWidth-30, 130)];
    inputView.backgroundColor = LZWhiteColor;
    _textView = inputView;
    [self.view addSubview:inputView];
    
    inputView.placeholder = @"备注内容30个字以内";
    inputView.placeholderColor = rgb(152,152,152);
    inputView.maxTextNumber = 30;
    
    inputView.lz_setView.lz_border(0.5, UIColorHex(0xE5E5E5));
    
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"保存" textColor:LZWhiteColor];
    btn.frame = CGRectMake(24, inputView.bottom+25, kScreenWidth-48, 45);
    [btn setDefaultGradientWithCornerRadius:6];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
}

- (void)save{
    if (self.block) {
        NSString *text = self.textView.text;
        if(self.textView.text.length == 0) {
            text = @"";
        }
        self.block(text);
    }
    PopController;
}

@end
