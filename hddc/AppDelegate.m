//
//  AppDelegate.m
//  BDGuPiao
//
//  Created by B-A-N on 2020/7/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "AppDelegate.h"
#import "GPTabBarController.h"
#import "GPHomeController.h"
#import "GPTempLaunchController.h"

#import <PPSPing/PPSPingServices.h>
#import <UserNotifications/UserNotifications.h>
#import "GPHomeSettingKMLListController.h"

//高德地图
#define GaoDeMapAppKey @"cb9e415529134e663f9d0182d930d02f"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.service = [PPSPingServices serviceWithAddress:HOST];
//    self.service.tim
//    [self.service startWithCallbackHandler:^(PPSPingSummary *pingItem, NSArray *pingItems) {
//        NSLog(@"%@",pingItem);
//    }];
    [Bugly startWithAppId:@"e1c73bc497"];
    
    //regist fuck gis
    [[FuckAGSPlatform instance] registAppWithId:@"fxdefkjsokfhi3025kdi2"];
    
    //map
    [AGSArcGISRuntimeEnvironment setLicenseKey:@"runtimelite,1000,rud3292847818,none,LHH93PJPXL0JLMZ59229" error:nil];
    
    //设置键盘遮挡第三方
    [IQKeyboardManager sharedManager].enable = YES;
    //控制点击背景是否收起键盘。
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //控制键盘上的工具条文字颜色是否用户自定义
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    //控制是否显示键盘上的工具条。
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    
    self.window = [[UIWindow alloc] init];
    
    //登录登出监听
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:BDUserNotificationLogin object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self gotoHome];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:BDUserNotificationLogout object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self gotoLogin];

    }];

    if ([YXUserModel isLogin]) {
        [self goTempLaunch];
        [self reLogin];
//        [self api_relogin];
//        [self gotoHome];
    }else{
        [NSThread sleepForTimeInterval:1.5];
        [self gotoLogin];
    }
    
    //注册推送
//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (!error) {
//            NSLog(@"request authorization succeeded!");
//        }
//    }];
    return YES;
}

- (void)goMap
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GPTask" bundle:nil];
    KKBaseViewController *vc = [sb instantiateViewControllerWithIdentifier:@"GPArcGisMapController"];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

- (void)goTempLaunch
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GPTempLaunch" bundle:nil];
    GPTempLaunchController *vc = (GPTempLaunchController*)[sb instantiateViewControllerWithIdentifier:@"GPTempLaunchController"];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

- (void)gotoLogin
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GPLogin" bundle:nil];
    ZXNavigationController *nv = (ZXNavigationController*)[sb instantiateViewControllerWithIdentifier:@"GPLoginNaviController"];
    self.window.rootViewController = nv;
    [self.window makeKeyAndVisible];
}

- (void)gotoHome
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GPHome" bundle:nil];
    ZXNavigationController *nv = (ZXNavigationController*)[sb instantiateViewControllerWithIdentifier:@"GPHomeNaviController"];
    self.window.rootViewController = nv;
    [self.window makeKeyAndVisible];
}

- (void)reLogin
{
//    [BDToastView showActivity:@"自动登陆中..."];
    YXUserLoginBody *body = [YXUserLoginBody new];
    //
    BDRSAEncryptor* rsaEncryptor = [[BDRSAEncryptor alloc] init];
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    [rsaEncryptor loadPublicKeyFromFile:publicKeyPath];
    NSString * restrinBASE64STRING=[rsaEncryptor rsaEncryptString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];
    //
    body.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    body.password = restrinBASE64STRING;
    body.appCode = @"ios";
    [YXUserLoginModel loginWithBody:body
                         completion:^(YXUserLoginModel * _Nonnull m, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
            if ([YXUserModel isLogin]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:BDUserNotificationLogin object:nil];

            }else{
                [self gotoLogin];
            }
        }else{
            [YXUserModel getUserInfoById:m.userId completion:^(YXUserModel * _Nonnull user, NSError * _Nonnull error) {
                if (error) {
                    [BDToastView showText:error.localizedDescription];
                    [self gotoLogin];
                }else{
                    user.userId = m.userId;
                    [user saveAsCurrent];
                    [[NSNotificationCenter defaultCenter] postNotificationName:BDUserNotificationLogin object:nil];
                }
            }];
        }
    }];
}

- (void)api_relogin
{
    YXUserLoginBody *body = [YXUserLoginBody new];
    //
    BDRSAEncryptor* rsaEncryptor = [[BDRSAEncryptor alloc] init];
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    [rsaEncryptor loadPublicKeyFromFile:publicKeyPath];
    NSString * restrinBASE64STRING=[rsaEncryptor rsaEncryptString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];
    //
    body.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    body.password = restrinBASE64STRING;
    body.appCode = @"ios";
    [YXUserLoginModel loginWithBody:body
                         completion:^(YXUserLoginModel * _Nonnull m, NSError * _Nonnull error) {
        if (error) {
        }else{
        }
    }];
}

#pragma mark - background location trace

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[BDLocationTrace instance] enterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[BDLocationTrace instance] enterForekground:application];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    NSLog(@"application = %@",app);
    NSLog(@"url = %@",url);
    
    /*外部文件访问本应用,会传递参数过来*/
    NSString *fileNameWithSuffix = [url.absoluteString componentsSeparatedByString:@"/"].lastObject;
    // 中文处理
    NSString *suffix = [fileNameWithSuffix componentsSeparatedByString:@"."].lastObject;
    if ([[suffix lowercaseString] isEqualToString:@"kml"] || [[suffix lowercaseString] isEqualToString:@"kmz"] || [[suffix lowercaseString] isEqualToString:@"shp"] || [[suffix lowercaseString] isEqualToString:@"json"] || [[suffix lowercaseString] isEqualToString:@"geojson"]) {
        NSData *fileData = [NSData dataWithContentsOfURL:url];
        fileNameWithSuffix = [fileNameWithSuffix stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
        NSString *localFilePath = [NSFileManager documentFile:fileNameWithSuffix inDirectory:@"web"];
        //
        [fileData writeToFile:localFilePath atomically:YES];

        ZXNavigationController *nav = self.window.rootViewController;
        [nav.rootViewController pushViewControllerClass:GPHomeSettingKMLListController.class inStoryboard:@"GPHome"];
    }
    
    return YES;
}
@end
