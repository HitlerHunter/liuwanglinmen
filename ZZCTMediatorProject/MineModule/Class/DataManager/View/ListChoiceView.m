//
//  ListChoiceView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/1.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ListChoiceView.h"

@interface ListChoiceView ()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ListChoiceView

- (void)initUI{
    
    self.clipsToBounds = YES;
    [self addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

#pragma mark tapGestureRecgnizerdelegate 解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (touch.view == self) {
        return YES;
    }
    
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    
    if ([touch.view isKindOfClass:[UITableView class]]){
        return YES;
    }
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}

- (void)refreshDataWithArray:(NSArray *)array{
    _dataArray = array;
    
    [self.tableView reloadData];
    [self layoutIfNeeded];
    
    CGFloat height = 45 * array.count;
    self.tableView.height = height>self.height?self.height:height;
    self.tableView.bottom = 0;
}

- (void)showWithSuperView:(UIView *)superView{

    if (self.superview) {
        [self removeFromSuperview];
    }
    
    [superView addSubview:self];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.top = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.bottom = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZBaseTableViewCell"];
    if (!cell) {
        cell = [[LZBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LZBaseTableViewCell"];
        [cell addBottomLine];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self dismiss];
    if (_delegate && [_delegate respondsToSelector:@selector(lz_listClickAtIndex:title:)]) {
        [_delegate lz_listClickAtIndex:indexPath.row title:self.dataArray[indexPath.row]];
    }
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 0;
        
        _tableView.rowHeight = 45;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        _tableView.allowsSelection = YES;
        
        _tableView.backgroundColor = LZWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
    }
    return _tableView;
}
@end
