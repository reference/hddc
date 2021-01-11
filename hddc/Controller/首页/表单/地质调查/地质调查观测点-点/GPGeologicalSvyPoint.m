//
//  GPGeologicalSvyPoint.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPGeologicalSvyPoint.h"

@interface GPGeologicalSvyPoint ()
//观测日期
@property (nonatomic, strong) NSString *svydate;
//照片镜像
@property (nonatomic, strong) YXSlectionDictModel *photoviewingtoModel;
@end

@implementation GPGeologicalSvyPoint

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 1735;

    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXGeologicalSvyPointModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXGeologicalSvyPointModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXGeologicalSvyPointModel *m = model;
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
        self.imageEntities = [NSMutableArray arrayWithArray:[GPFormBaseController imageEntitiesWithUrl:m.extends7]];
    }
    //id
    [self.textFields textFieldForTag:2].text = m.id;
    
    //野外编号
    [self.textFields textFieldForTag:3].text = m.fieldid;
    //观测点地名
    [self.textFields textFieldForTag:4].text = m.locationname;
    //观测日期
    [self.labels labelForTag:0].text = m.svydate;
    //观测目的
    [self.textFields textFieldForTag:5].text = m.purpose;
    //观测点描述
    [self.textFields textFieldForTag:6].text = m.spcommentInfo;
    //海拔高度【米】
    [self.textFields textFieldForTag:7].text = m.elevation;
    //是否断点
    [self.labels labelForTag:1].text = [m.isfaultpoint boolValue] ? @"是" : @"否";
    //是否地貌点
    [self.labels labelForTag:2].text = [m.isgeomorphpoint boolValue] ? @"是" : @"否";
    //是否底层点
    [self.labels labelForTag:3].text = [m.isstratigraphypoint boolValue] ? @"是" : @"否";

    //典型照片文件编号
    [self.textFields textFieldForTag:8].text = m.photoAiid;
    //照片镜像
    [self.labels labelForTag:4].text = m.photoviewingtoName;
    if (m.photoviewingtoName.length) {
        self.photoviewingtoModel = [YXSlectionDictModel new];
        self.photoviewingtoModel.dictItemName = m.photoviewingtoName;
        self.photoviewingtoModel.dictItemCode = m.photoviewingto;
    }
    //拍摄者
    [self.textFields textFieldForTag:9].text = m.photographer;
    //工程编号
    [self.textFields textFieldForTag:10].text = m.projectid;
    //地质剖面线编号
    [self.textFields textFieldForTag:11].text = m.profilesvylineid;
    //观测方法
    [self.textFields textFieldForTag:12].text = m.svymethods;
    //采集样品总数
    [self.textFields textFieldForTag:13].text = m.collectedsamplecount;
    //送样总数
    [self.textFields textFieldForTag:14].text = m.samplecount;
    //获得测试结果样品数
    [self.textFields textFieldForTag:15].text = m.datingsamplecount;
    //是否在图中显示
    [self.labels labelForTag:5].text = [m.isstratigraphypoint boolValue] ? @"是" : @"否";

    //备注
    [self.textFields textFieldForTag:16].text = m.remark;
}

//填充数据
- (id)buildBody
{
    YXGeologicalSvyPointModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXGeologicalSvyPointModel new];
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
    //野外编号
    body.fieldid = [[self.textFields textFieldForTag:3].text trim];
    //观测点地名
    body.locationname = [[self.textFields textFieldForTag:4].text trim];
    //观测日期
    body.svydate = self.svydate;
    //观测目的
    body.purpose = [[self.textFields textFieldForTag:5].text trim];
    //观测点描述
    body.spcommentInfo = [[self.textFields textFieldForTag:6].text trim];
    //海拔高度【米】
    body.elevation = [[self.textFields textFieldForTag:7].text trim];
    //是否断点
    body.isfaultpoint = [[[self.labels labelForTag:1].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    //是否地貌点
    body.isgeomorphpoint = [[[self.labels labelForTag:2].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    //是否底层点
    body.isstratigraphypoint = [[[self.labels labelForTag:3].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    //典型照片文件编号
    body.photoAiid = [[self.textFields textFieldForTag:8].text trim];
    //照片镜像
    body.photoviewingto = self.photoviewingtoModel.dictItemCode;
    body.photoviewingtoName = self.photoviewingtoModel.dictItemName;
    //拍摄者
    body.photographer = [[self.textFields textFieldForTag:9].text trim];
    //工程编号
    body.projectid = [[self.textFields textFieldForTag:10].text trim];
    //地质剖面线编号
    body.profilesvylineid = [[self.textFields textFieldForTag:11].text trim];
    //观测方法
    body.svymethods = [[self.textFields textFieldForTag:12].text trim];
    //采集样品总数
    body.collectedsamplecount = [[self.textFields textFieldForTag:13].text trim];
    //送样总数
    body.samplecount = [[self.textFields textFieldForTag:14].text trim];
    //获得测试结果样品数
    body.datingsamplecount = [[self.textFields textFieldForTag:15].text trim];
    //是否在图中显示
    body.isstratigraphypoint = [[[self.labels labelForTag:5].text trim] isEqualToString:@"显示"] ? @"1" : @"0";
    //备注
    body.remark = [[self.textFields textFieldForTag:16].text trim];
    
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

/// 是否断点
- (IBAction)onShiFouDuanDian:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        //是否断点
        [self.labels labelForTag:1].text = data;
    };
}

/// 是否地貌点
- (IBAction)onShiFouDiMaoDian:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        //是否地貌点
        [self.labels labelForTag:2].text = data;
    };
}

//是否地层点
- (IBAction)onShiFouDiCengDian:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        //是否地层点
        [self.labels labelForTag:3].text = data;
    };
}

/// 镜头镜像
- (IBAction)onJingTouMirror:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_GeologicalSvyPoint code:@"CVD-16-Direction" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:4].text = model.dictItemName;
                self.photoviewingtoModel = model;
            };
        }
    }];
}

/// 是否在在图中显示
- (IBAction)onShowInPicture:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"显示",@"不显示"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        //是否在在图中显示
        [self.labels labelForTag:5].text = data;
    };
}

#pragma mark - action

- (IBAction)onSave:(UIButton *)b
{
    [self judgeBaseDataWhenFinished:^(BOOL pass) {
        if (pass) {
            //海拔高度【米】
            if ([[self.textFields textFieldForTag:7].text trim].length == 0) {
                [BDToastView showText:@"海拔高度不能为空"];
                return;
            }
            
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
                t.tableName = NSStringFromClass(YXGeologicalSvyPointModel.class);
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
            //海拔高度【米】
            if ([[self.textFields textFieldForTag:7].text trim].length == 0) {
                [BDToastView showText:@"海拔高度不能为空"];
                return;
            }
            
            [self alertText:@"数据提交成功后将不能修改，您是否确认提交？" sureTitle:@"提交" sureAction:^{
                [BDToastView showActivity:@"提交中..."];
                //submit
                void (^submitRequest)(NSString *imgUrls) = ^(NSString *imgUrls) {
                    YXGeologicalSvyPointModel *body = [self buildBody];
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
