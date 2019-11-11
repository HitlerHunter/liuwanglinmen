//
//  EditBgImageSelectCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditBgImageSelectCell.h"
#import "YPhotoAblumTableViewController.h"
#import "YPhotoNavViewController.h"
#import "YPhotoGlobalVar.h"
#import "EditPhotoSelectCell.h"

#import "EditPhotoModel.h"
#import "EditPhotoPreviewViewController.h"

@interface EditBgImageSelectCell ()<UICollectionViewDelegate,UICollectionViewDataSource,YPhotoGlobalDelegate,UIGestureRecognizerDelegate,EditPhotoPreviewDelegate>
{
    UICollectionView * collection;
}

@property (strong,nonatomic) YPhotoGlobalVar * globalVar;  //全局变量
@property (strong,nonatomic) NSMutableArray * dataArray;
@property (strong,nonatomic) NSMutableArray * imgs;  //接收返回的图片
@end

@implementation EditBgImageSelectCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *title_label = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"店铺背景图" textColor:rgb(101,101,101)];
    UILabel *text_label = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"（最多上传6张照片,建议横屏拍摄）" textColor:rgb(53,53,53)];
    text_label.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:title_label];
    [self addSubview:text_label];

    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];
    
    [text_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title_label.mas_right).offset(5);
//        make.centerY.mas_equalTo(text_label);
        make.top.mas_equalTo(12);
    }];
   
    _title_label = title_label;
    _text_label = text_label;
    
    [self initPhotoView];
}


- (void)setTitle:(NSString *)title{
    _title_label.text = title;
}

- (void)setText:(NSString *)text{
    _text = text;
    self.text_label.text = text;
}

#pragma mark ------ Photo ------
- (void)initPhotoView{
    
    _imgs = [NSMutableArray new];
    
    [self setView];
}

- (void)setView {
    
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(110, 72);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 50) collectionViewLayout:layout];
    collection.backgroundColor = LZWhiteColor;
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[EditPhotoSelectCell class] forCellWithReuseIdentifier:@"EditPhotoSelectCell"];
    [self addSubview:collection];
    
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.text_label.mas_bottom).offset(15);
        make.height.mas_equalTo(72);
        make.bottom.mas_equalTo(-15);
    }];
    
//    [self didFinishSelectPhotos:[YPhotoGlobalVar shareGlobalVar]];

}


//点击按钮进入相册的方法
- (void)presentPhoto {
    
        //设置全局变量
    _globalVar = [YPhotoGlobalVar shareGlobalVar];
    _globalVar.delegate = self;
        //设置图片类型 png jpg  default is jpg
    _globalVar.png = YES;
    _globalVar.maxNum = (int)(7 -_dataArray.count);
    
        //以下这几步是必须的
    YPhotoAblumTableViewController * y = [YPhotoAblumTableViewController new];
    YPhotoNavViewController * n = [[YPhotoNavViewController alloc]initWithRootViewController:y];
        //必须是present方式进入照片选择器;
    [self.topViewController presentViewController:n animated:YES completion:nil];
}

- (void)didFinishSelectPhotos:(YPhotoGlobalVar *)photoManager{
    
//    [_dataArray removeAllObjects];
        //添加图片
    if (_globalVar.selectedImgs.count >0) {
        
        for (UIImage *image in photoManager.selectedImgs) {
            EditPhotoModel *model = [EditPhotoModel new];
            model.image = image;
            model.cellType = EditPhotoCellTypeImage;
            model.type = @"backgroup";
//            [self.dataArray addObject:model];
            [self.dataArray insertObject:model atIndex:self.dataArray.count-1];
        }
    }
//
//    //add
//    EditPhotoModel *model = [EditPhotoModel new];
//    model.image = UIImageName(@"edit_photo_add");
//    model.cellType = EditPhotoCellTypeAdd;
//    [self.dataArray addObject:model];
//
    [self reloadData];
    
}

- (void)reloadData{
    [collection reloadData];
    
    [collection layoutIfNeeded];
    CGFloat h = self->collection.contentSize.height;
    [collection mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height
        .mas_equalTo(h>72?h:72);
    }];
}

- (void)setImageArray:(NSArray *)imageArray{
    
    for (EditPhotoModel *model  in imageArray) {
        
        model.cellType = EditPhotoCellTypeImage;
        if ([model.type isEqualToString:@"backgroup"]) {
            [self.dataArray addObject:model];
        }
    }
    
    //add
    EditPhotoModel *model = [EditPhotoModel new];
    model.image = UIImageName(@"edit_photo_add");
    model.cellType = EditPhotoCellTypeAdd;
    [self.dataArray addObject:model];
    
    [self reloadData];
}

- (NSArray *)imageArray{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray];
    [array removeLastObject];
    return array;
}

#pragma mark ------ collectionView ------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EditPhotoModel *model = _dataArray[indexPath.row];
    EditPhotoSelectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EditPhotoSelectCell" forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    EditPhotoModel *model = _dataArray[indexPath.row];
    if (model.cellType == EditPhotoCellTypeAdd) {
        [self presentPhoto];
    }else{
        
        /*
         显示弹窗后，若长按时间过长，
         松开就会跳转EditPhotoPreviewViewController
         弹窗就会上移，故不让跳转
         **/
        if ([self.topViewController isKindOfClass:[UIAlertController class]]) {
            return;
        }
        
        //图片浏览
        EditPhotoPreviewViewController *preview = [[EditPhotoPreviewViewController alloc] initWithDataArray:self.imageArray startIndex:indexPath.row];
        preview.delegate = self;
        [self.topViewController presentViewController:preview animated:YES completion:nil];
    }
}

    //UICollectionView menu delegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{

    EditPhotoModel *model = _dataArray[indexPath.row];
    if (model.cellType == EditPhotoCellTypeImage) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除图片" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.dataArray removeObject:model];
            [self->collection reloadData];
        }]];
        [self.topViewController presentViewController:alert animated:YES completion:nil];
    }
    
    return NO;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
        //do nothin
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
        //do nothing
}

#pragma mark ------ EditPhotoPreviewDelegate ------
- (void)editPhotoPreviewDidRemovePhotoAtIndex:(NSInteger)index{
    [self.dataArray removeObjectAtIndex:index];
    [self->collection reloadData];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
