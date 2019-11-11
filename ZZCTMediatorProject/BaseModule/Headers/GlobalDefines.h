
#ifndef GlobalDefines_h
#define GlobalDefines_h

#define WeakSelf(weakSelf)      __weak __typeof(&*self)    weakSelf  = self;
#define StrongSelf(strongSelf)  __strong __typeof(&*self) strongSelf = weakSelf;

//screen
#define KeyWindow [[UIApplication sharedApplication].delegate window]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define Font_PingFang_SC_Bold(x) [UIFont fontWithName:@"PingFangSC-Semibold" size:x]
#define Font_PingFang_SC_Medium(x) [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define Font_PingFang_SC_Regular(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define kfont(x) [UIFont systemFontOfSize:x]
#define LZScale (kScreenWidth/375.0)

#define UIImageName(x) [UIImage imageNamed:x]
#define StrObj(obj) [NSString stringWithFormat:@"%@",obj]
//默认头像
#define DefaultAvatar UIImageName(@"logo")

#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define AppTabBarController (UITabBarController *)[(AppDelegate *)[UIApplication sharedApplication].delegate tabBarController]

#define IsNull(obj) ([obj isEqual:[NSNull null]] || obj == nil || [obj isKindOfClass:[NSNull class]])

#define PushController(vc) [self.navigationController pushViewController:vc animated:YES]

#define WeakPopController [weakSelf.navigationController popViewControllerAnimated:YES]
#define PopController [self.navigationController popViewControllerAnimated:YES]

#define NewClass(vcName,className) className *vcName = [className new];

#define NewParamsWithCapacity(x) NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:x]
#define NewParams NSMutableDictionary *params = [NSMutableDictionary dictionary]

#define ServerErrorMsg @"服务器繁忙，请稍后再试！"
//#define ServerPhone @"4008699683"
//调试状态
#define SDLog(format,...) printf("%s:(%d): %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )

//#define SDLog(format,...)

#endif
