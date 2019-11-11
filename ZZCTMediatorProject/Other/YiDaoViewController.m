    //
    //  YiDaoViewController.m
    //  ZhouZhuanFu
    //
    //  Created by 徐迪华 on 2018/3/12.
    //  Copyright © 2018年 徐迪华. All rights reserved.
    //

#import "YiDaoViewController.h"
#import "CTMediator+CTMediatorModuleLoginActions.h"

@interface YiDaoViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger *cunrentPage;
@end

@implementation YiDaoViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)imageCount{
    return 4;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(kScreenWidth * self.imageCount, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIImage *)imageWithName:(NSString *)imageName ofType:(NSString *)type{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:type];
    return [UIImage imageWithContentsOfFile:filePath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"willShowYD"];
    [[NSUserDefaults standardUserDefaults] setValue:AppVersion forKey:@"YDVersion"];
    //默认开启推送
    CurrentUser.isOpenAppNotification = YES;
    
    _cunrentPage = 0;
    
    NSInteger scale = [UIScreen mainScreen].scale;
    NSString *imageSizeStr = [NSString stringWithFormat:@"%ld_%ld",(NSInteger)kScreenWidth*scale,(NSInteger)kScreenHeight*scale];
    SDLog(@"imageSizeStr : %@",imageSizeStr);
    
        // 1242_2688
    if ([imageSizeStr isEqualToString:@"640_960"]
        || [imageSizeStr isEqualToString:@"640_1136"]
        || [imageSizeStr isEqualToString:@"750_1334"]
        || [imageSizeStr isEqualToString:@"1242_2208"]) {
        imageSizeStr = @"1242_2208";//640、750、1142 公用一张
    }else if ([imageSizeStr isEqualToString:@"828_1792"]
              || [imageSizeStr isEqualToString:@"1125_2436"]
              || [imageSizeStr isEqualToString:@"1242_2688"]) {
        imageSizeStr = @"1125_2436";//640、750、1142 公用一张
    }
    
    
    for (int i = 0; i<self.imageCount; i++) {
        UIImage *img = [self imageWithName:[NSString stringWithFormat:@"%d_%@",i+1,imageSizeStr] ofType:@"jpg"];
        if (!img) {
            img = [self imageWithName:[NSString stringWithFormat:@"%d_%@",i+1,imageSizeStr] ofType:@"png"];
        }
        
        if (!img) {
            img = [self imageWithName:@"1242_2208" ofType:@"png"];
        }
        
        if (!img) {
            img = [self imageWithName:@"1242_2208" ofType:@"jpg"];
        }
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imgView.image = img;
        imgView.userInteractionEnabled = YES;
        
        if (i == self.imageCount-1) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
            [imgView addGestureRecognizer:tap];
        }
        
        [self.scrollView addSubview:imgView];
    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.userInteractionEnabled = YES;
    btn.frame = CGRectMake(kScreenWidth - 70, LZApp.shareInstance.app_statusBarHeight+20, 44, 44);
    btn.titleLabel.font = kfont(12);
    btn.lz_setView.lz_cornerRadius(22).lz_border(3, [UIColor whiteColor]);

    [btn setTitle:@"跳过" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tgClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
    
    
    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 30)];
        //设置4个分页的点
    page.numberOfPages = self.imageCount;
        //设置当前页的点 *
        //    page.currentPage = 2; //(默认当前页的点为0)
    
        //设置当前选择的点的颜色
    page.currentPageIndicatorTintColor = [UIColor orangeColor];
    
        //除选中点以外的点的颜色
    page.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
        //在触发事件中，将分页控制器与滚动视图做关联，控制图片的滚动
        //通过UIControlEventValueChanged方式触发
    [page addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventValueChanged];
    page.tag = 101;
    
    page.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:page];
    [self.view bringSubviewToFront:page];
    
}
-(void)tgClick{
    
    [self click];
    
}
-(void)btnClick:(UIPageControl *)page
{
        //先求出分页控制器的页数
    NSInteger num = page.currentPage;
    
    [self.scrollView setContentOffset:CGPointMake(num*kScreenWidth, 0) animated:YES];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int num = scrollView.contentOffset.x/kScreenWidth;
    
    
        //用滚动视图的x坐标除以整屏宽度，得到页数
    
    UIPageControl *page = (UIPageControl*)[self.view viewWithTag:101];
        //根据滚动视图求出的页数设置到分页控制器中
    page.currentPage = num;
    
}

-(void)click{
  
    [[UserManager shareInstance] refreshToken:^(BOOL isTokenValid) {
        if (isTokenValid) {
            [AppCenter toTabBarController];
        }else{
            [[CTMediator sharedInstance] CTMediator_showLoginViewController];
        }
    }];
    
}



@end
