//
//  GPGeophySvyLine.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPGeophySvyLine.h"

@interface GPGeophySvyLine ()
//测线来源与类型
@property (nonatomic, strong) YXSlectionDictModel *svylinesourceModel;
//探测方法
@property (nonatomic, strong) YXSlectionDictModel *svymethodModel;

@end

@implementation GPGeophySvyLine

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 1430;

    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXGeophySvyLineModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXGeophySvyLineModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXGeophySvyLineModel *m = model;
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
    
    //测线名称
    [self.textFields textFieldForTag:3].text = m.name;
    //测线来源与类型
    [self.labels labelForTag:0].text = m.svylinesourceName;
    if (m.svymethodName.length) {
        self.svylinesourceModel = [YXSlectionDictModel new];
        self.svylinesourceModel.dictItemName = m.svylinesourceName;
        self.svylinesourceModel.dictItemCode = m.svylinesource;
    }
    //探测目的
    [self.textFields textFieldForTag:4].text = m.purpose;
    //探测方法
    [self.labels labelForTag:1].text = m.svymethodName;
    if (m.svymethodName.length) {
        self.svymethodModel = [YXSlectionDictModel new];
        self.svymethodModel.dictItemName = m.svymethodName;
        self.svymethodModel.dictItemCode = m.svymethod;
    }
    //起点桩号
    [self.textFields textFieldForTag:5].text = m.startmilestonenum;
    //终点桩号
    [self.textFields textFieldForTag:6].text = m.endmilestonenum;
    //测线长度 [米]
    [self.textFields textFieldForTag:7].text = m.length;
    //测线所属探测工程编号
    [self.textFields textFieldForTag:8].text = m.projectcode;
    //测线代码
    [self.textFields textFieldForTag:9].text = m.fieldid;
    //收集地球物理测线来源补充说明来源
    [self.textFields textFieldForTag:10].text = m.collectedlinesource;
    //综合解释剖面名称
    [self.textFields textFieldForTag:11].text = m.resultname;
    //综合解释剖面原始数据文件编号（sgy等）
    [self.textFields textFieldForTag:12].text = m.expdataArwid;
    //综合解释剖面矢量图原始文件编号
    [self.textFields textFieldForTag:13].text = m.resultmapArwid;
    //综合解释剖面栅格图原始文件编号
    [self.textFields textFieldForTag:14].text = m.resultmapAiid;
    //显示码（制图用）
    [self.textFields textFieldForTag:15].text = m.showcode;
    //备注
    [self.textFields textFieldForTag:16].text = m.remark;
}

//填充数据
- (id)buildBody
{
    YXGeophySvyLineModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXGeophySvyLineModel new];
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
    //测线来源与类型
    body.svylinesource = self.svylinesourceModel.dictItemCode;
    body.svylinesourceName = self.svylinesourceModel.dictItemName;
    //探测目的
    body.purpose = [[self.textFields textFieldForTag:4].text trim];
    //探测方法
    body.svymethod = self.svymethodModel.dictItemCode;
    body.svymethodName = self.svymethodModel.dictItemName;
    //起点桩号
    body.startmilestonenum = [[self.textFields textFieldForTag:5].text trim];
    //终点桩号
    body.endmilestonenum = [[self.textFields textFieldForTag:6].text trim];
    //测线长度 [米]
    body.length = [[self.textFields textFieldForTag:7].text trim];
    //测线所属探测工程编号
    body.projectId = [[self.textFields textFieldForTag:8].text trim];
    //测线代码
    body.fieldid = [[self.textFields textFieldForTag:9].text trim];
    //收集地球物理测线来源补充说明来源
    body.collectedlinesource = [[self.textFields textFieldForTag:10].text trim];
    //综合解释剖面名称
    body.resultname = [[self.textFields textFieldForTag:11].text trim];
    //综合解释剖面原始数据文件编号（sgy等）
    body.expdataArwid = [[self.textFields textFieldForTag:12].text trim];
    //综合解释剖面矢量图原始文件编号
    body.resultmapArwid = [[self.textFields textFieldForTag:13].text trim];
    //综合解释剖面栅格图原始文件编号
    body.resultmapAiid = [[self.textFields textFieldForTag:14].text trim];
    //显示码（制图用）
    body.showcode = [[self.textFields textFieldForTag:15].text trim];
    //备注
    body.remark = [[self.textFields textFieldForTag:16].text trim];
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark 选择类

/// 测线来源与类型
- (IBAction)onCeXianLaiYuanYuLeiXing:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_GeophySvyLine code:@"GeophyLineTypeCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:0].text = model.dictItemName;
                self.svylinesourceModel = model;
            };
        }
    }];
}

/// 探测方法
- (IBAction)onTanCeFangFa:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_GeophySvyLine code:@"GeophySvyMethodCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:1].text = model.dictItemName;
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
                t.tableName = NSStringFromClass(YXGeophySvyLineModel.class);
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
                    YXGeophySvyLineModel *body = [self buildBody];
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
