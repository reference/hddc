//
//  GPVolcanicSamplePoint.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPVolcanicSamplePoint.h"

@interface GPVolcanicSamplePoint ()
//采样点符号
@property (nonatomic, strong) YXSlectionDictModel *symbolinfoModel;

@end

@implementation GPVolcanicSamplePoint

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 685;
    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXVolcanicSamplePointModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXVolcanicSamplePointModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXVolcanicSamplePointModel *m = model;
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
    
    //火山调查观测点编号
    [self.textFields textFieldForTag:3].text = m.volcanicsvypointid;
    //野外编号
    [self.textFields textFieldForTag:4].text = m.fieldid;
    //是否单次采样
    [self.textFields textFieldForTag:5].text = m.issinglesample;
    //是否单次采样
    [self.labels labelForTag:0].text = [m.issinglesample boolValue] ? @"是" : @"否";
    //采样点符号
    [self.labels labelForTag:1].text = m.symbolinfoName;
    if (m.symbolinfoName.length) {
        self.symbolinfoModel = [YXSlectionDictModel new];
        self.symbolinfoModel.dictItemName = m.symbolinfoName;
        self.symbolinfoModel.dictItemCode = m.symbolinfo;
    }
    //备注
    [self.textFields textFieldForTag:6].text = m.remark;
    //标注名称
    [self.textFields textFieldForTag:7].text = m.labelinfo;
}

//填充数据
- (id)buildBody
{
    YXVolcanicSamplePointModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXVolcanicSamplePointModel new];
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
    //火山调查观测点编号
    body.volcanicsvypointid = [[self.textFields textFieldForTag:3].text trim];
    //野外编号
    body.fieldid = [[self.textFields textFieldForTag:4].text trim];
    //是否单次采样
    body.issinglesample = [[self.textFields textFieldForTag:5].text trim];
    //是否单次采样
    body.issinglesample = [[[self.labels labelForTag:0].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    //采样点符号
    body.symbolinfo = self.symbolinfoModel.dictItemCode;
    body.symbolinfoName = self.symbolinfoModel.dictItemName;
    //备注
    body.remark = [[self.textFields textFieldForTag:6].text trim];
    //标注名称
    body.labelinfo = [[self.textFields textFieldForTag:7].text trim];
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark 选择类

/// 是否单次采样
- (IBAction)onShiFouDanCiCaiYang:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        [self.labels labelForTag:0].text = data;
    };
}

/// 采样点符号
- (IBAction)onCanYangDianFuHao:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_VolcanicSamplePoint code:@"SampleTestedMethodCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:1].text = model.dictItemName;
                self.symbolinfoModel = model;
            };
        }
    }];
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
                t.tableName = NSStringFromClass(YXVolcanicSamplePointModel.class);
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
                    YXVolcanicSamplePointModel *body = [self buildBody];
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
