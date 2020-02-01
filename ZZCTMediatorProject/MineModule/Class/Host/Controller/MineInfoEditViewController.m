//
//  MineInfoEditViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineInfoEditViewController.h"
#import "MineInfoEditStyle1Cell.h"
#import "MineInfoEditInputCell.h"
#import "HooDatePicker.h"
#import "ZLOnePhoto.h"

@interface MineInfoEditViewController ()<LDActionSheetDelegate,HooDatePickerDelegate,LZImageResizerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) MineInfoEditInputCell *nameCell;

@property (nonatomic, strong) NSString *sex;
@property (nonatomic, assign) NSInteger sexCode;
@property (nonatomic, strong) NSString *birthDay;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageURL;

@property (nonatomic, strong) HooDatePicker *YMDPicker;
@end

@implementation MineInfoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑资料";
    
    [self.view addSubview:self.scrollView];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = LZWhiteColor;
    [self.scrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_greaterThanOrEqualTo(47);
        make.bottom.mas_equalTo(100);
    }];
    
    UIImageView *imageView = [UIImageView new];
    [bgView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.centerX.mas_equalTo(0);
    }];
    imageView.lz_setView.lz_cornerRadius(45);
    _imageView = imageView;
    
    UIButton *avatarBtn = [UIButton buttonWithFontSize:12 text:@"更换头像" textColor:rgb(255,81,0)];
    [bgView addSubview:avatarBtn];
    [avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(90, 36));
        make.centerX.mas_equalTo(0);
    }];
    
    MineInfoEditInputCell *cell_name = [MineInfoEditInputCell new];
    cell_name.titleLabel.text = @"用户昵称";
    cell_name.textField.text = CurrentUser.nickName;
    [bgView addSubview:cell_name];
    _nameCell = cell_name;
    
    MineInfoEditStyle1Cell *cell_id = [MineInfoEditStyle1Cell cellWithTitle:@"用户ID" vaule:CurrentUser.usrNo block:nil];
    cell_id.showMoreIcon = NO;
    
    @weakify(self);
    MineInfoEditStyle1Cell *cell_sex = [MineInfoEditStyle1Cell cellWithTitle:@"性别" vaule:@"" block:^{
        @strongify(self);
        [self showSex];
    }];
    
    MineInfoEditStyle1Cell *cell_birth = [MineInfoEditStyle1Cell cellWithTitle:@"生日" vaule:@"" block:^{
        @strongify(self);
        [self showBirth];
    }];
    
    NSArray *cellArray = @[cell_name,cell_id,cell_sex,cell_birth];
    
    UIView *lastView = nil;
    for (UIView *cell in cellArray) {
        [bgView addSubview:cell];
        
        if (!lastView) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(avatarBtn.mas_bottom).offset(0);
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(40);
            }];
        }else {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(40);
                make.top.mas_equalTo(lastView.mas_bottom);
            }];
        }
        lastView = cell;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithFontSize:16 text:@"保存" textColor:LZWhiteColor];
    [self.scrollView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
        make.left.right.mas_equalTo(0);
    }];
    [saveBtn setDefaultGradient];
    
    //按钮事件
    [avatarBtn addTarget:self action:@selector(showAvatar) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    //监听
    [RACObserve(self, sex) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        cell_sex.valueLabel.text = self.sex;
    }];
    
    [RACObserve(self, birthDay) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        cell_birth.valueLabel.text = self.birthDay;
    }];
    
    imageView.image = [AppCenter appIcon];
    if (!IsNull(CurrentUser.nickUrl)) {
        [imageView sd_setImageWithURL:TLURL(CurrentUser.nickUrl)];
    }
    
    self.sexCode = CurrentUser.sex;
    self.sex = CurrentUser.sex == 0?@"男":@"女";
    self.birthDay = CurrentUser.birth;
}

#pragma mark - 修改提交
- (void)save:(UIButton *)btn{
    
    NSString *nickName = _nameCell.textField.text;
    
    NewParams;
    [params setSafeObject:self.imageURL forKey:@"nickUrl"];
    [params setSafeObject:nickName forKey:@"nickName"];
    [params setSafeObject:@(self.sexCode) forKey:@"sex"];
    [params setSafeObject:self.birthDay forKey:@"birth"];
    
    
    //修改
    [[UserManager shareInstance] changeUserInfo:params block:^{
        [self showMessage:@"修改成功"];
        CurrentUser.nickUrl = self.imageURL;
        CurrentUser.nickName = nickName;
        CurrentUser.sex = self.sexCode;
        CurrentUser.birth = self.birthDay;
        [self lz_popControllerAfterDelay:1.5];
    }];
}

- (void)showAvatar{
    LDActionSheet *sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    sheet.tag = 101;
    [sheet showInView:KeyWindow];
    
}

- (void)showSex{
    LDActionSheet *sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    sheet.tag = 102;
    [sheet showInView:KeyWindow];
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 101) {
        if (buttonIndex == 0) {
            [[ZLOnePhoto shareInstance] presentPicker:PickerType_Camera photoCut:PhotoCutType_NO target:self callBackBlock:^(UIImage *image, BOOL isCancel) {
                if (!isCancel) {

                    LZImageResizerViewController *resizeVC = [[LZImageResizerViewController alloc] initWithImage:image];
                    resizeVC.imageResizerDelegate = self;
                    [self.navigationController pushViewController:resizeVC animated:YES];
                }
            }];
        }else if (buttonIndex == 1) {
            [[ZLOnePhoto shareInstance] presentPicker:PickerType_Photo photoCut:PhotoCutType_NO target:self callBackBlock:^(UIImage *image, BOOL isCancel) {
                if (!isCancel) {
                    LZImageResizerViewController *resizeVC = [[LZImageResizerViewController alloc] initWithImage:image];
                    resizeVC.imageResizerDelegate = self;
                    [self.navigationController pushViewController:resizeVC animated:YES];
                }
            }];
        }
    }
    
    if (buttonIndex == 0) {
        self.sex = @"男";
        self.sexCode = 0;
    }else if (buttonIndex == 1) {
        self.sex = @"女";
        self.sexCode = 1;
    }
}

- (void)LZImageResizerDidResizeImage:(UIImage *_Nonnull)image{
    
    [ZZNetWorker uploadImage1:image compressionQuality:0.4 block:^(BOOL isSuccess, NSString *url) {
        self.imageView.image = image;
        self.image = image;
        self.imageURL = url;
    }];
}
- (UIImageView *_Nullable)didTapImageView{
    return self.imageView;
}

- (void)showBirth{
    [self.YMDPicker show];
}

#pragma mark - dateDelegate
- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date{
    
    NSString *dateStr = [date formatYMDWithSeparate:@"-"];
    self.birthDay = dateStr;
    
}

- (HooDatePicker *)YMDPicker{
    if (!_YMDPicker) {
        _YMDPicker = [[HooDatePicker alloc] initWithSuperView:KeyWindow];
        _YMDPicker.delegate = self;
        _YMDPicker.timeZone = [NSTimeZone localTimeZone];
    }
    return _YMDPicker;
}
@end
