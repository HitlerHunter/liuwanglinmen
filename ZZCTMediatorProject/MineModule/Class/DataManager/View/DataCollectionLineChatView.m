//
//  DataCollectionLineChatView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataCollectionLineChatView.h"

#define lineCellMinWidth 20

@implementation DataLineCellModel

- (void)setVaule:(CGFloat)vaule{
    _vaule = vaule;
    
    if (_dataType == LineChatDataTypeMoney) {
        _vauleText = [NSString stringWithFormat:@"%.2lf元",vaule];
    }else if (_dataType == LineChatDataTypeCount) {
        _vauleText = [NSString stringWithFormat:@"%d笔",(int)vaule];
    }
    
}
@end

@implementation DataCollectionLineCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UILabel *lab = [UILabel labelWithFontSize:13 text:@"" textAlignment:NSTextAlignmentCenter];
    lab.textColor = rgb(152,152,152);
    [self addSubview:lab];
    
    _titleLabel = lab;
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self);
        make.bottom.mas_equalTo(-15);
    }];
    
    UIView *point = [UIView new];
    _point = point;
    
    [self unSelecetPoint];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    _point.centerX = self.centerX;
}

- (void)setModel:(DataLineCellModel *)model{
    _model = model;
    
#pragma mark cell日期显示
    if (self.width>=57) {
        _titleLabel.text = model.dateYMD;
    }else if (self.width>lineCellMinWidth*2 && self.width<57){
        _titleLabel.text = model.dateMD;
    }else{
        _titleLabel.text = model.dateDay;
    }
    
    if (CGPointEqualToPoint(model.point, CGPointZero)) {
        self.point.center = model.point;
    }else{
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.point.center = model.point;
        } completion:nil];
    }
    
    @weakify(self);
    [[RACObserve(model, isSelected) takeUntil:model.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self setUpBgView];
    }];
    
}

- (void)setUpBgView{
    
    [self clearGradient];
    
    if (_model.isSelected) {
        [self selecetPoint];
        [self setGradientWithColorArray:@[rgb(255,223,208),rgb(246,246,246)] cornerRadius:0 directionType:GradientDirectionTypeVertical];
    }else{
        [self unSelecetPoint];
        if(_model.cellStyle == DataLineCellStyleSingle){
            
        }else{
            [self setGradientWithColorArray:@[rgb(233,232,228),rgb(245,245,245)] cornerRadius:0 directionType:GradientDirectionTypeVertical];
        }
    }
    
    
}

- (void)selecetPoint{
    CGPoint center = _point.center;
    CGSize size = CGSizeMake(12, 12);
    
    _point.backgroundColor = rgb(255,81,0);
    _point.lz_setView.lz_cornerRadius(size.width*0.5).lz_border(2, rgb(255,172,133));
    _point.frame = CGRectMake(center.x-size.width*0.5, center.y-size.height*0.5, size.width, size.height);
}

- (void)unSelecetPoint{
    CGPoint center = _point.center;
    CGSize size = CGSizeMake(6, 6);
    
    _point.backgroundColor = LZWhiteColor;
    _point.lz_setView.lz_cornerRadius(size.width*0.5).lz_border(1, rgb(255,81,0));
    _point.frame = CGRectMake(center.x-size.width*0.5, center.y-size.height*0.5, size.width, size.height);
    
}
@end

@implementation ChartScrollView



@end

typedef NS_ENUM(NSUInteger, ChartVauleShowDirection) {
    /**三角形top右边*/
    ChartVauleShowDirectionTopRight,
    /**三角形bottom右边*/
    ChartVauleShowDirectionBottomRight,
    /**三角形top左边*/
    ChartVauleShowDirectionTopLeft,
    /**三角形bottom左边*/
    ChartVauleShowDirectionBottomLeft,
    
};

@interface ChartVauleShowView ()
@property (nonatomic,assign) ChartVauleShowDirection direction;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CAShapeLayer *pathLayer;
@end

@implementation ChartVauleShowView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _direction = ChartVauleShowDirectionBottomRight;
        
        UILabel *lab = [UILabel labelWithFontSize:12 text:@"" textAlignment:NSTextAlignmentCenter];
        lab.textColor = rgb(152,152,152);
        [self addSubview:lab];
        
        _titleLabel = lab;
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(9, 5, 5, 5));
        }];
    }
    return self;
}

