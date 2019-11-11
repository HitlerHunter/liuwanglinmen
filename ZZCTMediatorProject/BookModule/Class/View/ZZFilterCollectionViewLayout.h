//
//  ZZFilterCollectionViewLayout.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZZFilterCollectionViewLayoutDelegate <NSObject>

-(CGFloat)ZZLayoutGetWidthWithIndexPath:(NSIndexPath *)indexPath;
@end

@interface ZZFilterCollectionViewLayout : UICollectionViewLayout

@property (nonatomic , weak) id <ZZFilterCollectionViewLayoutDelegate> delegate;
@end
