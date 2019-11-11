//
//  SKMSignMoneyView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/14.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SKMSignMoneyView.h"

@interface SKMSignMoneyView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *markTF;
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;

@property (nonatomic, strong) UIView  *bgView;

@property (nonatomic, assign) BOOL isHaveDian;
@end

@implementation SKMSignMoneyView

+ (SKMSignMoneyView *)view{
    return [[[NSBundle mainBundle] loadNibNamed:@"SKMSignMoneyView" owner:nil options:nil] lastObject];;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.moneyTF.delegate = self;
    self.markTF.maxLength = 10;
}


- (IBAction)cancel:(id)sender {
    [self dismiss];
}

- (IBAction)sure:(id)sender {
    if (self.moneyTF.text.doubleValue == 0 || self.moneyTF.text == nil) {
        [SVProgressHUD showImage:nil status:@"金额不能为0！"];
        return;
    }
    
    [self dismiss];
    
    if (self.moneyTF.text) {
        if (self.finishBlock) {
            self.finishBlock(self.moneyTF.text, self.markTF.text);
        }
    }
}

- (IBAction)showMark:(id)sender {
    _markBtn.hidden = YES;
    _markView.hidden = NO;
}

- (void)show{
    self.center = CGPointMake(kScreenWidth*0.5, kScreenHeight*0.5);
    [KeyWindow addSubview:self.bgView];
    [KeyWindow addSubview:self];
    
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.bgView.alpha = 0.3;
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.bgView.alpha = 1;
    }];
}

- (void)dismiss{
    
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.bgView.alpha = 0.3;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.bgView removeFromSuperview];
    }];
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:KeyWindow.bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    }
    return _bgView;
}


/**
 *  textField的代理方法，监听textField的文字改变
 *  textField.text是当前输入字符之前的textField中的text
 *
 *  @param textField textField
 *  @param range     当前光标的位置
 *  @param string    当前输入的字符
 *
 *  @return 是否允许改变
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
        // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
            //当前输入的字符
        unichar single = [string characterAtIndex:0];
        SDLog(@"single = %c",single);
        
            // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
            {
            [SVProgressHUD showImage:nil status:@"只能输入数字"];
            return NO;
            }
        
            // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
            
            
            return NO;
        }
        
            // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
            // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    
                    return NO;
                }
            }
        }
        
            // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
                // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                    
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
}


@end