- (void)setDirection:(ChartVauleShowDirection)direction{
    _direction = direction;
    [self drawRect:self.bounds];
}

- (void)drawRect:(CGRect)rect{
    
    [_pathLayer removeFromSuperlayer];
    
    CGFloat rightSpcingX = self.width -20;
    
    if (self.direction == ChartVauleShowDirectionTopLeft || self.direction == ChartVauleShowDirectionBottomLeft) {
        rightSpcingX = 10;
    }
    
    CGFloat squareH = 4;//三角形高
    CGFloat squareW = 10;//三角形宽
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    if (self.direction == ChartVauleShowDirectionTopLeft || self.direction == ChartVauleShowDirectionTopRight) {
        
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(9, 5, 5, 5));
        }];
        
        [bezierPath moveToPoint:CGPointMake(0,squareH)];
        [bezierPath addLineToPoint:CGPointMake(rightSpcingX,squareH)];
        [bezierPath addLineToPoint:CGPointMake(rightSpcingX+squareW*0.5,0)];
        [bezierPath addLineToPoint:CGPointMake(rightSpcingX+squareW,squareH)];
        
        [bezierPath addLineToPoint:CGPointMake(self.width,squareH)];
        [bezierPath addLineToPoint:CGPointMake(self.width,self.height)];
        [bezierPath addLineToPoint:CGPointMake(0,self.height)];
        
    }else if (self.direction == ChartVauleShowDirectionBottomRight || self.direction == ChartVauleShowDirectionBottomLeft) {
        
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 9, 5));
        }];
        
        [bezierPath moveToPoint:CGPointMake(0,0)];
        [bezierPath addLineToPoint:CGPointMake(self.width,0)];
        [bezierPath addLineToPoint:CGPointMake(self.width,self.height-squareH)];
        [bezierPath addLineToPoint:CGPointMake(rightSpcingX+squareW,self.height-squareH)];
        [bezierPath addLineToPoint:CGPointMake(rightSpcingX+squareW*0.5,self.height)];
        [bezierPath addLineToPoint:CGPointMake(rightSpcingX,self.height-squareH)];
        [bezierPath addLineToPoint:CGPointMake(0,self.height-squareH)];
    }
    
    [bezierPath addLineToPoint:CGPointMake(0,0)];
    
    [bezierPath closePath];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 1;
    pathLayer.fillColor = [UIColor whiteColor].CGColor;
//    pathLayer.strokeColor = [UIColor clearColor].CGColor;
    
    pathLayer.path = bezierPath.CGPath;
    pathLayer.shadowColor = rgba(0,0,0,0.11).CGColor;
        // 阴影偏移，默认(0, -3)
    pathLayer.shadowOffset = CGSizeMake(0,0);
    pathLayer.shadowOpacity = 1;
        // 阴影半径，默认3
    pathLayer.shadowRadius = 3;
    pathLayer.cornerRadius = 3;
    
    _pathLayer = pathLayer;
    [self.layer insertSublayer:pathLayer below:_titleLabel.layer];
}

@end

@interface DataCollectionLineChatView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) ChartScrollView *scrollView;
@property (nonatomic, strong) CAShapeLayer *bezierLineLayer;
@property (nonatomic, strong) NSArray <DataLineCellModel *> *dataArray;
@property (nonatomic, strong) NSMutableArray  *pointArray;
@property (nonatomic, strong) NSMutableArray <DataCollectionLineCell *> *cellArray;
@property (nonatomic, strong) NSMutableArray  *pointViewArray;
/**被选中的cell*/
@property (nonatomic, strong) DataCollectionLineCell *selectedCell;
@property (nonatomic, strong) ChartVauleShowView *vauleShowView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIBezierPath *lastPath;

@property (nonatomic, assign) CGFloat lineCellWidth;
@end

