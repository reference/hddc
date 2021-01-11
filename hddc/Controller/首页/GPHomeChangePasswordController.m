//
//  GPHomeChangePasswordController.m
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeChangePasswordController.h"

@interface GPHomeChangePasswordController ()

@end

@implementation GPHomeChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButtonBlack];
}

- (IBAction)onSave:(UIButton *)b
{
    //判定
    if ([[self.textFields textFieldForTag:0].text trim].length == 0) {
        [BDToastView showText:@"旧密码不能为空"];
        return;
    }
    if ([[self.textFields textFieldForTag:1].text trim].length == 0) {
        [BDToastView showText:@"新密码不能为空"];
        return;
    }
    if ([[self.textFields textFieldForTag:2].text trim].length == 0) {
        [BDToastView showText:@"确认密码不能为空"];
        return;
    }
    if (![[[self.textFields textFieldForTag:1].text trim] isEqualToString:[[self.textFields textFieldForTag:2].text trim]]) {
        [BDToastView showText:@"两次输入密码不一致"];
        return;
    }
    NSString *newPssword = [[self.textFields textFieldForTag:1].text trim];
    if (newPssword.length < 6 || newPssword.length > 20) {
        [BDToastView showText:@"新密码长度不正确"];
        return;
    }
    //RSA 加密
    BDRSAEncryptor* rsaEncryptor = [[BDRSAEncryptor alloc] init];
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    [rsaEncryptor loadPublicKeyFromFile:publicKeyPath];
    
    NSString * rsaEncodededOldPwd = [rsaEncryptor rsaEncryptString:[[self.textFields textFieldForTag:0].text trim]];
    NSString * rsaEncodededNewPwd = [rsaEncryptor rsaEncryptString:[[self.textFields textFieldForTag:1].text trim]];
    
    YXUpdatePasswordBody *body = [YXUpdatePasswordBody new];
    body.userId = [YXUserModel currentUser].userId;
    body.oldPwd = rsaEncodededOldPwd;
    body.myNewPwd = rsaEncodededNewPwd;
    [BDToastView showActivity:@"密码修改中..."];
    [YXUserUpdatePasswordModel updatePasswordWithBody:body completion:^(NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView showText:@"密码修改成功!"];
            [self popViewControllerAnimated:YES];
        }
    }];
}

@end
