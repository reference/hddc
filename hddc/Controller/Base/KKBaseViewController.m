//
//  KKBaseViewController.m
//  HaoMai
//
//  Created by 向荣华 on 2019/4/16.
//  Copyright © 2019 Haowan. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKBaseViewController ()

@end

@implementation KKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
}

- (void)setBackButtonBlack
{
    //返回按钮
    UIImage *image = [[UIImage imageNamed:@"navi_back_black"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(onBack:)]];
}

- (void)setBackButtonWhite
{
    //返回按钮
    UIImage *image = [[UIImage imageNamed:@"navi_back_white"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(onBack:)]];
}

- (void)setThemeNavigation
{
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor colorNamed:@"color_light_blue"] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
    //字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
}

- (void)showNoDataView
{
    self.noDataImage = [UIImage imageNamed:@"content_empty"];
    self.noDataText = @"";
    self.displayNoDataView = YES;
}

- (void)hideNoDataView
{
    self.displayNoDataView = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 自定导航栏颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 导航栏透明并取消分隔线
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[[UIColor  whiteColor] colorWithAlphaComponent:1]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 导航栏标题字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]};
    //返回按钮
    if (self.navigationController && self != self.navigationController.viewControllers.firstObject)
    {
        UIImage *image = [[UIImage imageNamed:@"navi_back_white"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(onBack:)]];
    }
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //
    self.navigationController.navigationBar.translucent = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
