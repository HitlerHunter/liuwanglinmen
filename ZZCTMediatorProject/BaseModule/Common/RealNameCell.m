    //
    //  RealNameCell.m
    //  ScanPurse
    //
    //  Created by zenglizhi on 2018/3/22.
    //  Copyright © 2018年 zenglizhi. All rights reserved.
    //

#import "RealNameCell.h"
#import "RealNameModel.h"

#define PlaceholderColor UIColorHex(0x929292)
@interface RealNameCell ()
@property (nonatomic, strong) UIImageView * customAccessoryView;
@property (nonatomic, strong) UIButton * rightBtn;
@end

@implementation RealNameCell

- (UIImageView *)customAccessoryView{
    if (!_customAccessoryView) {
        UIImage *image=[UIImage imageNamed:@"my_right"];
        CGFloat imageHeight = image.size.height;
        
        if (!image) {
            return nil;
        }
        UIImageView* accessoryViewBlue = [[UIImageView alloc] initWithImage:image];
        accessoryViewBlue.frame=CGRectMake(0, 0, imageHeight, imageHeight*image.size.height/image.size.width);
        _customAccessoryView = accessoryViewBlue;
    }
    return _customAccessoryView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addBottomLine];
        [self setBottomLineX:15];
    }
    return self;
}

- (void)setUpSubviews{
    
    _title = [UILabel labelWithFontSize:16 textColor:[UIColor blackColor]];
    [self.contentView addSubview:_title];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(21);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    _content = [UILabel labelWithFontSize:14 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight];
    _content.numberOfLines = 2;
    [_content setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:_content];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title.mas_right).mas_offset(0);
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:UIImageName(@"addsavingscards_scan") forState:UIControlStateNormal];
    [self.contentView addSubview:_rightBtn];
    _rightBtn.hidden = YES;
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    _textField = [[UITextField alloc] init];
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.font = _content.font;
    [self.contentView addSubview:_textField];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title.mas_right).mas_offset(0);
        make.right.mas_equalTo(self.contentView).mas_offset(-20);
        make.height.mas_equalTo(21);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    
    [_rightBtn addTarget:self action:@selector(scanClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)scanClick{
    if (self.model.type == RealNameCellTypeScan && self.scanBlock) {
        self.scanBlock(self.model);
    }
}

- (void)setModel:(RealNameModel *)model{
    _model = model;
    
    _title.text = model.title;
    
    @weakify(self);
    [[RACObserve(model, title) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.title.text = x;
        CGFloat width = [model.title tt_sizeWithFont:self.title.font].width;
        [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
        }];
    }];
    
    CGFloat width = [model.title tt_sizeWithFont:_title.font].width;
    [_title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-20);
    }];
    _rightBtn.hidden = YES;
    
    switch (model.type) {
        case RealNameCellTypeLabel:{
            _content.hidden = NO;
            _textField.hidden = YES;
            
            _content.text = model.content;
            
            self.accessoryView = nil;
            
            @weakify(self);
            [[RACObserve(model, content) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                self.content.text = x;
            }];
        }break;
        case RealNameCellTypeSelect:{
            _content.hidden = NO;
            _textField.hidden = YES;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (self.customAccessoryView) {
                self.accessoryView = self.customAccessoryView;
            }
            
            if (model.content.length) {
                _content.text = model.content;
                _content.textColor = [UIColor blackColor];
            }else{
                _content.text = model.placeholder;
                _content.textColor = PlaceholderColor;
            }
            
            
            @weakify(self);
            [[RACObserve(model, content) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSString *x) {
                @strongify(self);
                if (x.length) {
                    self.content.text = x;
                    self.content.textColor = [UIColor blackColor];
                }else{
                    self.content.text = model.placeholder;
                    self.content.textColor = PlaceholderColor;
                }
            }];
        }break;
        case RealNameCellTypeSelectNoTitle:{
            
            _content.hidden = NO;
            _textField.hidden = YES;
            
            self.separatorInset = UIEdgeInsetsMake(0, 100, 0, 0);
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (self.customAccessoryView) {
                self.accessoryView = self.customAccessoryView;
            }
            
            if (model.content.length) {
                _content.text = model.content;
                _content.textColor = [UIColor grayColor];
            }else{
                _content.text = model.placeholder;
                _content.textColor = PlaceholderColor;
            }
            
            
            @weakify(self);
            [[RACObserve(model, content) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSString *x) {
                @strongify(self);
                if (x.length) {
                    self.content.text = x;
                    self.content.textColor = [UIColor blackColor];
                }else{
                    self.content.text = model.placeholder;
                    self.content.textColor = PlaceholderColor;
                }
            }];
        }break;
        case RealNameCellTypeTextField:{
            _content.hidden = YES;
            _textField.hidden = NO;
            self.accessoryType = UITableViewCellAccessoryNone;
            self.accessoryView = nil;
            
            _textField.text = !IsNull(model.content)?model.content:@"";
                //placeholder
            NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:model.placeholder attributes:@{NSFontAttributeName:self.content.font,NSForegroundColorAttributeName:PlaceholderColor}];
            _textField.attributedPlaceholder = placeholder;
            
            if(model.keyboardType) _textField.keyboardType = model.keyboardType;
            
            @weakify(self);
            
            [[[self.textField rac_signalForControlEvents:UIControlEventEditingDidEnd] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                self.model.content = self.textField.text;
            }];

            [[RACObserve(model, content) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSString *x) {
                @strongify(self);
                if (x.length) {
                    self.textField.text = x;
                }else{
                    self.textField.text = @"";
                }
            }];
        }break;
        case RealNameCellTypeScan:{
            _content.hidden = YES;
            _textField.hidden = NO;
            _rightBtn.hidden = NO;
            self.accessoryType = UITableViewCellAccessoryNone;
            self.accessoryView = nil;
            
            [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.contentView).mas_offset(-45);
            }];
            
            _textField.text = !IsNull(model.content)?model.content:@"";
                //placeholder
            NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:model.placeholder attributes:@{NSFontAttributeName:self.content.font,NSForegroundColorAttributeName:PlaceholderColor}];
            _textField.attributedPlaceholder = placeholder;
            
            if(model.keyboardType) _textField.keyboardType = model.keyboardType;
            
            @weakify(self);
            
            [[[self.textField rac_signalForControlEvents:UIControlEventEditingDidEnd] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                self.model.content = self.textField.text;
            }];
            
            [[RACObserve(model, content) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSString *x) {
                @strongify(self);
                if (x.length) {
                    self.textField.text = x;
                }else{
                    self.textField.text = @"";
                }
            }];
        }break;
            
        default:
            break;
    }
}

- (void)hiddenTextField{
    _textField.hidden = YES;
    _content.hidden = NO;
}

@end
