//
//  H5HTMLViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/5/9.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "H5HTMLViewController.h"

@interface H5HTMLViewController ()

@end

@implementation H5HTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.webView loadHTMLString:self.url baseURL:nil];
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
