//
//  ZZFilterCollectionViewLayout.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "ZZFilterCollectionViewLayout.h"
#import "FilterCollectionViewCell.h"
#import "FilterModel.h"

@interface ZZFilterCollectionViewLayout ()
@property (nonatomic, strong) NSMutableArray *attributesArray;
@property (nonatomic, assign, readonly) CGFloat spacingW;
@property (nonatomic, assign, readonly) CGFloat spacingTop;
@property (nonatomic, assign, readonly) CGFloat spacingLeft;
@property (nonatomic, assign, readonly) CGFloat itemHeight;

@property (nonatomic, assign) CGFloat X;
@property (nonatomic, assign) CGFloat Y;
@property (nonatomic, assign) CGFloat lastItemRight;

@end

@implementation ZZFilterCollectionViewLayout

- (CGFloat)spacingW{
    return 17;
}

- (CGFloat)spacingTop{
    return 15;
}

- (CGFloat)spacingLeft{
    if (kScreenWidth == 320) {
        return 10;
    }
    return 15;
}

- (CGFloat)itemHeight{
    return 30;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    _Y = self.spacingTop;
    _X = 0;
    _lastItemRight = 0;
    [self.attributesArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attr];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat W = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(ZZLayoutGetWidthWithIndexPath:)]) {
       W = [_delegate ZZLayoutGetWidthWithIndexPath:indexPath];
    }
    
    if ((self.lastItemRight+W+self.spacingLeft) >= kScreenWidth) {
        _X = self.spacingLeft;
        _Y += self.itemHeight+15;
    }else{

        if(_X == 0){
            _X = self.spacingLeft;
        }else{
            _X = self.spacingW+self.lastItemRight;
        }
    }
    
    attributes.frame = CGRectMake(_X, _Y, W, self.itemHeight);
    self.lastItemRight = CGRectGetMaxX(attributes.frame);
    return attributes;
}

- (NSMutableArray *)attributesArray{
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(kScreenWidth, _Y+self.spacingTop+self.itemHeight);
}
@end
