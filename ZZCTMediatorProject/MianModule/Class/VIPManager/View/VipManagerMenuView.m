//
//  VipManagerMenuView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipManagerMenuView.h"

@implementation VipManagerMenuModel

+ (VipManagerMenuModel *)initWithTitle:(NSString *)title status:(VipManagerMenuStatus)status{
    VipManagerMenuModel *model = [VipManagerMenuModel new];
    model.title = title;
    model.status = status;
    return model;
}

@end

@interface VipManagerMenuBtn ()

@end

@implementation VipManagerMenuBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.centerX = self.width*0.5;
    self.imageView.left = self.titleLabel.right;
}

- (void)setModel:(VipManagerMenuModel *)model{
    _model = model;
    
    [self setTitle:model.title forState:UIControlStateNormal];
    
    [self refreshUI:model];
    
    @weakify(self);
    [RACObserve(model, status) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self refreshUI:model];
    }];
}

- (void)refreshUI:(VipManagerMenuModel *)model{
    
    if (model.status == VipManagerMenuStatusNoSelected) {
        self.selected = NO;
        [self setImage:UIImageName(@"sort_None") forState:UIControlStateNormal];
    }else if (model.status == VipManagerMenuStatusUp) {
        self.selected = YES;
        [self setImage:UIImageName(@"sort_up") forState:UIControlStateSelected];
    }else if (model.status == VipManagerMenuStatusDown) {
        self.selected = YES;
        [self setImage:UIImageName(@"sort_down") forState:UIControlStateSelected];
    }else if (model.status == VipManagerMenuStatusUnableStatus) {
        self.userInteractionEnabled = NO;
        self.selected = NO;
        [self setImage:UIImageName(@"") forState:UIControlStateNormal];
        [self setImage:UIImageName(@"") forState:UIControlStateSelected];
    }
}

@end


@interface VipManagerMenuView ()
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) NSArray <VipManagerMenuModel *> *menuModelArray;
@end

@implementation VipManagerMenuView

- (void)initUIWithMenuModelArray:(NSArray <VipManagerMenuModel *>*)menuModelArray{
    _menuModelArray = menuModelArray;
    
    _menuArray = [NSMutableArray array];
    
    CGFloat btnW = kScreenWidth / menuModelArray.count;
    for (int i = 0; i < menuModelArray.count; i++) {
        
        VipManagerMenuModel *model = menuModelArray[i];
        
        VipManagerMenuBtn *btn = [[VipManagerMenuBtn alloc] initWithFrame:CGRectMake(btnW*i, 0, btnW, self.height)];
        [self addSubview:btn];
        btn.model = model;
        
        btn.backgroundColor = LZWhiteColor;
        if (kScreenWidth <= 320) {
            btn.titleLabel.font = Font_PingFang_SC_Medium(12);
        }else{
            btn.titleLabel.font = Font_PingFang_SC_Medium(14);
        }
        
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitleColor:rgb(255,81,0) forState:UIControlStateSelected];
        [btn setTitleColor:rgb(53,53,53) forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        [_menuArray addObject:btn];
    }
    
}

- (void)menuClick:(VipManagerMenuBtn *)btn{
    
    VipManagerMenuModel *model = btn.model;
    
    if (model.status == VipManagerMenuStatusUnableStatus) {
        return;
    }
    
    if (model.status == VipManagerMenuStatusDown) {
        model.status = VipManagerMenuStatusUp;
    }else if (model.status == VipManagerMenuStatusUp) {
        model.status = VipManagerMenuStatusDown;
    }else if (model.status == VipManagerMenuStatusNoSelected) {
        model.status = VipManagerMenuStatusDown;
        [_menuModelArray enumerateObjectsUsingBlock:^(VipManagerMenuModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj != model && obj.status != VipManagerMenuStatusUnableStatus) {
                obj.status = VipManagerMenuStatusNoSelected;
            }
        }];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(VipManagerMenuDidSelectedWithTitle:status:)]) {
        [_delegate VipManagerMenuDidSelectedWithTitle:model.title status:model.status];
    }
}

- (void)setSelectedAtIndex:(NSInteger)index{
    if (index > _menuArray.count-1) {
        return;
    }
    
    VipManagerMenuBtn *btn = _menuArray[index];
    [self menuClick:btn];
    
}
@end
