//
//  GPHomeMeCenter.m
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeMeCenter.h"
#import "GPHomeChangePasswordController.h"
#import "GPHomeSettingKMLListController.h"

@interface GPHomeMeCenter ()

@end

@implementation GPHomeMeCenter

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setBackButtonBlack];
}

- (IBAction)onChangePassword:(UIButton *)b
{
    [self pushViewControllerClass:GPHomeChangePasswordController.class inStoryboard:@"GPHome"];
}

- (IBAction)onKmlKmzShp:(UIButton *)b
{
    [self pushViewControllerClass:GPHomeSettingKMLListController.class inStoryboard:@"GPHome"];

}

- (IBAction)onLogout:(UIButton *)b
{
    [self alertText:@"您确定要退出登录么？" sureTitle:@"确定" sureAction:^{
        [YXUserModel logout];
    }];
}

@end
