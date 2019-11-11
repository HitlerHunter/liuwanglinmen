//
//  EditTagsCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditTagsCell.h"
#import "EditTagCollectionCell.h"
#import "EditShopTagsModel.h"
#import "ChangeUserNameViewController.h"

@interface EditTagsCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation EditTagsCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"基础设施" textColor:rgb(101,101,101)];
    
    [self addSubview:title_label];
    
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];
    
    _title_label = title_label;

    [self.collectView registerClass:[EditTagCollectionCell class] forCellWithReuseIdentifier:@"EditTagCollectionCell"];
    [self addSubview:self.collectView];
    
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(43);
        make.height.mas_equalTo(72);
        make.bottom.mas_equalTo(-15);
    }];
    
    
    _titleArray = @[@"停车位",@"WIFI",@"儿童座椅",@"免预约",@"充电宝",@"游乐区",];
    
    for (NSString *tag in _titleArray) {
        EditShopTagsModel *tagModel = [EditShopTagsModel new];
        tagModel.structDesc = tag;
        tagModel.type = EditShopTagsTypeTag;
        [self.dataArray addObject:tagModel];
    }
    
    EditShopTagsModel *tagModel = [EditShopTagsModel new];
    tagModel.structDesc = @"自定义添加";
    tagModel.type = EditShopTagsTypeAdd;
    [self.dataArray addObject:tagModel];
    
    [self reloadData];
}


- (UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(98, 28);
        layout.minimumInteritemSpacing = 2;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 50) collectionViewLayout:layout];
        _collectView.backgroundColor = LZWhiteColor;
        _collectView.delegate = self;
        _collectView.dataSource = self;
    }
    return _collectView;
}


- (void)reloadData{
    [_collectView reloadData];
    
    [_collectView layoutIfNeeded];
    CGFloat h = _collectView.contentSize.height;
    [_collectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h);
    }];
}

- (void)addCustomTag:(NSString *)tag{
    EditShopTagsModel *tagModel = [EditShopTagsModel new];
    tagModel.structDesc = tag;
    tagModel.type = EditShopTagsTypeTag;
    [self.dataArray insertObject:tagModel atIndex:self.dataArray.count-1];
}

- (void)setMineDataArray:(NSArray *)array{
    for (EditShopTagsModel *tagModel in array) {
        if (![_titleArray containsObject:tagModel.structDesc]) {
            tagModel.isSelected = YES;
            [self.dataArray insertObject:tagModel atIndex:self.dataArray.count-1];
        }else{
            [self.dataArray enumerateObjectsUsingBlock:^(EditShopTagsModel*  _Nonnull existModel, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([existModel.structDesc isEqualToString:tagModel.structDesc]) {
                    existModel.isSelected = YES;
                }
            }];
        }
    }
    [self reloadData];
}

- (NSArray *)getSelectedTags{
    NSMutableArray *array = [NSMutableArray array];
    for (EditShopTagsModel *tagModel in self.dataArray) {
        if (tagModel.isSelected) {
            [array addObject:tagModel];
        }
    }
    return array;
}

#pragma mark ------ collectionView ------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EditShopTagsModel *model = _dataArray[indexPath.row];
    EditTagCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EditTagCollectionCell" forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EditShopTagsModel *model = _dataArray[indexPath.row];
    if (model.type == EditShopTagsTypeAdd) {
        ChangeUserNameViewController *vc = [[ChangeUserNameViewController alloc] init];
        vc.title = @"自定义添加";
        @weakify(self);
        vc.finishBlock = ^(id  _Nullable obj) {
            @strongify(self);
            if (obj) {
                [self addCustomTag:obj];
            }
            [self reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (!model.isSelected) {//点击未选中的 不能大于6个
            if ([self getSelectedTags].count < 6) {
                model.isSelected = !model.isSelected;
            }else{
                [SVProgressHUD showInfoWithStatus:@"基础设施不能超过6个!"];
            }
        }else{
            model.isSelected = !model.isSelected;
        }
        
        
    }
    
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
