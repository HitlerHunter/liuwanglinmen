//
//  VipPersonDetailCellView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipPersonDetailCellView.h"


@implementation VipPersonDetailCellModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _textAlignment = NSTextAlignmentLeft;
        _titleTextColor = rgb(53,53,53);
        _vauleTextColor = rgb(152,152,152);
        _keyboardType = UIKeyboardTypeDefault;
        _cellStyle = VipPersonDetailCellStyleVauleRight;
    }
    return self;
}

@end

@interface VipPersonDetailCell ()

@property (nonatomic, strong) UIButton *btn_boy;
@property (nonatomic, strong) UIButton *btn_girl;
@property (nonatomic, strong) UITextField *textField_vaule;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation VipPersonDetailCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"" textColor:rgb(152,152,152)];
    label_phone.numberOfLines = 2;
    
    UIImageView *moreIcon = [UIImageView new];
    UIImageView *imageView = [UIImageView new];
    imageView.hidden = YES;
    
    _label_title = label_name;
    _label_vaule = label_phone;
    _icon = moreIcon;
    _imageView = imageView;
    
    [self addSubview:label_name];
    [self addSubview:label_phone];
    [self addSubview:moreIcon];
    [self addSubview:imageView];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name.mas_right).offset(10);
        make.centerY.mas_equalTo(label_name);
    }];
    
    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(label_phone.mas_right).offset(10);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_name.mas_bottom).offset(10);
        make.left.mas_equalTo(label_name);
        make.size.mas_equalTo(CGSizeMake(154, 97));
    }];
}

- (void)addTouch{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick)];
    [self addGestureRecognizer:tap];
}

- (void)cellClick{
    if (self.model.clickBlock) {
        self.model.clickBlock(self.label_vaule.text);
    }
}

- (void)setModel:(VipPersonDetailCellModel *)model{
    _model = model;
    
    self.label_title.text = model.title;
    self.label_vaule.text = model.vaule;
    self.label_title.textColor = model.titleTextColor;
    
    self.label_vaule.textAlignment = model.textAlignment;
    self.label_vaule.textColor = model.vauleTextColor;
    
    if (model.canTap) {
        [self addTouch];
    }
    
    self.icon.hidden = !model.hasIcon;
    if (model.hasIcon && model.tapImage) {
        self.icon.image = UIImageName(model.tapImage);
    }
    
    [self layoutIfNeeded];
    [_label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.label_title.width);
    }];
    
    if (model.cellStyle == VipPersonDetailCellStyleVauleRight) {
        
        @weakify(self);
        [RACObserve(model, vaule) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.label_vaule.text = x;
        }];
        
        [_label_vaule mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label_title.mas_right).offset(10);
            make.centerY.mas_equalTo(self.label_title);
            if(!model.hasIcon)make.right.mas_equalTo(-15);
        }];
        
    }else if (model.cellStyle == VipPersonDetailCellStyleVauleBottom) {
        
        @weakify(self);
        [RACObserve(model, vaule) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.label_vaule.text = x;
        }];
        
        _label_vaule.numberOfLines = 0;
        
        [_label_title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.height.mas_equalTo(16);
        }];
        
        [_label_vaule mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label_title);
            make.top.mas_equalTo(self.label_title.mas_bottom).offset(12);
            make.right.mas_equalTo(-15);
            make.height.mas_greaterThanOrEqualTo(18);
            make.bottom.mas_equalTo(-25);
        }];
        
    }else if (model.cellStyle == VipPersonDetailCellStyleVauleSexChioce){
        _label_vaule.hidden = YES;
        
        [self addSubview:self.btn_boy];
        [self addSubview:self.btn_girl];
        
        [self.btn_boy mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label_title.mas_right).offset(10);
            make.centerY.mas_equalTo(self.label_title);
            make.size.mas_equalTo(CGSizeMake(45, 30));
        }];
        
        [self.btn_girl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.btn_boy.mas_right).offset(20);
            make.centerY.mas_equalTo(self.label_title);
            make.size.mas_equalTo(CGSizeMake(45, 30));
        }];
        
        BOOL isMan = [model.vaule isEqualToString:@"男"];
        self.btn_boy.selected = isMan;
        self.btn_girl.selected = !isMan;
        
        @weakify(self);
        [RACObserve(model, vaule) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            BOOL isMan = [model.vaule isEqualToString:@"男"];
            self.btn_boy.selected = isMan;
            self.btn_girl.selected = !isMan;
        }];
        
    }else if (model.cellStyle == VipPersonDetailCellStyleVauleTextField){
        _label_vaule.hidden = YES;
        
        self.textField_vaule.text = model.vaule;
        self.textField_vaule.textAlignment = model.textAlignment;
        self.textField_vaule.textColor = model.vauleTextColor;
        self.textField_vaule.keyboardType = model.keyboardType;
        self.textField_vaule.placeholder = model.placeholder;
        
        [self addSubview:self.textField_vaule];
        
        [self.textField_vaule mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label_title.mas_right).offset(10);
            make.centerY.mas_equalTo(self.label_title);
            make.right.mas_equalTo(-15);
        }];
       
        self.textField_vaule.text = model.vaule;
        
        @weakify(self);
        [RACObserve(model, vaule) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.textField_vaule.text = model.vaule;
        }];
        
        [[[self.textField_vaule rac_signalForControlEvents:UIControlEventEditingDidEnd] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            self.model.vaule = self.textField_vaule.text;
        }];
    }else if (model.cellStyle == VipPersonDetailCellStyleVauleBottomImage) {
        
        self.imageView.hidden = NO;
        [self.imageView sd_setImageWithURL:TLURL(model.vaule)];
        
        @weakify(self);
        [RACObserve(model, vaule) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if(x)[self.imageView sd_setImageWithURL:TLURL(x)];
        }];
        
        _label_vaule.hidden = YES;
        
        [_label_title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.height.mas_equalTo(16);
        }];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-20);
        }];
        
    }
    
    
}

