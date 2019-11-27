//
//  HomeToolsView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "HomeToolsView.h"
#import "HomeToolItem.h"

@interface HomeToolsView ()
@property (nonatomic, strong) NSMutableArray *toolItemArray;
@property (nonatomic, strong) NSDictionary *titleIconDic;
@end

@implementation HomeToolsView

- (void)initUI{
    _maxCountOneLine = 3;
    _topSpacing = 30;
}

- (void)setToolsArray:(NSArray *)toolsArray{
    _toolsArray = toolsArray;
    
    [self resetUI];
}

- (void)updateToolsArray:(NSArray *)toolsArray{
    _toolsArray = toolsArray;
    
    NSMutableArray *updateArray = [[NSMutableArray alloc] initWithArray:self.toolItemArray];
    for (int i = 0; i < self.toolItemArray.count; i++) {
        HomeToolItem *existItem = self.toolItemArray[i];
        
        if (![toolsArray containsObject:existItem.titleLab.text]) {
            [updateArray removeObject:existItem];
            [existItem removeFromSuperview];
        }
    }
    
    self.toolItemArray = updateArray;
    
    
    [self updateItemsFrame];
}



- (void)resetUI{

    NSArray *titles = _toolsArray;
    
    NSInteger maxCount = _maxCountOneLine;
    
    CGFloat w = 85;
    CGFloat h = 50;
    
    CGFloat spacingX = (self.width-maxCount*w)/(maxCount+1);
    CGFloat spacingY = 30;
    
    for (int i = 0; i < titles.count; i++) {
        
        NSInteger VerticalNumber = i/maxCount;
        NSInteger HorizontalNumber = i%maxCount;
        
        CGFloat y = VerticalNumber*(h+spacingY)+_topSpacing;
        CGFloat x = HorizontalNumber*(spacingX+w)+spacingX;
        
        NSString *title = titles[i];
        
        HomeToolItem *item = [[HomeToolItem alloc] initWithFrame:CGRectMake(x, y, w, h)];
        item.titleLab.text = title;
        item.imgView.image = UIImageName(self.titleIconDic[title]);
        
        [self addSubview:item];
        
        item.tag = i+100;
        [item addTarget:self action:@selector(toolsClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.toolItemArray addObject:item];
    }
}

- (void)updateItemsFrame{
    
    NSInteger maxCount = 3;
    
    CGFloat w = 85;
    CGFloat h = 50;
    
    CGFloat spacingX = (self.width-maxCount*w)/(maxCount+1);
    CGFloat spacingY = 18;
    
    for (int i = 0; i < self.toolItemArray.count; i++) {
        
        NSInteger VerticalNumber = i/maxCount;
        NSInteger HorizontalNumber = i%maxCount;
        
        CGFloat y = VerticalNumber*(h+spacingY)+spacingY;
        CGFloat x = HorizontalNumber*(spacingX+w)+spacingX;
        
        HomeToolItem *item = self.toolItemArray[i];
        item.frame = CGRectMake(x, y, w, h);
        item.tag = i+100;
        
    }
}


- (void)toolsClick:(HomeToolItem *)item{
    
    if (_delegate && [_delegate respondsToSelector:@selector(HomeToolsView:clickTitle:)]) {
        [_delegate HomeToolsView:self clickTitle:item.titleLab.text];
    }
}


- (void)setUnreadNumber:(id)unreadNumber title:(NSString *)title{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = '%@'",title];
    NSArray *array = [_toolItemArray filteredArrayUsingPredicate:predicate];
    
    if (array.count) {
        HomeToolItem *item = array.firstObject;
        item.message = [NSString stringWithFormat:@"%@",unreadNumber];
    }
}



- (NSMutableArray *)toolItemArray{
    if (!_toolItemArray) {
        _toolItemArray = [NSMutableArray array];
    }
    return _toolItemArray;
}

- (NSDictionary *)titleIconDic{
    if (!_titleIconDic) {
        _titleIconDic = @{
                          @"扫码收款":@"saoma",
                          @"会员管理":@"huiyuanguanli",
                          @"报表管理":@"baobiaoguanli",
                          @"店铺账本":@"zhangben",
                          @"店铺二维码":@"zhangben",
                          @"短信营销":@"xiaoshou",
                          @"悬赏拓客":@"xuanshang",
                          @"优惠券":@"youhuiquan",
                          @"创业大学":@"ketang",
                          @"数据统计":@"tongji",
                    
                          @"收益明细":@"mine_profit",
                          @"我的团队":@"mine_team",
                          @"我的订单":@"mine_order",
                         
                          @"商户入驻":@"mine_ruzhu",
                          @"商户信息":@"mine_ruzhu",
                          @"线上开店":@"mine_kaidian",
                          @"商户管理":@"mine_manager",
                          
                          };
    }
    return _titleIconDic;
}

@end
