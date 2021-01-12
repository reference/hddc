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
    [self.labels labelForTag:0].text = [[YXUserModel currentUser].relName substringWithRange:NSMakeRange(0, 1)];
    [self.labels labelForTag:1].text = [YXUserModel currentUser].relName;
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
        [[NSNotificationCenter defaultCenter] postNotificationName:BDUserNotificationLogout object:nil];
    }];
}

@end
