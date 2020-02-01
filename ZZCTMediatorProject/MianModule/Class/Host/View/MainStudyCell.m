//
//  MainStudyCell.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/8.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "MainStudyCell.h"
#import "StudyCollectionViewCell.h"
#import "BossStudyViewModel.h"
#import "BossStudyModel.h"

@interface MainStudyCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BossStudyViewModel *viewModel;
@end

@implementation MainStudyCell

- (void)initUI{
    
    self.collectionView.backgroundColor = LZWhiteColor;
    [self.contentView addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.contentView);
        
    }];
    
//    @weakify(self);
//    self.viewModel.CompleteHandler = ^(BOOL isSuccess, BOOL hasMore, NSMutableArray *datas) {
//        @strongify(self);
//
//        [self reloadData];
//    };
//
//    [self.viewModel refreshData];
    
    [self initData];
}

- (void)initData{
    NSArray *arr = @[@{@"createTime":@"2019-10-25",
                       @"content":@"副业吧，您值得从事的事业",
                       @"jumpUrl":@"https://m.lizhiweike.com/lecture2/13911153",
                       @"picture":@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1569818252&di=72016276df3fbc8e60c85cc36ac15664&src=http://hbimg.b0.upaiyun.com/48b4ddaececbc8940418c06f74f6b5fffd9edcdc65c5a-qGqu6t_fw658",
                       @"title":@"副业吧，您值得从事的事业",
                       },
                     @{@"createTime":@"2019-10-25",
                       @"content":@"新零售运营之直营地推",
                       @"jumpUrl":@"https://m.lizhiweike.com/channel2/617026",
                       @"picture":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569828342019&di=e28923390f93053c5636a2dba142259c&imgtype=0&src=http%3A%2F%2Fpic165.nipic.com%2Ffile%2F20180502%2F3604600_141119322000_2.jpg",
                       @"title":@"新零售运营之直营地推",
                       },
                     ];
    
    self.viewModel.dataArray = [BossStudyModel mj_objectArrayWithKeyValuesArray:arr];
    [self reloadData];
}

- (void)reloadData{
    [self.collectionView reloadData];
}

    //定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.dataArray.count;
}

    //定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

    //每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"cell";
    StudyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    BossStudyModel *model = self.viewModel.dataArray[indexPath.row];
    
    [cell.imageView sd_setImageWithURL:TLURL(model.picture)];
    cell.label.text = model.title;
    
    return cell;
}

    //UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BossStudyModel *model = self.viewModel.dataArray[indexPath.row];
    [AppCenter openURL:model.jumpUrl];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(180, 153);
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[StudyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}

- (BossStudyViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [BossStudyViewModel new];
    }
    return _viewModel;
}
@end
