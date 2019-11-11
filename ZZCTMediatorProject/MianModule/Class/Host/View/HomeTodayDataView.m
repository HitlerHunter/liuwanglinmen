//
//  HomeTodayDataView.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/8.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "HomeTodayDataView.h"
#import <SDCycleScrollView.h>

@implementation HomeTodayMoneyItemModel

+ (HomeTodayMoneyItemModel *)modelWithMoney:(NSString *)money
                                      title:(NSString *)title{
    
    HomeTodayMoneyItemModel *model = [HomeTodayMoneyItemModel new];
    model.money = money;
    model.title = title;
    return model;
}

@end

@implementation HomeTodayMoneyModel

@end

@implementation HomeTodayMoneyView

- (void)initUI{
    
    UILabel *lab1 = [UILabel labelWithFontSize:20 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    [self addSubview:lab1];
    _moneyLabel = lab1;
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(3);
    }];
    
    UILabel *lab3 = [UILabel labelWithFontSize:12 textColor:[UIColor grayColor] textAlignment:NSTextAlignmentCenter];
    lab3.text = @"今日收益 (元)";
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(lab1);
        make.top.mas_equalTo(lab1.mas_bottom).offset(5);
    }];
    _titleLabel = lab3;
    
}

@end

@implementation HomeTodayCollectCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _moneyView = [HomeTodayMoneyView new];
        [self.contentView addSubview:_moneyView];
        [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(self.contentView);
        }];
        
        _moneyView2 = [HomeTodayMoneyView new];
        [self.contentView addSubview:_moneyView2];
        [_moneyView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.moneyView.mas_right);
            make.width.mas_equalTo(self.moneyView);
        }];
    }
    return self;
}

@end

@interface HomeTodayDataView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation HomeTodayDataView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageName(@"shouyishuju")];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.centerX.mas_equalTo(self);
    }];
   
    [self addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(36);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(54);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = LZBackgroundColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-17);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        CGFloat width = kScreenWidth;
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 36, width, 54) delegate:self placeholderImage:nil];
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}

- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    return [HomeTodayCollectCell class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    HomeTodayCollectCell *cell1 = (HomeTodayCollectCell *)cell;
    HomeTodayMoneyModel *model = self.dataArray[index];
    HomeTodayMoneyItemModel *item1 = [model.dataArray safeObjectWithIndex:0];
    if (item1) {
        cell1.moneyView.moneyLabel.text = item1.money;
        cell1.moneyView.titleLabel.text = item1.title;
    }
    HomeTodayMoneyItemModel *item2 = [model.dataArray safeObjectWithIndex:1];
    if (item2) {
        cell1.moneyView2.moneyLabel.text = item2.money;
        cell1.moneyView2.titleLabel.text = item2.title;
    }
}

- (void)setDataArray:(NSArray<HomeTodayMoneyModel *> *)dataArray{
    _dataArray = dataArray;
    self.cycleScrollView.localizationImageNamesGroup = dataArray;
}

//今日收益（元） 累计收益（元）
@end
