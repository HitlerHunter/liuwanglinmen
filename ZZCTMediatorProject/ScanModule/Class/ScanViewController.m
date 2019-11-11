//
//  ScanViewController.m
//  HLRCode
//
//  Created by 郝靓 on 2018/7/9.
//  Copyright © 2018年 郝靓. All rights reserved.
//

#import "ScanViewController.h"
#import "TorchButton.h"
#import "SKMViewController.h"
#import "ScanPayViewModel.h"
#import <AudioToolbox/AudioToolbox.h> //声音提示
#import "CTMediator+ModuleBookActions.h"

#define Height [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define XCenter self.view.center.x
#define YCenter self.view.center.y

#define SHeight 20

#define SWidth (XCenter+30)

@interface ScanViewController ()
{
    NSTimer *_timer;
    int num;
    BOOL upOrDown;
    NSTimer *_torchTimer;
    int didShowTime;
}

/**
 手电筒
 */
@property (nonatomic, strong) TorchButton *torchBtn;
@property (nonatomic, assign) BOOL isLightOpen;
@end

@implementation ScanViewController

#pragma mark ===========懒加载===========
//device
- (AVCaptureDevice *)device
{
    if (_device == nil) {
        //AVMediaTypeVideo是打开相机
        //AVMediaTypeAudio是打开麦克风
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}
//input
- (AVCaptureDeviceInput *)input
{
    if (_input == nil) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}
//output  --- output如果不打开就无法输出扫描得到的信息
// 设置输出对象解析数据时感兴趣的范围
// 默认值是 CGRect(x: 0, y: 0, width: 1, height: 1)
// 通过对这个值的观察, 我们发现传入的是比例
// 注意: 参照是以横屏的左上角作为, 而不是以竖屏
//        out.rectOfInterest = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
- (AVCaptureMetadataOutput *)output
{
    if (_output == nil) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //限制扫描区域(上下左右)
        [_output setRectOfInterest:[self rectOfInterestByScanViewRect:_imageView.frame]];
    }
    return _output;
}
- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    
    return CGRectMake(x, y, w, h);
}

//session
- (AVCaptureSession *)session
{
    if (_session == nil) {
        //session
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
    }
    return _session;
}
//preview
- (AVCaptureVideoPreviewLayer *)preview
{
    if (_preview == nil) {
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _preview;
}

#pragma mark ==========ViewDidLoad==========
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //1 判断是否存在相机
    if (self.device == nil) {
        [self showAlertViewWithTitle:@"初始化失败" withMessage:@"未检测到相机!"];
            //界面初始化
        [self interfaceSetup];
        return;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    //打开定时器，开始扫描
    [self addTimer];
    
    //界面初始化
    [self interfaceSetup];
    
    //初始化扫描
    [self scanSetup];
    
}

#pragma mark ==========初始化工作在这里==========
- (void)viewDidDisappear:(BOOL)animated
{
    //视图退出，关闭扫描
    [self.session stopRunning];
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    [_timer invalidate];
    _timer = nil;
    [self systemLightSwitch:NO];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:JPushStoreScanNotificationName object:nil];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self addTimer];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:JPushStoreScanNotificationName object:nil];
    
    [self.session startRunning];
}

//界面初始化
- (void)interfaceSetup
{
        //添加模糊效果
    [self setOverView];
    //1 添加扫描框
//    [self.view addSubview:self.titleLabel];
    [self addImageView];
    [self addToolView];
    
    
    //添加开始扫描按钮
    //    [self addStartButton];
    
}

//添加扫描框
- (void)addImageView
{
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:_line];
    
    UIImageView *line1 = [UIImageView viewWithImage:UIImageName(@"scan_leftTop")];
    [self.imageView addSubview:line1];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.imageView);
    }];
    
    UIImageView *line2 = [UIImageView viewWithImage:UIImageName(@"scan_rightTop")];
    [self.imageView addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.imageView);
    }];
    
    UIImageView *line3 = [UIImageView viewWithImage:UIImageName(@"scan_rightBottom")];
    [self.imageView addSubview:line3];
    
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.imageView);
    }];
    
    UIImageView *line4 = [UIImageView viewWithImage:UIImageName(@"scan_leftBottom")];
    [self.imageView addSubview:line4];
    
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.mas_equalTo(self.imageView);
    }];
}

