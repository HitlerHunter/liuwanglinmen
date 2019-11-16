//
//  MarketBoardCreateViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketBoardCreateViewController.h"
#import "MarketBoardCellModel.h"
#import "MarketBoardTypeSelectView.h"
#import "CMInputView.h"

@interface MarketBoardCreateViewController ()

@property (nonatomic, strong) MarketBoardCellModel *boardModel;
@property (nonatomic, strong) UITextField *titleTF;
@property (nonatomic, strong) MarketBoardTypeSelectView *typeView;
@property (nonatomic, strong) CMInputView *textView;
@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation MarketBoardCreateViewController

- (instancetype)initWithBoardModel:(MarketBoardCellModel *)model{
    self = [super init];
    if (self) {
        _boardModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_boardModel) {
        self.title = @"模板详情";
        _isEdit = YES;
        //删除
        @weakify(self);
        [self addRightItemWithImage:nil title:@"删除" font:nil color:[UIColor redColor] block:^{
            @strongify(self);
            
            UIAlertController *removeAlert = [UIAlertController alertControllerWithTitle:@"删除模板" message:@"删除将无法恢复，是否删除？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"再考虑" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *remove = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                //删除
                [[MarketBoardManager shareInstance] removeBoard:self.boardModel];
                [SVProgressHUD showSuccessWithStatus:@"删除成功！"];
                [self lz_popControllerAfterDelay:1.5];
            }];
            
            [removeAlert addAction:cancel];
            [removeAlert addAction:remove];
            
            [self presentViewController:removeAlert animated:YES completion:nil];
        }];
        
        //保存
        
        
    }else{
        _isEdit = NO;
        self.title = @"创建模板";
        self.boardModel = [MarketBoardCellModel new];
        @weakify(self);
        [self addRightItemWithImage:nil title:@"保存" font:nil color:nil block:^{
            @strongify(self);
            [self save];
        }];
    }
    
    [self.view addSubview:self.scrollView];
    [self initView1];
    [self initTypeView];
    [self initBoardInfoView];
    
    if (_isEdit) {
        [self initSaveBtn];
        
        UIView *view = [UIView new];
        [self.scrollView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.textView.mas_bottom);
            make.top.left.right.mas_equalTo(self.scrollView);
        }];
    }else{
        [self.textView.superview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-30);
        }];
    }
    
    _titleTF.text = _boardModel.templateHead;
    _textView.text = _boardModel.templateContent;
    
    
    _typeView.selectedTitle = getMarketBoardTypeTitleWithTypeStr(_boardModel.businessType);
}

- (void)initView1{
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = LZWhiteColor;
    
    [self.scrollView addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(45);
    }];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = @"请输入模板名称";
    tf.maxLength = 32;
    [view1 addSubview:tf];
    _titleTF = tf;
    
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}

//类型选择
- (void)initTypeView{
    self.typeView = [MarketBoardTypeSelectView new];
    self.typeView.titleArray = @[MarketPlanTypeBirthdayTitle,MarketPlanTypeCustomTitle,];
    [self.scrollView addSubview:self.typeView];
    
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleTF.superview.mas_bottom).offset(10);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(90);
    }];
}

- (void)initBoardInfoView{
    
    UIView *inputBgView = [UIView new];
    inputBgView.backgroundColor = LZWhiteColor;
    [self.scrollView addSubview:inputBgView];
    
    [inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.typeView.mas_bottom).offset(10);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    //输入框
    CMInputView *inputView = [[CMInputView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 170)];
    inputView.backgroundColor = LZWhiteColor;
    inputView.placeholder = @"请输入模板内容";
    inputView.placeholderFont = Font_PingFang_SC_Regular(16);
    inputView.font = Font_PingFang_SC_Regular(16);
    inputView.placeholderColor = rgb(152,152,152);
    inputView.maxTextNumber = 128;
    
    _textView = inputView;
    [inputBgView addSubview:inputView];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(170);
    }];
    
    //字数
    NSString *maxNumber = [NSString stringWithFormat:@"%ld",self.textView.maxTextNumber];
    UILabel *lab = [UILabel labelWithFontSize:14 text:maxNumber textAlignment:NSTextAlignmentRight];
    lab.textColor = rgb(152,152,152);
    _numberLabel = lab;
    [inputBgView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    @weakify(self);
    inputView.textValueDidChanged = ^(NSString *text) {
        @strongify(self);
        self.numberLabel.text = [NSString stringWithFormat:@"%ld",self.textView.maxTextNumber-text.length];
    };
}

- (void)initSaveBtn{
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"返回" textColor:LZWhiteColor];
    btn.frame = CGRectMake(25, 0, kScreenWidth-50, 45);
    [btn setDefaultGradientWithCornerRadius:6];
    
    [self.scrollView addSubview:btn];
    
    [btn addTarget:self action:@selector(lz_popController) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.superview.mas_bottom).offset(30);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-30);
    }];
}

- (void)save{
    
    MarketBoardCellModel *board = self.boardModel.modelCopy;
    
    board.userName = CurrentUser.usrName;
    board.templateHead = self.titleTF.text;
    board.templateContent = self.textView.text;
    board.status = MarketBoardStatusReviewing;
    board.businessType = getMarketBoardTypeStrWithTypeTitle(self.typeView.selectedTitle);
    
    if (board.templateHead.length == 0) {
        [self showMessage:@"请输入模板名称"];
        return;
    }
    
    if (self.typeView.selectedTitle == nil) {
        [self showMessage:@"请选择模板类型"];
        return;
    }
    
    if (board.templateContent.length == 0) {
        [self showMessage:@"请输入模板内容"];
        return;
    }
    
    if (!self.isEdit) {
        self.boardModel.businessType = MarketPlanTypeCustomString;
        //创建
        [[MarketBoardManager shareInstance] addBoard:board returnBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                [self lz_popController];
            }
        }];
    }else {
        [[MarketBoardManager shareInstance] editBoard:board returnBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                self.boardModel.templateHead = board.templateHead;
                self.boardModel.templateContent = board.templateContent;
                self.boardModel.status = MarketBoardStatusReviewing;
                self.boardModel.businessType = board.businessType;
                
                [self lz_popController];
            }
        }];
    }
    
}

@end
