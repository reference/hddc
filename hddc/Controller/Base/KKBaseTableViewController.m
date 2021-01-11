//
//  KKBaseTableViewController.m
//  HaoMai
//
//  Created by 向荣华 on 2019/4/15.
//  Copyright © 2019 Haowan. All rights reserved.
//

#import "KKBaseTableViewController.h"

@interface KKBaseTableViewController ()

@end

@implementation KKBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    //返回按钮
    if (self.navigationController && self != self.navigationController.viewControllers.firstObject)
    {
        UIImage *image = [[UIImage imageNamed:@"back _nav"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(onBack:)]];
    }
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setThemeNavigation
{
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor colorNamed:@"color_light_blue"] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
    //字体
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