- (void)addToolView{
    
    UILabel *topLabel = [UILabel labelWithFontSize:13 textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    topLabel.text = @"订单金额";
    topLabel.frame = CGRectMake(0, LZApp.shareInstance.app_navigationBarHeight+30, kScreenWidth, 15);
    [self.view addSubview:topLabel];
    
    self.titleLabel.top = LZApp.shareInstance.app_navigationBarHeight+50;
    [self.view addSubview:self.titleLabel];
    self.titleLabel.text = [NSString stringWithFormat:@"￥%@",self.money];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageView.bottom+15, 66, 23)];
    view1.centerX = self.view.width*0.5;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    imageV.image = [UIImage imageNamed:@"sk_weixin"];
    imageV.lz_setView.lz_cornerRadius(4);
    [view1 addSubview:imageV];
    
    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    imageV2.image = [UIImage imageNamed:@"sk_zhifubao"];
    imageV2.right = view1.width;
    imageV2.lz_setView.lz_cornerRadius(4);
    
    [view1 addSubview:imageV2];
    [self.view addSubview:view1];
    
    UILabel *lab = [UILabel labelWithFontSize:14 textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    lab.text = @"请顾客出示二维码，将二维码放入框内";
    lab.frame = CGRectMake(0, view1.bottom+15, kScreenWidth, 15);
    [self.view addSubview:lab];
    
    self.torchBtn.top = lab.bottom+30;
    [self.view addSubview:self.torchBtn];
    
    /*
    UIButton *changeCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeCodeBtn.frame = CGRectMake(24, self.torchBtn.bottom+24, kScreenWidth-48, 45);
    
    changeCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [changeCodeBtn setTitle:@"切换到收款码" forState:UIControlStateNormal];
    [changeCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeCodeBtn setDefaultGradientWithCornerRadius:6];
    
    @weakify(self);
    [changeCodeBtn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        [self toSKMController];
    }];
    
    [self.view addSubview:changeCodeBtn];
     */
    
    
}

//初始化扫描配置
- (void)scanSetup
{
    //2 添加预览图层
    self.preview.frame = self.view.bounds;
    self.preview.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    //3 设置输出能够解析的数据类型
    //注意:设置数据类型一定要在输出对象添加到回话之后才能设置
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
    
    //高质量采集率
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //4 开始扫描
    [self.session startRunning];
    
    
}
//提示框alert
- (void)showAlertViewWithMessage:(NSString *)message
{
    
    [self didScanPlaySound];
    
    //弹出提示框后，关闭扫描
    [self.session stopRunning];
    //弹出alert，关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    
}

- (void)didScanPlaySound{
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"scanSuccess.wav" withExtension:nil];
        //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    SystemSoundID soundID=8787;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        //3.播放音效文件
        //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
        //    AudioServicesPlayAlertSound(soundID);
    
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - 收款
- (void)payWithCode:(NSString *)code{
    
    if (code.length == 0) {
        [self showAlertViewWithTitle:@"收款失败" withMessage:@""];
        return;
    }
    
    [self didScanPlaySound];
    
        //弹出提示框后，关闭扫描
    [self.session stopRunning];
        //弹出alert，关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"等待支付"];
    
    [ScanPayViewModel payWithCode:code
                            money:self.money
                           remark:_remark
                            block:^(id  _Nullable obj, NSString * _Nullable msg, BOOL success) {
            [SVProgressHUD dismiss];
        if (success) {
            [self showMessage:@"收款成功！"];
            [self lineBackWithId:LinearBackId_Scan];
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
    }];
}

- (void)zz_dealloc{}

- (void)finishAddBack:(id)obj{
    
    [self lz_popController];
}

#pragma mark ===========重启扫描&闪光灯===========
//添加开始扫描按钮
- (void)addStartButton
{
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(60, 420, 80, 40);
    startButton.backgroundColor = [UIColor orangeColor];
    [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitle:@"扫描" forState:UIControlStateNormal];
    [self.view addSubview:startButton];
}
- (void)startButtonClick
{
    //清除imageView上的图片
    self.imageView.image = [UIImage imageNamed:@""];
    //开始扫描
    [self starScan];
    
}


- (void)systemLightSwitch:(BOOL)open
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

#pragma mark ===========添加提示框===========
//提示框alert
- (void)showAlertViewWithTitle:(NSString *)aTitle withMessage:(NSString *)aMessage
{
    
    //弹出提示框后，关闭扫描
    [self.session stopRunning];
    //弹出alert，关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:aTitle message:[NSString stringWithFormat:@"%@",aMessage] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //点击alert，开始扫描
        [self.session startRunning];
        //开启定时器
        [self->_timer setFireDate:[NSDate distantPast]];
    }]];
    [self presentViewController:alert animated:true completion:^{
        
    }];
    
}


