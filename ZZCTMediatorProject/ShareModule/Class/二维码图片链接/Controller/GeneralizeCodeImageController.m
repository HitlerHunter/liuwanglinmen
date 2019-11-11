//
//  GeneralizeCodeImageController.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/2.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "GeneralizeCodeImageController.h"
#import "GeneralizeCodeImageCell.h"
#import "GeneralizeCodeImageViewModel.h"
#import <UShareUI/UShareUI.h>

@interface GeneralizeCodeImageController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic)  UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (nonatomic, strong) GeneralizeCodeImageModel *selectedModel;
@end

@implementation GeneralizeCodeImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"推广";
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"分享" font:nil color:nil block:^{

        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                // 根据获取的platformType确定所选平台进行下一步操作
            @strongify(self);
            [self shareImageToPlatformType:platformType];
        }];
    }];
    
    CGFloat scale = 38/25.0;
    CGFloat height = (kScreenWidth-140)*scale;
    
    UIImageView *imageView = [UIImageView new];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-200);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-140, height));
    }];
    _topImageView = imageView;
    
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    
    [self.collectView registerNib:[UINib nibWithNibName:@"GeneralizeCodeImageCell" bundle:nil] forCellWithReuseIdentifier:@"GeneralizeCodeImageCell"];
    
    [GeneralizeCodeImageViewModel requestDatas:^(NSArray *arr) {
        self.dataArray = arr;
        if (arr.count) {
            [arr.firstObject setIsSelected:YES];
            _selectedModel = arr.firstObject;
        }
        
        [self.collectView reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GeneralizeCodeImageModel *model = self.dataArray[indexPath.row];
    model.index = indexPath.row;
    
    GeneralizeCodeImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GeneralizeCodeImageCell" forIndexPath:indexPath];
    
    WeakSelf(weakSelf);
    cell.finishImageBlock = ^(UIImage * obj) {
        weakSelf.topImageView.image = obj;
        
    };
    
    cell.model = model;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _selectedModel.isSelected = NO;
    
    GeneralizeCodeImageModel *model = self.dataArray[indexPath.row];
    model.isSelected = YES;
    
    self.topImageView.image = model.image;
    _selectedModel = model;
}

- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
        //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
        //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [AppCenter appIcon];
    [shareObject setShareImage:self.topImageView.image];
    
        //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
        //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
@end
