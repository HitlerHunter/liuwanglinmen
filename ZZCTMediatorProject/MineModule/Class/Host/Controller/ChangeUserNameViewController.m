//
//  ChangeUserNameViewController.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/10.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "ChangeUserNameViewController.h"

@interface ChangeUserNameViewController ()
@property (nonatomic, strong) UITextField *textF;
@end

@implementation ChangeUserNameViewController

- (void)setText:(NSString *)text{
    _text = text;
    
    _textF.text = _text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = LZBackgroundColor;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, LZApp.shareInstance.app_navigationBarHeight+10, kScreenWidth, 40)];
    view.backgroundColor = LZWhiteColor;
    [self.view addSubview:view];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [view addSubview:tf];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@15);
        make.right.mas_equalTo(view).mas_offset(-15);
        make.centerY.mas_equalTo(view);
        make.height.mas_equalTo(23);
    }];
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"完成" font:nil color:nil block:^{
        @strongify(self);
        
        if (!tf.text.length) {
            [self showMessage:@"请输入内容！"];
            return ;
        }
        
        if ([tf.text isEqualToString:self.text]) {
            [self lz_popController];
            return;
        }
        
        if (self.finishBlock) {
            self.finishBlock(tf.text);
        }
        
        [self lz_popController];
    }];
    
    _textF = tf;
//    [_textF becomeFirstResponder];
    
    _textF.text = _text;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_textF becomeFirstResponder];
}


@end