- (UITextField *)textField_vaule{
    if (!_textField_vaule) {
        _textField_vaule = [UITextField new];
    }
    return _textField_vaule;
}

- (UIButton *)btn_boy{
    if (!_btn_boy) {
        _btn_boy = [self creatSexBtn];
        _btn_boy.selected = YES;
        [_btn_boy setTitle:@"男" forState:UIControlStateNormal];
    }
    return _btn_boy;
}

- (UIButton *)btn_girl{
    if (!_btn_girl) {
        _btn_girl = [self creatSexBtn];
        [_btn_girl setTitle:@"女" forState:UIControlStateNormal];
    }
    return _btn_girl;
}

- (UIButton *)creatSexBtn{
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"" textColor:rgb(152,152,152)];
    [btn setImage:UIImageName(@"board_unSelected") forState:UIControlStateNormal];
    [btn setImage:UIImageName(@"man_selected") forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnSexClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnSexClick:(UIButton *)btn{
    _model.vaule = btn.titleLabel.text;
}

@end

@interface VipPersonDetailCellView ()

@property (nonatomic, strong) NSMutableArray *cellArray;
@end

@implementation VipPersonDetailCellView

- (void)setDataArray:(NSArray<VipPersonDetailCellModel *> *)dataArray{
    _dataArray = dataArray;
    
    _cellArray = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i++) {
        VipPersonDetailCell *cell = [VipPersonDetailCell new];
        VipPersonDetailCellModel *model = dataArray[i];
        cell.model = model;
        [self addSubview:cell];
        
        if (!self.cellArray.count) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(self);
                make.height.mas_greaterThanOrEqualTo(50);
            }];
        }else {
            VipPersonDetailCell *lastCell = self.cellArray.lastObject;
            
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self);
                make.height.mas_greaterThanOrEqualTo(50);
                make.top.mas_equalTo(lastCell.mas_bottom);
            }];
        }
        
        if (i == dataArray.count-1){
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self);
            }];
        }else{
            [cell addBottomLine];
            [cell setBottomLineX:15];
        }
        
        [self.cellArray addObject:cell];
    }
    
}



@end
