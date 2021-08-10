//
//  GPVolcanicSvyPoint.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPVolcanicSvyPoint.h"

@interface GPVolcanicSvyPoint ()
//观测日期
@property (nonatomic, strong) NSString *svydate;
@end

@implementation GPVolcanicSvyPoint

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 1666;
    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXVolcanicSvyPointModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXVolcanicSvyPointModel * _Nonnull m, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
            [self popViewControllerAnimated:YES];
        }else{
            [BDToastView dismiss];
            [self setUpUIByModel:m];
        }
    }];
}

- (void)setUpUIByModel:(id)model
{
    YXVolcanicSvyPointModel *m = model;
    //显示省
    self.provinceLabel.text = m.province;
    self.province = [GPAdministrativeDivisionsModel new];
    self.province.divisionName = m.province;
    //显示市
    self.cityLabel.text = m.city;
    self.city = [GPAdministrativeDivisionsModel new];
    self.city.divisionName = m.city;
    //显示区
    self.zoneLabel.text = m.area;
    self.zone = [GPAdministrativeDivisionsModel new];
    self.zone.divisionName = m.area;
    //经度
    [self.textFields textFieldForTag:0].text = m.lon;
    //纬度
    [self.textFields textFieldForTag:1].text = m.lat;
    //详细地址
    self.textViews.firstObject.text = m.town;
    //给底部的图片赋值
    if (m.extends7.length) {
        if (self.imageEntities.count == 0) {
            self.imageEntities = [NSMutableArray arrayWithArray:[GPFormBaseController imageEntitiesWithUrl:m.extends7]];
        }
    }
    //id
    [self.textFields textFieldForTag:2].text = m.id;
    
    //观测点野外编号
    [self.textFields textFieldForTag:3].text = m.fieldid;
    //观测点地名
    [self.textFields textFieldForTag:4].text = m.locationname;
    //观测日期
    [self.labels labelForTag:0].text = m.svydate;
    //观测目的
    [self.textFields textFieldForTag:5].text = m.purpose;
    //观测点描述
    [self.textFields textFieldForTag:6].text = m.spcommentInfo;
    //海拔高度 [米]
    [self.textFields textFieldForTag:7].text = m.elevation;
    //观测方法
    [self.textFields textFieldForTag:8].text = m.svymethods;
    //采集样品总数
    [self.textFields textFieldForTag:9].text = m.collectedsamplecount;
    //是否火山锥观测点
    [self.labels labelForTag:1].text = [m.isvocaniccone boolValue] ? @"是" : @"否";
    //是否熔岩流观测点
    [self.labels labelForTag:2].text = [m.islava boolValue] ? @"是" : @"否";
    //是否火山口观测点
    [self.labels labelForTag:3].text = [m.iscrater boolValue] ? @"是" : @"否";
    //典型照片文件编号
    [self.textFields textFieldForTag:10].text = m.photoAiid;
    //照片集镜向及拍摄者说明文档
    [self.textFields textFieldForTag:11].text = m.photodescArwid;
    //拍摄者
    [self.textFields textFieldForTag:12].text = m.photographer;
    //备注
    [self.textFields textFieldForTag:13].text = m.commentInfo;
    //工程编号
    [self.textFields textFieldForTag:14].text = m.projectcode;
    //送样总数
    [self.textFields textFieldForTag:15].text = m.samplecount;
    //获得测试结果样品数
    [self.textFields textFieldForTag:16].text = m.datingsamplecount;
    //是否在图中显示
    [self.labels labelForTag:4].text = [m.isinmap boolValue] ? @"是" : @"否";
}

//填充数据
- (id)buildBody
{
    YXVolcanicSvyPointModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXVolcanicSvyPointModel new];
    }
    //省
    body.province = self.provinceLabel.text;
    //市
    body.city = self.cityLabel.text;
    //区
    body.area = self.zoneLabel.text;
    //经度
    body.lon = [[self.textFields textFieldForTag:0].text trim];
    //维度
    body.lat = [[self.textFields textFieldForTag:1].text trim];
    //详细地址
    body.town = [self.textViews.firstObject.text trim];
    //type表单类型
    body.type = self.type;
    //taskid
    body.taskId = self.taskModel.taskId;
    //projectid =
    body.projectId = self.projectModel.projectId;
    //userid
    body.userId = [YXUserModel currentUser].userId;
    //create
    body.createUser = body.userId;
    
    //编号
    body.id = [[self.textFields textFieldForTag:2].text trim];
    //观测点野外编号
    body.fieldid = [[self.textFields textFieldForTag:3].text trim];
    //观测点地名
    body.locationname = [[self.textFields textFieldForTag:4].text trim];
    //观测日期
    body.svydate = self.svydate;
    //观测目的
    body.purpose = [[self.textFields textFieldForTag:5].text trim];
    //观测点描述
    body.spcommentInfo = [[self.textFields textFieldForTag:6].text trim];
    //海拔高度 [米]
    body.elevation = [[self.textFields textFieldForTag:7].text trim];
    //观测方法
    body.svymethods = [[self.textFields textFieldForTag:8].text trim];
    //采集样品总数
    body.collectedsamplecount = [[self.textFields textFieldForTag:9].text trim];
    //是否火山锥观测点
    body.isvocaniccone = [[[self.labels labelForTag:1].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    //是否熔岩流观测点
    body.islava = [[[self.labels labelForTag:2].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    //是否火山口观测点
    body.iscrater = [[[self.labels labelForTag:3].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    //典型照片文件编号
    body.photoAiid = [[self.textFields textFieldForTag:10].text trim];
    //照片集镜向及拍摄者说明文档
    body.photodescArwid = [[self.textFields textFieldForTag:11].text trim];
    //拍摄者
    body.photographer = [[self.textFields textFieldForTag:12].text trim];
    //备注
    body.commentInfo = [[self.textFields textFieldForTag:13].text trim];
    //工程编号
    body.projectcode = [[self.textFields textFieldForTag:14].text trim];
    //送样总数
    body.samplecount = [[self.textFields textFieldForTag:15].text trim];
    //获得测试结果样品数
    body.datingsamplecount = [[self.textFields textFieldForTag:16].text trim];
    //是否在图中显示
    body.isinmap = [[[self.labels labelForTag:4].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark 选择类

/// 观测日期
- (IBAction)onGuanCeRiQi:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    BDTimePickerView *selector = [BDTimePickerView popUpInController:self];
    selector.datePicker.datePickerMode = UIDatePickerModeDate;
    selector.cancelAction = ^{
        [self.window dismissViewAnimated:YES completion:nil];
    };
    selector.doneAction = ^(NSDate * _Nonnull date) {
        [self.window dismissViewAnimated:YES completion:^{
            [self.labels labelForTag:0].text = [date dateString];
            self.svydate = [date dateString];
        }];
    };
}

/// 是否火山锥观测点
- (IBAction)onShiFouHuoShanZhuiGuanCeDian:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        [self.labels labelForTag:1].text = data;
    };
}

/// 是否熔岩流观测点
- (IBAction)onShiFouRongYanLiuGuanCeDian:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        [self.labels labelForTag:2].text = data;
    };
}

/// 是否火山口观测点
- (IBAction)onShiFouHuoShanKouGuanCeDian:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        [self.labels labelForTag:3].text = data;
    };
}

/// 是否在图中显示
- (IBAction)onShiFouZaiTuZhongXianShi:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        [self.labels labelForTag:4].text = data;
    };
}