@implementation DataCollectionLineChatView
{
    CGFloat     _axisToViewPadding;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _axisToViewPadding = 27;
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.backgroundColor = rgb(245,245,245);
    
    UILabel *lab = [UILabel labelWithFontSize:12 text:@"" textAlignment:NSTextAlignmentCenter];
    lab.textColor = rgb(152,152,152);
    [self addSubview:lab];
    
    _titleLabel = lab;
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(95, 30));
    }];
    
    _titleLabel.lz_setView.lz_cornerRadius(15).lz_border(2, rgb(234,234,234));
    
    self.scrollView.backgroundColor = rgb(245,245,245);
    [self addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.mas_equalTo(self);
        make.top.mas_equalTo(40);
    }];
    
    /** 将折线添加到折线图层上，并设置相关的属性 */
    _bezierLineLayer = [CAShapeLayer layer];
    _bezierLineLayer.strokeColor = rgb(255,81,0).CGColor;
    _bezierLineLayer.fillColor = [[UIColor clearColor] CGColor];
        // 默认设置路径宽度为0，使其在起始状态下不显示
    _bezierLineLayer.lineWidth = 2;
    _bezierLineLayer.lineCap = kCALineCapRound;
    _bezierLineLayer.lineJoin = kCALineJoinRound;

    _vauleShowView = [[ChartVauleShowView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    _vauleShowView.hidden = YES;
    [self.scrollView addSubview:_vauleShowView];
}

- (void)refreshDataWithDataArray:(NSArray <DataLineCellModel *>*)dataArray{
    
    _dataArray = dataArray;

    if (dataArray.count == 0) {
        return;
    }
    
    
    self.lineCellWidth = kScreenWidth / dataArray.count;
    self.lineCellWidth = self.lineCellWidth<lineCellMinWidth?lineCellMinWidth:self.lineCellWidth;
    
#pragma 创建cell
    if (self.cellArray.count < dataArray.count) {
        NSInteger needCount = dataArray.count - self.cellArray.count;
        
        for (int i = 0; i < needCount; i++) {
            DataCollectionLineCell *cell = [DataCollectionLineCell new];
            [self.cellArray addObject:cell];
            [self.scrollView addSubview:cell];
            [self.scrollView addSubview:cell.point];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTap:)];
            [cell addGestureRecognizer:tap];
        }
    }

    [self.cellArray enumerateObjectsUsingBlock:^(DataCollectionLineCell  *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        cell.hidden = YES;
        cell.point.hidden = YES;
    }];

#pragma 处理
    __block  CGFloat maxVaule = 0.0f;
    CGFloat lineCellHeight = self.height-40;
    
    [dataArray enumerateObjectsUsingBlock:^(DataLineCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxVaule < obj.vaule) {
            maxVaule = obj.vaule;
        }
    }];
    
    maxVaule = maxVaule==0?1:maxVaule * 1.1;
    
    CGFloat lineCellHeight1 = lineCellHeight-40;//需要和底部保持一定距离
    
    _pointArray = [NSMutableArray array];
    [dataArray enumerateObjectsUsingBlock:^(DataLineCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.percent = obj.vaule / maxVaule;
        obj.point = CGPointMake(idx*self.lineCellWidth+self.lineCellWidth*0.5, lineCellHeight1*(1-obj.percent));
        [self.pointArray addObject:[NSValue valueWithCGPoint:obj.point]];
        SDLog(@"pointY = %.2lf percent = %.2lf ",obj.point.y,(1-obj.percent));
    }];
    
    for (int i = 0; i < dataArray.count; i++) {
        DataCollectionLineCell  *cell = self.cellArray[i];
        cell.hidden = NO;
        cell.point.hidden = NO;
        cell.frame = CGRectMake(self.lineCellWidth * i, 0, self.lineCellWidth, lineCellHeight);
        
        DataLineCellModel *model = dataArray[i];
        model.cellStyle = i%2;
        cell.model = model;
        
    }
    
    self.scrollView.contentSize = CGSizeMake(dataArray.count*self.lineCellWidth, 0);
    
    [self drawBezierPath];
    
    [self.cellArray enumerateObjectsUsingBlock:^(DataCollectionLineCell  *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.scrollView bringSubviewToFront:cell.point];
    }];
    
    //更新paths后会盖住vauleShowView
    [self.scrollView bringSubviewToFront:_vauleShowView];
//    self.titleLabel.hidden = YES;
//    _vauleShowView.hidden = YES;
    
    NSInteger countInPage = (NSInteger)(kScreenWidth/self.lineCellWidth);
    NSInteger centerIndex = countInPage/2;
    
    [self cellTapWithCell:self.cellArray[centerIndex]];
}

#pragma mark - cellTap
- (void)cellTap:(UITapGestureRecognizer *)tap{
    DataCollectionLineCell *cell = (DataCollectionLineCell *)tap.view;
    
    [self cellTapWithCell:cell];
}

