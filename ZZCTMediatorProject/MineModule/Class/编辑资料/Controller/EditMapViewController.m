//
//  EditMapViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditMapViewController.h"
#import "EditMapAnnotation.h"
#import "ZZCLGeocoder.h"
#import "CTMediator+ModuleMineActions.h"

@interface EditMapViewController ()<MKMapViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
 //地图属性
@property (nonatomic, strong) MKMapView *mapView;
//定位管理对象
@property (nonatomic, strong) CLLocationManager *locationManger;
//地理编码对象
@property (nonatomic, strong) ZZCLGeocoder *geoCoder;
@property (nonatomic, strong) EditMapAnnotation *annotation;
@property (nonatomic, strong) FinishBlock block;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

@property (nonatomic, assign) BOOL hasInit;
@end

@implementation EditMapViewController

- (instancetype)initWithLatitude:(NSString *)latitude
                       longitude:(NSString *)longitude
                     FinishBlock:(FinishBlock)block{
    if (self = [super init]) {
        _block = block;
        _latitude = latitude.doubleValue;
        _longitude = longitude.doubleValue;
    }
    return self;
}
    //懒加载
-(CLLocationManager *)locationManger {
    if (!_locationManger) {
        _locationManger = [CLLocationManager new];
    }
    return _locationManger;
}

- (ZZCLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder = [[ZZCLGeocoder alloc] init];
    }
    return _geoCoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"经营地址";
    
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    
    self.mapView.scrollEnabled = YES;
    self.mapView.zoomEnabled = YES;
    self.mapView.showsScale = YES;
    
        //3.请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            //请求用户授权
        [self.locationManger requestWhenInUseAuthorization];
    }
    
        //4.重要,让地图显示当前用户的位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
        //设置代理对象
    self.mapView.delegate = self;
    
        //添加大头针标注模型(用来展示大头针所定的位置上信息)
    [self.mapView addAnnotation:self.annotation];
    [self.view addSubview:self.mapView];
    
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"确定" font:nil color:nil block:^{
        @strongify(self);
        if (self.block) {
            self.block(self.dic);
        }
        [self lz_popController];
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:UIImageName(@"edit_map_mineLocation") forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.bottom.mas_equalTo(-20);
    }];
    
    [btn addTarget:self action:@selector(toMineLocation) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    [self.mapView addGestureRecognizer:mTap];
    
    [self addSearchBar];
}

- (void)tapPress:(UIGestureRecognizer*)gestureRecognizer {
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
    _annotation.coordinate = touchMapCoordinate;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:_annotation.coordinate.latitude longitude:_annotation.coordinate.longitude];
    @weakify(self);
    [self.geoCoder reverseGeocodeLocation:location block:^(NSDictionary * _Nonnull dic) {
        @strongify(self);
        self.annotation.title = [NSString stringWithFormat:@"%@%@%@",self.dic[ZZLocationStateKey],self.dic[ZZLocationCityKey],self.dic[ZZLocationDistrictKey]];
        self.annotation.subtitle = dic[ZZLocationNameKey];
        self.dic = dic;
    }];
}

- (void)toMineLocation{
        //2. 设置范围的属性
    if (!_latitude && !_longitude) {
            //获取用户当前坐标
        CLLocationCoordinate2D coordinate = self.mapView.userLocation.location.coordinate;
        _annotation.coordinate = coordinate;
        [self.mapView setCenterCoordinate:coordinate zoomLevel:13 animated:NO];
    }else{
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(_latitude, _longitude);
        [self.mapView setCenterCoordinate:coordinate zoomLevel:13 animated:NO];
        _annotation.coordinate = coordinate;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark - 滑动地图结束修改当前位置
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
    if (!_hasInit) {
        _hasInit = YES;
        [self toMineLocation];
    }
}

#pragma mark - 地图的代理方法
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
        //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[EditMapAnnotation class]]) {

        MKAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"EditMapAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"EditMapAnnotation"];
            annotationView.canShowCallout = true;//允许交互点击
            
//            UILabel *lab = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"sss" textColor:rgb(255,81,0)];
//            lab.frame = CGRectMake(0, 0, 200, 40);
//            annotationView.detailCalloutAccessoryView = lab;
//            [annotationView addSubview:lab];
        }
        
        annotationView.annotation = annotation;
        annotationView.image = [UIImage imageNamed:@"mapView_annotation"];    //设置大头针视图的图片
        [annotationView setSelected:YES animated:YES];
        return annotationView;
    }else{
        return nil;
    }
}

- (EditMapAnnotation *)annotation{
    if (!_annotation) {
        _annotation = [[EditMapAnnotation alloc] init];
    }
    return _annotation;
}


#pragma mark - 搜索 -
- (void)addSearchBar{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, 30)];
    view.backgroundColor = [LZOrangeColor colorWithAlphaComponent:0.4];
    [self.view addSubview:view];
    
    UITextField *tf = [UITextField new];
    tf.textAlignment = NSTextAlignmentCenter;
    tf.placeholder = @"搜索";
    tf.font = Font_PingFang_SC_Regular(14);
    tf.returnKeyType = UIReturnKeySearch;
    tf.delegate = self;
    [view addSubview:tf];
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *str = textField.text;
    [textField resignFirstResponder];
    if (str.length) {
        [self searchAddress:str];
    }
    return YES;
}

- (void)searchAddress:(NSString *)address{
    
    @weakify(self);
    [self.geoCoder geocodeAddressString:address block:^(NSArray<ZZCLAddressModel *> * _Nonnull dataArray, NSArray * _Nonnull addressArray) {
        @strongify(self);
     UIViewController *vc = [[CTMediator sharedInstance] CTMediator_SelectStoreWithDataArray:addressArray block:^(NSInteger index, NSString *storeName) {
         ZZCLAddressModel *address = dataArray[index];
         
         [self.mapView setCenterCoordinate:address.centerCoordinate zoomLevel:13 animated:NO];
         self.annotation.coordinate = address.centerCoordinate;
        }];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

@end
