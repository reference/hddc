//
//  GPNewTaskController.m
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPNewTaskController.h"
#import "GPArcGisMapController.h"
#import "NSString+YYAdd.h"

@interface GPNewTaskController ()
@property (nonatomic, strong) GPAdministrativeDivisionsModel *province;
@property (nonatomic, strong) GPAdministrativeDivisionsModel *city;
@property (nonatomic, strong) GPAdministrativeDivisionsModel *zone;
@property (nonatomic, strong) NSString *mapInfo;
@end

@implementation GPNewTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButtonBlack];
    //
    [self.textFields textFieldForTag:2].text = self.projectModel.projectName;
    
}

- (void)setupUI
{
    //任务编号和任务名称不能修改
    [self.textFields textFieldForTag:0].enabled = !self.isModify;
    [self.textFields textFieldForTag:1].enabled = !self.isModify;
    
    //任务编号
    [self.textFields textFieldForTag:0].text = self.taskModel.taskId;
    //任务名称
    [self.textFields textFieldForTag:1].text = self.taskModel.taskName;
    if (self.isModify) {
        //省
        [[self.buttons buttonForTag:0] setTitle:self.taskModel.province forState:UIControlStateNormal];
        //试
        [[self.buttons buttonForTag:1] setTitle:self.taskModel.city forState:UIControlStateNormal];
        //区
        [[self.buttons buttonForTag:2] setTitle:self.taskModel.area forState:UIControlStateNormal];
        //确认修改
        [[self.buttons buttonForTag:3] setTitle:@"确认修改" forState:UIControlStateNormal];
    }else{
        //确认添加
        [[self.buttons buttonForTag:3] setTitle:@"确认添加" forState:UIControlStateNormal];
    }
    //描述
    [self.textFields textFieldForTag:3].text = self.taskModel.remark;
    
}

#pragma mark - action

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

- (IBAction)onPickerMap:(UIButton *)b
{
    [self pushViewControllerClass:GPArcGisMapController.class inStoryboard:@"GPTask" block:^(UIViewController *viewController) {
        GPArcGisMapController *vc = (GPArcGisMapController *)viewController;
        vc.mapInfo = self.taskModel.mapInfos;
        @weakify(self)
        vc.selectedMapCallback = ^(NSString * _Nonnull mapInfo) {
            @strongify(self)
            self.mapInfo = mapInfo ? mapInfo : self.taskModel.mapInfos;
        };
    }];
}

- (IBAction)onSave:(UIButton *)b
{
    [self.view endEditing:YES];
    
    YXTaskModel *body = nil;
    //如果是修改 原来的样子返回
    if (self.isModify) {
        body = self.taskModel;
    }else{
        body = [YXTaskModel new];
    }
    
    //判定
    if (!self.isModify) {
        if (self.zone == nil) {
            [BDToastView showText:@"地区不能为空"];
            return;
        }
    }
    //任务编号
    if ([[self.textFields textFieldForTag:0].text trim].length == 0) {
        [BDToastView showText:@"编号不能为空"];
        return;
    }
    //任务名称
    if ([[self.textFields textFieldForTag:1].text trim].length == 0) {
        [BDToastView showText:@"任务名称不能为空"];
        return;
    }
    //任务描述
//    if ([[self.textFields textFieldForTag:3].text trim].length == 0) {
//        [BDToastView showText:@"任务描述不能为空"];
//        return;
//    }
    //编号
    body.taskId = [[self.textFields textFieldForTag:0].text trim];
    //任务名称
    body.taskName = [[self.textFields textFieldForTag:1].text trim];
    //所属项目ID
    body.belongProjectID = self.projectModel.projectId;
    //所属项目
    body.belongProject = self.projectModel.projectName;
    //任务描述
    body.remark = [[self.textFields textFieldForTag:3].text trim];
    //
    body.createUser = [YXUserModel currentUser].userId;
    
    if (self.isModify) {
        //id
        body.id = self.taskModel.id;
        //省
        body.province = self.province.divisionName.length > 0 ? self.province.divisionName : self.taskModel.province;
        //市
        body.city = self.city.divisionName.length > 0 ? self.city.divisionName : self.taskModel.city;
        //区
        body.area = self.zone.divisionName.length > 0 ? self.zone.divisionName : self.taskModel.area;
        //地图范围
        body.mapInfos = self.mapInfo ? self.mapInfo : self.taskModel.mapInfos;
    }else{
        //省
        body.province = self.province.divisionName;
        //市
        body.city = self.city.divisionName;
        //区
        body.area = self.zone.divisionName;
        //地图范围
        body.mapInfos = self.mapInfo;
    }
    
    [BDToastView showActivity:@"保存中..."];
    if (self.isModify) {
        [YXTaskModel updateTaskWithBody:body completion:^(NSError * _Nonnull error) {
            if (error) {
                [BDToastView showText:error.localizedDescription];
            }else{
                [BDToastView showText:@"任务修改成功"];
                [self popViewControllerAnimated:YES];
            }
        }];
    }
    else{
        [YXTaskModel newTaskWithBody:body completion:^(NSError * _Nonnull error) {
            if (error) {
                [BDToastView showText:error.localizedDescription];
            }else{
                [BDToastView showText:@"任务创建成功"];
                [self popViewControllerAnimated:YES];
            }
        }];
    }
}

@end