#pragma mark ===========扫描的代理方法===========
//得到扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if ([metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            NSString *stringValue = [metadataObject stringValue];
            if (stringValue != nil) {
                [self.session stopRunning];
                //扫描结果
                NSLog(@"%@",stringValue);
                //支付
                [self payWithCode:stringValue];
            }
        }
        
    }
}

#pragma mark ============添加模糊效果============
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(self.imageView.frame);
    CGFloat y = CGRectGetMinY(self.imageView.frame);
    CGFloat w = CGRectGetWidth(self.imageView.frame);
    CGFloat h = CGRectGetHeight(self.imageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 1;
    UIColor *backColor = [UIColor grayColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [self.view addSubview:view];
}

#pragma mark ============添加扫描效果============

- (void)addTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    }
    
}

- (void)torchTimerMethod{
    didShowTime += 1;
    if (didShowTime == 3) {
        [_torchTimer invalidate];
        [self.view addSubview:self.torchBtn];
    }
}

//控制扫描线上下滚动
- (void)timerMethod
{
    if (upOrDown == NO) {
        num ++;
        _line.frame = CGRectMake(CGRectGetMinX(_imageView.frame)+5, CGRectGetMinY(_imageView.frame)+5+num, CGRectGetWidth(_imageView.frame)-10, 3);
        if (num == (int)(CGRectGetHeight(_imageView.frame)-10)) {
            upOrDown = YES;
        }
    }
    else
    {
        num --;
        _line.frame = CGRectMake(CGRectGetMinX(_imageView.frame)+5, CGRectGetMinY(_imageView.frame)+5+num, CGRectGetWidth(_imageView.frame)-10, 3);
        if (num == 0) {
            upOrDown = NO;
        }
    }
}
//暂定扫描
- (void)stopScan
{
    //弹出提示框后，关闭扫描
    [self.session stopRunning];
    //弹出alert，关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    //隐藏扫描线
    _line.hidden = YES;
}
- (void)starScan
{
    //开始扫描
    [self.session startRunning];
    //打开定时器
    [_timer setFireDate:[NSDate distantPast]];
    //显示扫描线
    _line.hidden = NO;
}

#pragma mark - method
- (void)toSKMController{
    SKMViewController *vc = [[SKMViewController alloc] initWithMoney:self.money remark:self.remark];
    SDBaseNavigationController *nav = [[SDBaseNavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

// 打开手电筒开关按钮点击事件
- (void)torchOnTouchButton{
    
    if (!_isLightOpen) {
        _isLightOpen = YES;
        [self systemLightSwitch:YES];
    }else{
        _isLightOpen = NO;
        [self systemLightSwitch:NO];
    }
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 170, kScreenWidth-100, kScreenWidth-100)];
            //显示扫描框
        _imageView.image = [UIImage imageNamed:@"scan_frame"];
        
        _line = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_imageView.frame)+5, CGRectGetMinY(_imageView.frame)+5, CGRectGetWidth(_imageView.frame), 3)];
        _line.image = [UIImage imageNamed:@"scan_light"];
    }
    
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {

        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width-30, 30)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        lable.font = [UIFont systemFontOfSize:18];
        _titleLabel = lable;
    }
    return _titleLabel;
}

- (TorchButton *)torchBtn{
    if (!_torchBtn) {
        _torchBtn = [[TorchButton alloc] initWithFrame:CGRectMake(0, self.imageView.bottom+90, 40, 30)];
        _torchBtn.centerX = self.imageView.centerX;

        [_torchBtn setImage:UIImageName(@"scan_flashlight_off") forState:UIControlStateNormal];

        [_torchBtn addTarget:self action:@selector(torchOnTouchButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _torchBtn;
}
@end












