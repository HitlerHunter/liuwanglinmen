//
//  RealName2ViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/22.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "RealName2ViewController.h"
#import "RealNameViewModel.h"
#import "LDImagePicker.h"
#import "RealName3ViewController.h"

@interface RealName2ViewController ()<LDImagePickerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView_1;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@end

@implementation RealName2ViewController

- (BOOL)needDismissHUD{
    return YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [_nextBtn setDefaultGradient];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nextBtn.lz_setView.lz_cornerRadius(10);
    
    self.widthConstraint.constant = kScreenWidth;
}

- (void)setViewModel:(RealNameViewModel *)viewModel{
    _viewModel = viewModel;
    
    if (_viewModel.personImage) {
        self.imageView_1.image = _viewModel.personImage;
        self.imageView_1.hidden = NO;
    }
}

- (IBAction)toPhoto:(id)sender {
    LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
    imagePicker.delegate = self;
    [imagePicker showOriginalImagePickerWithType:ImagePickerCamera InViewController:self];
}

- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    
    self.viewModel.personImage = editedImage;
    self.imageView_1.image = editedImage;
    self.imageView_1.hidden = NO;
}

- (IBAction)nextClick:(id)sender {
    
    if (self.viewModel.personImage == nil) {
        [self showMessage:@"请拍摄照片！"];
        return;
    }
    
    RealName3ViewController *vc2 = [[UIStoryboard storyboardWithName:@"SM" bundle:nil] instantiateViewControllerWithIdentifier:@"smrz3"];
    vc2.viewModel = self.viewModel;
    
    PushIdController(vc2, LinearBackId_realName);
    
}


@end