- (void)cellTapWithCell:(DataCollectionLineCell *)cell{
    if (cell.model.isSelected == YES) {
        return;
    }
    
    cell.model.isSelected = YES;
    
    self.titleLabel.text = cell.model.dateYMD;
    _vauleShowView.titleLabel.text = cell.model.vauleText;
    
    CGFloat textWidth = [cell.model.vauleText tt_sizeWithFont:Font_PingFang_SC_Regular(16)].width;
    _vauleShowView.width = textWidth>70?textWidth:70;
    
    self.titleLabel.hidden = NO;
    _vauleShowView.hidden = NO;
    
        //vauleShowView 的位置
    if (cell.right <= _vauleShowView.width) {
        _vauleShowView.left = cell.centerX-15;
        if (cell.point.centerY < 50) {
            _vauleShowView.direction = ChartVauleShowDirectionTopLeft;
            _vauleShowView.top = cell.point.y+20;
            
        }else{
            _vauleShowView.direction = ChartVauleShowDirectionBottomLeft;
            _vauleShowView.bottom = cell.point.y-10;
        }
    }else{
        
        _vauleShowView.right = cell.centerX+15;
        if (cell.point.centerY < 50) {
            _vauleShowView.direction = ChartVauleShowDirectionTopRight;
            _vauleShowView.top = cell.point.y+20;
        }else{
            _vauleShowView.direction = ChartVauleShowDirectionBottomRight;
            _vauleShowView.bottom = cell.point.y-10;
        }
    }
    
    
    [self.scrollView bringSubviewToFront:_vauleShowView];
    
    if (_selectedCell) {
        _selectedCell.model.isSelected = NO;
    }
    
    _selectedCell = cell;
}

#pragma mark - drawBezierPath
- (void)drawBezierPath{
   
    NSValue *firstPointValue = [NSValue valueWithCGPoint:CGPointMake(_axisToViewPadding, (CGRectGetHeight(self.frame) - _axisToViewPadding) / 2)];
    [self.pointArray insertObject:firstPointValue atIndex:0];
    
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(self.scrollView.contentSize.width+_axisToViewPadding, (CGRectGetHeight(self.frame) - _axisToViewPadding) / 2)];
    [self.pointArray addObject:endPointValue];
    
    /** 折线路径 */
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.pointArray.count-3; i++) {
        CGPoint p1 = [[_pointArray objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[_pointArray objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[_pointArray objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[_pointArray objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [path moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:path];
    }
    
    
    [_bezierLineLayer removeFromSuperlayer];
    [self.scrollView.layer addSublayer:_bezierLineLayer];
    
    if (!_lastPath) {
        _bezierLineLayer.path = path.CGPath;
        
    }else{
            //path动画
        CABasicAnimation *animation_path = [CABasicAnimation animationWithKeyPath:@"path"];
        animation_path.fromValue = (id)_lastPath.CGPath;
        animation_path.toValue = (id)path.CGPath;
        animation_path.duration = .25f;
        animation_path.removedOnCompletion = NO;
        animation_path.fillMode = kCAFillModeForwards;
        
        [_bezierLineLayer addAnimation:animation_path forKey:@"animation_path"];
    }
    
    
    _lastPath = path;
    
}

- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*) path{
    
    CGFloat smooth_value = 0.6;
    CGFloat ctrl1_x;
    CGFloat ctrl1_y;
    CGFloat ctrl2_x;
    CGFloat ctrl2_y;
    CGFloat xc1 = (x0 + x1) /2.0;
    CGFloat yc1 = (y0 + y1) /2.0;
    CGFloat xc2 = (x1 + x2) /2.0;
    CGFloat yc2 = (y1 + y2) /2.0;
    CGFloat xc3 = (x2 + x3) /2.0;
    CGFloat yc3 = (y2 + y3) /2.0;
    CGFloat len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    CGFloat len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
    CGFloat len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    [path addCurveToPoint:CGPointMake(x2, y2) controlPoint1:CGPointMake(ctrl1_x, ctrl1_y) controlPoint2:CGPointMake(ctrl2_x, ctrl2_y)];
}




- (ChartScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[ChartScrollView alloc] init];
        
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _scrollView.backgroundColor = LZBackgroundColor;
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}


- (NSMutableArray<DataCollectionLineCell *> *)cellArray{
    if (!_cellArray) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}

- (NSMutableArray *)pointViewArray{
    if (!_pointViewArray) {
        _pointViewArray = [NSMutableArray array];
    }
    return _pointViewArray;
}
@end
