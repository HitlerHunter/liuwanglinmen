

#import "SKMManagerViewController.h"
#import "SKMManagerCardView.h"

@interface SKMManagerViewController ()

@property (nonatomic, strong) SKMManagerCardView *cardView;
@property (nonatomic, strong) NSString *codeUrl;
@property (nonatomic, strong) NSString *codeUrlLocalKey;
@end

@implementation SKMManagerViewController

- (BOOL)hiddenNavgationBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"收款码管理";
    [self.view addSubview:self.scrollView];
    
    _cardView = [[SKMManagerCardView alloc] initWithWidth:kScreenWidth-60*LZScale];
    _cardView.centerX = kScreenWidth*0.5;
    _cardView.top = 10;
    
    UILabel *label_info = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"保存后可自行打印张贴" textColor:rgb(101,101,101) textAlignment:NSTextAlignmentCenter];
    label_info.frame = CGRectMake(0, _cardView.bottom+15, kScreenWidth, 12);
    
    UIButton *saveBtn = [UIButton buttonWithFontSize:16 text:@"保存到相册" textColor:LZWhiteColor];
    saveBtn.frame = CGRectMake(24, self.cardView.bottom+41, kScreenWidth-48, 45);
    [saveBtn setDefaultGradientWithCornerRadius:6];
    
    [saveBtn addTarget:self action:@selector(saveCardImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:_cardView];
    [self.scrollView addSubview:label_info];
    [self.scrollView addSubview:saveBtn];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, saveBtn.bottom+40);
    
    self.codeUrlLocalKey = [NSString stringWithFormat:@"%@_codeUrl",CurrentUser.userId];
    NSString *codeUrl = [[NSUserDefaults standardUserDefaults] objectForKey:self.codeUrlLocalKey];
    if (codeUrl.length) {
        self.codeUrl = codeUrl;
        UIImage *codeImage = [self creatCodeImage];
        self.cardView.codeImageView.image = codeImage;
    }
    
    [self requestURL];
    
}

- (void)requestURL{
    
    ZZNetWorker.GET.zz_willHandlerParam(NO)
    .zz_param(@{@"userNo":CurrentUser.usrNo})
    .zz_url(@"/payment-biz/payTool/getQrCode")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
       
        if (model_net.success) {
            
            [[NSUserDefaults standardUserDefaults] setObject:model_net.data forKey:self.codeUrlLocalKey];
            
            self.codeUrl = model_net.data;
            UIImage *codeImage = [self creatCodeImage];
            self.cardView.codeImageView.image = codeImage;
            
        }else if(model_net.code == 2){
         //未绑定二维码
            [AppCenter showEditCodeWithController:self];
            self.cardView.codeImageView.image = nil;
        }else{
            self.cardView.codeImageView.image = nil;
            [self showMessage:model_net.message];
        }
    });
}


- (UIImage *)creatCodeImage{
    
    return [self creatCodeImageWithSize:self.cardView.width*1.5];
}

- (UIImage *)creatCodeImageWithSize:(CGFloat)size{
    
    UIImage *image = [ZZCodeTool qrCodeImageWithContent:self.codeUrl codeImageSize:size logo:[AppCenter appIcon] logoFrame:CGRectZero red:25/255.0 green:25/255.0 blue:25/255.0];
    return image;
}


- (void)saveCardImage{
    
//    NSString *kefuPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefuPhone"];
    
    SKMManagerCardView *card = [[SKMManagerCardView alloc] initWithWidth:kScreenWidth*2];
    
    UIImage *codeImage = [self creatCodeImageWithSize:card.width*1.5];
    card.codeImageView.image = codeImage;
    card.label_info.text = [NSString stringWithFormat:@"怕钱不够花，就做副业吧！"];
    
    [self.view insertSubview:card atIndex:0];

    UIGraphicsBeginImageContextWithOptions(card.bounds.size, YES, [UIScreen mainScreen].scale);
    [card.layer renderInContext:UIGraphicsGetCurrentContext()];
        //获取图片
    UIImage * cardImage = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
    UIGraphicsEndImageContext();
    
    
    /**
     *  将图片保存到本地相册
     */
    UIImageWriteToSavedPhotosAlbum(cardImage, self , @selector(saveImage:didFinishSavingWithError:contextInfo:), nil);//保存图片到照片库
    
    [card removeFromSuperview];
}

- (void)saveImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    }
}

@end
