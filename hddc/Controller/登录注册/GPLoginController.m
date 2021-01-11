/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
#import "GPLoginController.h"
#import "GPRegisterController.h"
#import "GPGuijiTraceMapController.h"

@interface GPLoginController ()
@property (nonatomic, strong) IBOutlet UIView *bgView;
@end

@implementation GPLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    //过渡色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorNamed:@"color_light_blue"].CGColor, (__bridge id)[UIColor colorNamed:@"color_heavy_blue"].CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = self.view.frame;
    [self.bgView.layer addSublayer:gradientLayer];
    
    //
    [self.textFields textFieldForTag:0].text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    [self.textFields textFieldForTag:1].text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

+ (void)showLoginFromController:(UIViewController *)viewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GPLogin" bundle:nil];
    ZXNavigationController *nv = [sb instantiateViewControllerWithIdentifier:@"GPLoginNaviController"];
    nv.modalPresentationStyle = UIModalPresentationFullScreen;
    [viewController presentViewController:nv animated:YES completion:nil];
}

// MARK: action

- (IBAction)onLogin:(UIButton *)b
{
    //判定
    if ([[self.textFields textFieldForTag:0].text trim].length == 0) {
        [BDToastView showText:@"手机号不能为空"];
        return;
    }
    if ([[self.textFields textFieldForTag:1].text trim].length == 0) {
        [BDToastView showText:@"密码不能为空"];
        return;
    }
    BDRSAEncryptor* rsaEncryptor = [[BDRSAEncryptor alloc] init];
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    [rsaEncryptor loadPublicKeyFromFile:publicKeyPath];
    NSString * restrinBASE64STRING=[rsaEncryptor rsaEncryptString:[[self.textFields textFieldForTag:1].text trim]];
//    NSLog(@"加密后的: %@", restrinBASE64STRING);     //加密

    [BDToastView showActivity:@"登陆中..."];

    YXUserLoginBody *body = [YXUserLoginBody new];
    body.password = restrinBASE64STRING;
    body.userName = [[self.textFields textFieldForTag:0].text trim];
    body.appCode = @"ios";
    
    [YXUserLoginModel loginWithBody:body
                         completion:^(YXUserLoginModel * _Nonnull m, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [YXUserModel getUserInfoById:m.userId completion:^(YXUserModel * _Nonnull user, NSError * _Nonnull error) {
                
                user.userId = m.userId;
                [user saveAsCurrent];
                [[NSNotificationCenter defaultCenter] postNotificationName:BDUserNotificationLogin object:nil];
                
                [BDToastView showText:@"登录成功"];
                
                //保存用户名和密码
                [[NSUserDefaults standardUserDefaults] setObject:body.userName forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults] setObject:[[self.textFields textFieldForTag:1].text trim] forKey:@"password"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }];
        }
    }];
}

- (IBAction)onRegister:(UIButton *)b
{
    [self pushViewControllerClass:GPRegisterController.class inStoryboard:@"GPLogin"];
}

- (IBAction)onStartRecord:(UIButton *)b
{
    [[BDLocationTrace instance] start];
    
}

- (IBAction)onStopRecord:(UIButton *)b
{
    [[BDLocationTrace instance] stop];
    
    [GPGuijiTraceMapController showFromController:self];
}

@end
