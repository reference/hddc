//
//  GPGeochemicalSvyLine.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPGeochemicalSvyLine.h"

@interface GPGeochemicalSvyLine ()
//探测方法
@property (nonatomic, strong) YXSlectionDictModel *svymethodModel;
@end

@implementation GPGeochemicalSvyLine

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 1390;

    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXGeochemicalSvyLineModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXGeochemicalSvyLineModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXGeochemicalSvyLineModel *m = model;
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
    
    //测线名称
    [self.textFields textFieldForTag:3].text = m.name;
    //探测方法
    [self.labels labelForTag:0].text = m.svymethodName;
    if (m.svymethodName.length) {
        self.svymethodModel = [YXSlectionDictModel new];
        self.svymethodModel.dictItemName = m.svymethodName;
        self.svymethodModel.dictItemCode = m.svymethod;
    }
    //测线长度 [米]
    [self.textFields textFieldForTag:4].text = m.length;
    //测线起点经度
    [self.textFields textFieldForTag:5].text = m.startlongitude;
    //测线起点纬度
    [self.textFields textFieldForTag:6].text = m.startlatitude;
    //测线终点经度
    [self.textFields textFieldForTag:7].text = m.endlongitutde;
    //测线终点纬度
    [self.textFields textFieldForTag:8].text = m.endlatitude;
    //测线所属工程编号
    [self.textFields textFieldForTag:9].text = m.projectcode;
    //测点数
    [self.textFields textFieldForTag:10].text = m.svypointnum;
    //内插点
    [self.textFields textFieldForTag:11].text = m.interpolatenum;
    //异常点总数
    [self.textFields textFieldForTag:12].text = m.abnpointnum;
    //均值
    [self.textFields textFieldForTag:13].text = m.meanvalue;
    //异常下限值
    [self.textFields textFieldForTag:14].text = m.abnormalbottomvalue;
    //显示码（制图用）
    [self.textFields textFieldForTag:15].text = m.showcode;
    //备注
    [self.textFields textFieldForTag:16].text = m.commentInfo;
}

//填充数据
- (id)buildBody
{
    YXGeochemicalSvyLineModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXGeochemicalSvyLineModel new];
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
    body.projectcode = self.projectModel.projectId;
    //userid
    body.userId = [YXUserModel currentUser].userId;
    //create
    body.createUser = body.userId;
    
    //编号
    body.id = [[self.textFields textFieldForTag:2].text trim];
    //测线名称
    body.name = [[self.textFields textFieldForTag:3].text trim];
    //探测方法
    body.svymethod = self.svymethodModel.dictItemCode;
    body.svymethodName = self.svymethodModel.dictItemName;
    //测线长度 [米]
    body.length = [[self.textFields textFieldForTag:4].text trim];
    //测线起点经度
    body.startlongitude = [[self.textFields textFieldForTag:5].text trim];
    //测线起点纬度
    body.startlatitude = [[self.textFields textFieldForTag:6].text trim];
    //测线终点经度
    body.endlongitutde = [[self.textFields textFieldForTag:7].text trim];
    //测线终点纬度
    body.endlatitude = [[self.textFields textFieldForTag:8].text trim];
    //测线所属工程编号
    body.projectId = [[self.textFields textFieldForTag:9].text trim];
    //测点数
    body.svypointnum = [[self.textFields textFieldForTag:10].text trim];
    //内插点
    body.interpolatenum = [[self.textFields textFieldForTag:11].text trim];
    //异常点总数
    body.abnpointnum = [[self.textFields textFieldForTag:12].text trim];
    //均值
    body.meanvalue = [[self.textFields textFieldForTag:13].text trim];
    //异常下限值
    body.abnormalbottomvalue = [[self.textFields textFieldForTag:14].text trim];
    //显示码（制图用）
    body.showcode = [[self.textFields textFieldForTag:15].text trim];
    //备注
    body.commentInfo = [[self.textFields textFieldForTag:16].text trim];
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark 选择类

/// 探测方法
- (IBAction)onTanCeFangFa:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_GeochemicalSvyLine code:@"GeochemSvyMethodCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:0].text = model.dictItemName;
                self.svymethodModel = model;
            };
        }
    }];
}

#pragma mark - action

- (IBAction)onSave:(UIButton *)b
{
    [self judgeBaseDataWhenFinished:^(BOOL pass) {
        if (pass) {
            //测线名称
            if ([[self.textFields textFieldForTag:3].text trim].length == 0) {
                [BDToastView showText:@"测线名称不能为空"];
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
                t.tableName = NSStringFromClass(YXGeochemicalSvyLineModel.class);
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
            //测线名称
            if ([[self.textFields textFieldForTag:3].text trim].length == 0) {
                [BDToastView showText:@"测线名称不能为空"];
                return;
            }
            [self alertText:@"数据提交成功后将不能修改，您是否确认提交？" sureTitle:@"提交" sureAction:^{
                [BDToastView showActivity:@"提交中..."];
                //submit
                void (^submitRequest)(NSString *imgUrls) = ^(NSString *imgUrls) {
                    YXGeochemicalSvyLineModel *body = [self buildBody];
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
