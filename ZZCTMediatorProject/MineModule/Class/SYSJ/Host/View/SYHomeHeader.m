//
//  SYHomeHeader.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/11.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SYHomeHeader.h"


@interface SYHomeHeader ()
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;

@property (weak, nonatomic) IBOutlet UIView *typeBgView;

@property (nonatomic, strong) SYHomeTypeView *typeScrollView;
@end

@implementation SYHomeHeader

- (void)initUI{
    
    [self.typeBgView addSubview:self.typeScrollView];
    
    [self.cashBtn setDefaultGradientWithCornerRadius:13];
}


- (IBAction)toCash:(id)sender {
    if (self.toCashBlock) {
        self.toCashBlock();
    }
}

- (IBAction)showMoney:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        self.moneyAllLabel.text = @"******";
    }else{
        self.moneyAllLabel.text = self.allMoney;
    }
}

- (SYHomeTypeView *)typeScrollView{
    if (!_typeScrollView) {
        _typeScrollView = [[SYHomeTypeView alloc] initWithFrame:self.typeBgView.bounds maker:^(SYHomeTypeMaker * _Nonnull maker) {
            
        }];
        
    }
    return _typeScrollView;
}

- (void)setDelegate:(id<SYHomeTypeViewDelegate>)delegate{
    self.typeScrollView.delegate = delegate;
}

- (void)setTitleArray:(NSArray *)titleArray{
    [self.typeScrollView initWithTitleArray:titleArray];
}
@end