- (IBAction)onSave:(UIButton *)b
{
    [self judgeBaseDataWhenFinished:^(BOOL pass) {
        if (pass) {
            [BDToastView showActivity:@"保存中..."];
            
            @weakify(self)
            
            if (self.interfaceStatus == InterfaceStatus_Edit) {
                YXTable *t = self.table;
                t.encodedData = [[self buildBody] yy_modelToJSONString];
                [t bg_updateAsyncWhere:[NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"rowid"),bg_sqlValue(t.rowid)] complete:^(BOOL isSuccess) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        if (isSuccess) {
                            NSLog(@"数据库修改成功");
                            [BDToastView showText:@"数据已存入本地!"];
                            [self popViewControllerAnimated:YES];
                        }else{
                            NSLog(@"数据库保存失败");
                            [BDToastView showText:@"数据库修改失败"];
                        }
                    });
                }];
            }
            else if (self.interfaceStatus == InterfaceStatus_New) {
                YXTable *t = [YXTable new];
                t.rowid = [NSString randomKey];
                t.projectId = self.projectModel.projectId;
                t.taskId = self.taskModel.taskId;
                t.type = [self.type integerValue];
                t.userId = [YXUserModel currentUser].userId;
                t.tableName = NSStringFromClass(YXVolcanicSvyPointModel.class);
                t.encodedData = [[self buildBody] yy_modelToJSONString];
                [t bg_saveAsync:^(BOOL isSuccess) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        if (isSuccess) {
                            NSLog(@"数据库保存成功");
                            [BDToastView showText:@"数据已存入本地!"];
                            [self popViewControllerAnimated:YES];
                        }else{
                            NSLog(@"数据库保存失败");
                            [BDToastView showText:@"数据库保存失败"];
                        }
                    });
                }];
            }
        }
    }];
}

- (IBAction)onSubmit:(UIButton *)b
{
    //提交远程
    if (self.projectModel == nil || self.taskModel == nil) {
        [BDToastView showText:@"未指定项目或任务"];
        return;
    }
    [self judgeBaseDataWhenFinished:^(BOOL pass) {
        if (pass) {
            [self alertText:@"数据提交成功后将不能修改，您是否确认提交？" sureTitle:@"提交" sureAction:^{
                [BDToastView showActivity:@"提交中..."];
                //submit
                void (^submitRequest)(NSString *imgUrls) = ^(NSString *imgUrls) {
                    YXVolcanicSvyPointModel *body = [self buildBody];
                    body.extends7 = imgUrls;
                    [YXForumSaver saveWithBody:body completion:^(NSError * _Nonnull error) {
                        if (error) {
                            [BDToastView showText:error.localizedDescription];
                        }else{
                            [BDToastView showText:@"新增成功"];
                            //删除本地数据
                            [YXTable deleteRowById:self.table.rowid];
                            //删除图片
                            for (GPImageEntity *imgEntity in self.imageEntities) {
                                NSString *filePath = [NSFileManager documentFile:imgEntity.localPath];
                                [[NSFileManager defaultManager] removeItemAtURL:[NSURL URLWithString:filePath] error:nil];
                            }
                            [self popViewControllerAnimated:YES];
                        }
                    }];
                };
                
                //如果有图片
                if (self.imageEntities.count) {
                    //upload images first
                    [YXUpdateImagesModel uploadImageWithType:[self.type integerValue]
                                                      images:self.imageEntities
                                                  completion:^(NSString * _Nonnull urls, NSError * _Nonnull error) {
                        if (error) {
                            [BDToastView showText:error.localizedDescription];
                        }else{
                            submitRequest(urls);
                        }
                    }];
                }else{
                    submitRequest(nil);
                }
            }];
        }
    }];
}

@end
