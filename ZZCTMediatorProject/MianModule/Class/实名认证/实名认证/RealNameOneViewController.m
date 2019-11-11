//
//  RealNameOneViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/21.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "RealNameOneViewController.h"
//#import "LDActionSheet.h"
//#import "LDImagePicker.h"

#import "RealNameViewModel.h"
#import "RealName2ViewController.h"
#import "JYBDIDCardVC.h"

@interface RealNameOneViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_2;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *IDNumTextField;

@property (nonatomic, strong) RealNameViewModel *viewModel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@property (nonatomic, assign) BOOL currentSelectImageIndex;
@end

@implementation RealNameOneViewController

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [_nextBtn setDefaultGradient];
}

- (void)setLivingImage:(UIImage *)livingImage{
    self.viewModel.livingImage = livingImage;
}

- (BOOL)needDismissHUD{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"实名认证";
    self.nextBtn.lz_setView.lz_cornerRadius(10);
    
    self.widthConstraint.constant = kScreenWidth;
}


- (IBAction)scanOneImage:(id)sender {
    
    [self readCard1];
    _currentSelectImageIndex = 0;
}

- (IBAction)scanTwoImage:(id)sender {
    
    [self readCard2];
    _currentSelectImageIndex = 1;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)readCard1{
    
    @weakify(self);
     JYBDIDCardVC *AVCaptureVC = [[JYBDIDCardVC alloc] init];
     AVCaptureVC.finish = ^(JYBDCardIDInfo *info, UIImage *image)
     {
         @strongify(self);
         
         self.viewModel.cardFrontImage = image;
         self.imageView_1.image = image;
         self.imageView_1.hidden = NO;
         
         if (info.name) {
             self.nameTextField.text = info.name;
         }if (info.num) {
             self.IDNumTextField.text = info.num;
         }
     
     };
     
    [self.navigationController pushViewController:AVCaptureVC animated:YES linearBackId:@"readIDCard"];
}

- (void)readCard2{
    
    @weakify(self);
     JYBDIDCardVC *AVCaptureVC = [[JYBDIDCardVC alloc] init];
     AVCaptureVC.finish = ^(JYBDCardIDInfo *info, UIImage *image)
     {
         @strongify(self);
         
         self.viewModel.cardBackImage = image;
         self.imageView_2.image = image;
         self.imageView_2.hidden = NO;
     
     };
     
    [self.navigationController pushViewController:AVCaptureVC animated:YES linearBackId:@"readIDCard"];
}

- (BOOL)isCheckCardNumber{
    return NO;
}

- (IBAction)nextClick:(UIButton *)sender {
    
    NSString *name = _nameTextField.text;
    NSString *idNumber = _IDNumTextField.text;
    
    
    if (name.length == 0) {
        
        [self showMessage:@"请输入真实姓名！"];
        return;
    }
    
    if (idNumber.length == 0) {
        
        [self showMessage:@"请输入身份证号码！"];
        return;
    }
    
    if (![idNumber tt_simpleVerifyIdentityCardNum] && self.isCheckCardNumber) {
        
        [self showMessage:@"身份证号码格式填写不正确"];
        return;
    }
    
    if (self.viewModel.cardFrontImage == nil) {
        [self showMessage:@"请上传身份证正面照！"];
        return;
    }
    
    if (self.viewModel.cardBackImage == nil) {
        [self showMessage:@"请上传身份证反面照！"];
        return;
    }
     
    
    
    self.viewModel.name = name;
    self.viewModel.IDCardNumber = idNumber;
    
    RealName2ViewController *vc2 = [[UIStoryboard storyboardWithName:@"SM" bundle:nil] instantiateViewControllerWithIdentifier:@"smrz2"];
    vc2.viewModel = self.viewModel;
    
    PushIdController(vc2, LinearBackId_realName);
}

/*
 LDActionSheet *sheet = [[LDActionSheet alloc] initWithTitle:@"身份证反面" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"扫描",@"相册", nil];
 [sheet showInView:self.view];
 
 
 **/

- (RealNameViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [RealNameViewModel new];
    }
    return _viewModel;
}
@end
