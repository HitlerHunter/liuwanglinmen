//
//  BookOrdFilterCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BookOrdFilterCell.h"
#import "ZZFilterCollectionViewLayout.h"
#import "FilterCollectionViewCell.h"
#import "FilterModel.h"
#import "FilterCellModel.h"

@interface BookOrdFilterCell ()<UICollectionViewDelegate,UICollectionViewDataSource,ZZFilterCollectionViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BookOrdFilterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
        
        @weakify(self);
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:FilterClearAllNotificationName object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            for (FilterModel *model in self.model.filterModelArray) {
                model.isSelected = NO;
            }
        }];
    }
    return self;
}

- (void)creatUI{
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(22);
        make.top.mas_equalTo(self.contentView).mas_offset(20);
        make.right.mas_equalTo(self.contentView);
        make.height.equalTo(@20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLab.mas_bottom);

    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}


- (void)setModel:(FilterCellModel *)model{
    _model = model;
    
    [self reloadData];
}

- (void)reloadData{
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    
    CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    SDLog(@"collectionView.height = %.2lf",height);
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.titleLab.mas_bottom);
        make.height.equalTo(@(height));
    }];
    
    self.model.cellHeight = height+50;
}

- (CGFloat)ZZLayoutGetWidthWithIndexPath:(NSIndexPath *)indexPath{
    FilterModel *model = self.model.filterModelArray[indexPath.item];
    return model.width;
}

#pragma mark - delegate
-  (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.filterModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilterModel *model = self.model.filterModelArray[indexPath.item];
    FilterCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.model = model;
    
    //点击选择
    @weakify(self);
    cell.clickBlock = ^(FilterModel *clickModel) {
        @strongify(self);
        if ([clickModel.title isEqualToString:@"展开更多"]) {
            self.model.canShowMore = NO;
            [self.model setFilterModelArray:nil];
            self.model.cellHeight = -1;
            if (self.showBlock) {
                self.showBlock();
            }
            return ;
        }
        
        clickModel.isSelected = !clickModel.isSelected;
        
        if (clickModel != self.model.seletedModel) {
            self.model.seletedModel.isSelected = NO;
            //当前选中的model
            self.model.seletedModel = clickModel;
            //当前选中的下标
            self.model.selectedIndex = indexPath.item;
            
            if (self.clickBlock) {
                self.clickBlock();
            }
        }
        
    };
    return cell;
    
}


- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22, 20, 200, 20)];
        _titleLab.font = kfont(16);
        _titleLab.textColor = UIColorHex(0x232323);
    }
    return _titleLab;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        ZZFilterCollectionViewLayout *layout = [[ZZFilterCollectionViewLayout alloc] init];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.titleLab.bottom, self.width, 65) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
