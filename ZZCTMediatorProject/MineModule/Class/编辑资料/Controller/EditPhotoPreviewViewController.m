//
//  EditPhotoPreviewViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditPhotoPreviewViewController.h"
#import "EditPhotoModel.h"

@implementation EditPhotoPreviewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
    }
    return self;
}

@end

@interface EditPhotoPreviewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray <EditPhotoModel *>*imageArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray <UIImageView *>*imageViewArray;
@property (nonatomic, strong) UICollectionView *collection;
@end

@implementation EditPhotoPreviewViewController

- (instancetype)initWithDataArray:(NSArray <EditPhotoModel *>*)array
                       startIndex:(NSInteger)startIndex{
    self = [super init];
    if (self) {
        _imageArray = [NSMutableArray arrayWithArray:array];
        _currentIndex = startIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collection];

    self.collection.pagingEnabled = YES;
    [self.collection setContentOffset:CGPointMake(kScreenWidth*_currentIndex, 0) animated:NO];
    
    //关闭
    UIButton *cancelBtn = [UIButton buttonWithFontSize:16 text:@"关闭" textColor:LZOrangeColor];
    cancelBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.base_statusbarHeight+10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    cancelBtn.lz_setView.lz_cornerRadius(6);
    [cancelBtn addTarget:self action:@selector(zz_dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //下滑返回
    UIPanGestureRecognizer *dismissPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(zz_pan:)];
    [self.view addGestureRecognizer:dismissPan];
    
    //删除
    UIButton *removeBtn = [UIButton buttonWithFontSize:20 text:@"删除" textColor:LZOrangeColor];
    removeBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:removeBtn];
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [removeBtn addTarget:self action:@selector(zz_remove) forControlEvents:UIControlEventTouchUpInside];
}

- (void)zz_dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)zz_remove{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除图片" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.imageArray removeObjectAtIndex:self.currentIndex];
        [self.collection reloadData];
        if (self.delegate && [self.delegate respondsToSelector:@selector(editPhotoPreviewDidRemovePhotoAtIndex:)]) {
            [self.delegate editPhotoPreviewDidRemovePhotoAtIndex:self.currentIndex];
        }
        if(self.imageArray.count == 0){
            [self zz_dismiss];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)zz_pan:(UIPanGestureRecognizer *)swipe{
    if (swipe.state == UIGestureRecognizerStateChanged) {
        
        CGPoint point = [swipe translationInView:swipe.view];
        CGFloat moveX = fabs(point.x);
        CGFloat moveY = fabs(point.y);
        
        if (moveY > moveX) {//上下滑动
            if (point.y > 60) {//向下滑动
               [self zz_dismiss];
            }
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _currentIndex = scrollView.offsetX/kScreenWidth;
}

#pragma mark ------ collectionView ------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EditPhotoModel *model = _imageArray[indexPath.row];
    EditPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EditPhotoPreviewCell" forIndexPath:indexPath];
    
    if (model.image) {
        cell.imageView.image = model.image;
    }else if (model.url) {
        [cell.imageView sd_setImageWithURL:TLURL(model.url)];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSMutableArray<UIImageView *> *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        collection.backgroundColor = LZWhiteColor;
        collection.delegate = self;
        collection.dataSource = self;
        [collection registerClass:[EditPhotoPreviewCell class] forCellWithReuseIdentifier:@"EditPhotoPreviewCell"];
        _collection = collection;
    }
    return _collection;
}

@end
