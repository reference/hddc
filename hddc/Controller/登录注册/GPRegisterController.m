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
#import "GPRegisterController.h"

@interface GPRegisterController ()
@property (nonatomic, strong) GPAdministrativeDivisionsModel *province;
@property (nonatomic, strong) GPAdministrativeDivisionsModel *city;
@property (nonatomic, strong) GPAdministrativeDivisionsModel *zone;
@end

@implementation GPRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    self.window.touchedBackgroundBlock = ^{
        @strongify(self)
        [self.window dismissViewAnimated:YES completion:nil];
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self setBackButtonWhite];
    [self setThemeNavigation];
}

- (IBAction)onChooseProvice:(UIButton *)b
{
    GPCityPicker *selector = [GPCityPicker popUpInController:self rootId:nil];
    selector.onCancel = ^{
        [self.window dismissViewAnimated:YES completion:nil];
    };
    selector.onDone = ^(GPAdministrativeDivisionsModel * _Nonnull model) {
        [self.window dismissViewAnimated:YES completion:^{
            self.province = model;
            [[self.buttons buttonForTag:0] setTitle:model.divisionName forState:UIControlStateNormal];
            
            //
            self.city = self.zone = nil;
            
            //禁用第二级联动选项
            if ([model.divisionType isEqualToString:@"Municipality"]) {
                [self.buttons buttonForTag:1].enabled = NO;
                [[self.buttons buttonForTag:1] setTitle:model.divisionName forState:UIControlStateNormal];
            }else{
                [self.buttons buttonForTag:1].enabled = YES;
                [[self.buttons buttonForTag:1] setTitle:@"选择市" forState:UIControlStateNormal];
            }
            //zone
            [[self.buttons buttonForTag:2] setTitle:@"选择区" forState:UIControlStateNormal];
        }];
    };
}

- (IBAction)onChooseCity:(UIButton *)b
{
    if (self.province == nil) {
        return;
    }
    GPCityPicker *selector = [GPCityPicker popUpInController:self rootId:self.province.divisionId];
    selector.onCancel = ^{
        [self.window dismissViewAnimated:YES completion:nil];
    };
    selector.onDone = ^(GPAdministrativeDivisionsModel * _Nonnull model) {
        [self.window dismissViewAnimated:YES completion:^{
            self.city = model;
            [[self.buttons buttonForTag:1] setTitle:model.divisionName forState:UIControlStateNormal];
            
            //
            self.zone = nil;
            //zone
            [[self.buttons buttonForTag:2] setTitle:@"选择区" forState:UIControlStateNormal];
        }];
    };
}

- (IBAction)onChooseZone:(UIButton *)b
{
    if (self.province == nil) {
        return;
    }
    if (![self.province.divisionType isEqualToString:@"Municipality"] && self.city == nil) {
        return;
    }
    NSString *useDivisionId = [self.buttons buttonForTag:1].enabled ? self.city.divisionId : self.province.divisionId;
    GPCityPicker *selector = [GPCityPicker popUpInController:self rootId:useDivisionId];
    selector.onCancel = ^{
        [self.window dismissViewAnimated:YES completion:nil];
    };
    selector.onDone = ^(GPAdministrativeDivisionsModel * _Nonnull model) {
        [self.window dismissViewAnimated:YES completion:^{
            self.zone = model;
            [[self.buttons buttonForTag:2] setTitle:model.divisionName forState:UIControlStateNormal];
        }];
    };
}

- (IBAction)onRegist:(UIButton *)b
{
    //判定
    if ([[self.textFields textFieldForTag:0].text trim].length == 0) {
        [BDToastView showText:@"姓名不能为空"];
        return;
    }
    if ([[self.textFields textFieldForTag:1].text trim].length == 0) {
        [BDToastView showText:@"身份证号不能为空"];
        return;
    }
    if (self.zone == nil) {
        [BDToastView showText:@"所属地区不能为空"];
        return;
    }
    if ([[self.textFields textFieldForTag:3].text trim].length == 0) {
        [BDToastView showText:@"密码不能为空"];
        return;
    }
    NSString *password = [[self.textFields textFieldForTag:3].text trim];
    if (password.length < 6 || password.length > 20) {
        [BDToastView showText:@"密码长度不正确"];
        return;
    }
    if ([[self.textFields textFieldForTag:4].text trim].length == 0) {
        [BDToastView showText:@"验证密码不能为空"];
        return;
    }
    NSString *passwordConfirm = [[self.textFields textFieldForTag:4].text trim];
    if (![password isEqualToString:passwordConfirm]) {
        [BDToastView showText:@"两次输入的密码不一致"];
        return;
    }
    if ([[self.textFields textFieldForTag:5].text trim].length == 0) {
        [BDToastView showText:@"手机号不能为空"];
        return;
    }
    
    YXRegisterBody *body = [YXRegisterBody new];
    body.relName = [[self.textFields textFieldForTag:0].text trim];
    body.idNumber = [[self.textFields textFieldForTag:1].text trim];
    body.division = self.zone.divisionId;
    body.unit = [[self.textFields textFieldForTag:2].text trim];
    body.pwd = [[self.textFields textFieldForTag:3].text trim];
    body.userName = [[self.textFields textFieldForTag:5].text trim];
    
    [BDToastView showActivity:@"注册中..."];
    [YXUserModel registerWithBody:body completion:^(NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView showText:@"注册成功！"];
            [self popViewControllerAnimated:YES];
        }
    }];
}

@end
