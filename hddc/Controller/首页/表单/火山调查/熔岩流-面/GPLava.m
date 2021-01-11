//
//  GPLava.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPLava.h"

@interface GPLava ()
//岩石类型
@property (nonatomic, strong) YXSlectionDictModel *rocktypeModel;
//岩石时代
@property (nonatomic, strong) YXSlectionDictModel *ageModel;
@end

@implementation GPLava

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 1385;
    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXLavaModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXLavaModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXLavaModel *m = model;
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
    
    //熔岩流名称
    [self.textFields textFieldForTag:3].text = m.name;
    //熔岩流表面形态
    [self.textFields textFieldForTag:4].text = m.surfacemorphology;
    //熔岩流结构分带
    [self.textFields textFieldForTag:5].text = m.structurezone;
    //熔岩流单元划分
    [self.textFields textFieldForTag:6].text = m.unit;
    //熔岩流描述
    [self.textFields textFieldForTag:7].text = m.desc;
    //岩石类型
    [self.labels labelForTag:0].text = m.rocktypeName;
    if (m.rocktypeName.length) {
        self.rocktypeModel = [YXSlectionDictModel new];
        self.rocktypeModel.dictItemName = m.rocktypeName;
        self.rocktypeModel.dictItemCode = m.rocktype;
    }
    //岩石名称
    [self.textFields textFieldForTag:8].text = m.rockname;
    //岩性描述
    [self.textFields textFieldForTag:9].text = m.rockdescription;
    //照片文件编号
    [self.textFields textFieldForTag:10].text = m.photoAiid;
    //照片集镜向及拍摄者说明文档
    [self.textFields textFieldForTag:11].text = m.photodescArwid;
    //拍摄者
    [self.textFields textFieldForTag:12].text = m.photographer;
    //备注
    [self.textFields textFieldForTag:13].text = m.remark;
    //熔岩流符号代码
    [self.textFields textFieldForTag:14].text = m.type;
    //熔岩流规模
    [self.textFields textFieldForTag:15].text = m.scope;
    //熔岩流时代
    [self.labels labelForTag:1].text = m.ageName;
    if (m.ageName.length) {
        self.ageModel = [YXSlectionDictModel new];
        self.ageModel.dictItemName = m.ageName;
        self.ageModel.dictItemCode = m.ageName;
    }
}

//填充数据
- (id)buildBody
{
    YXLavaModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXLavaModel new];
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
    //熔岩流名称
    body.name = [[self.textFields textFieldForTag:3].text trim];
    //熔岩流表面形态
    body.surfacemorphology = [[self.textFields textFieldForTag:4].text trim];
    //熔岩流结构分带
    body.structurezone = [[self.textFields textFieldForTag:5].text trim];
    //熔岩流单元划分
    body.unit = [[self.textFields textFieldForTag:6].text trim];
    //熔岩流描述
    body.desc = [[self.textFields textFieldForTag:7].text trim];
    //岩石类型
    body.rocktype = self.rocktypeModel.dictItemCode;
    body.rocktypeName = self.rocktypeModel.dictItemName;
    //岩石名称
    body.rockname = [[self.textFields textFieldForTag:8].text trim];
    //岩性描述
    body.rockdescription = [[self.textFields textFieldForTag:9].text trim];
    //照片文件编号
    body.photoAiid = [[self.textFields textFieldForTag:10].text trim];
    //照片集镜向及拍摄者说明文档
    body.photodescArwid = [[self.textFields textFieldForTag:11].text trim];
    //拍摄者
    body.photographer = [[self.textFields textFieldForTag:12].text trim];
    //备注
    body.remark = [[self.textFields textFieldForTag:13].text trim];
    //熔岩流符号代码
    body.type = [[self.textFields textFieldForTag:14].text trim];
    //熔岩流规模
    body.scope = [[self.textFields textFieldForTag:15].text trim];
    //熔岩流时代
    body.age = self.ageModel.dictItemCode;
    body.ageName = self.ageModel.dictItemName;
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark 选择类

/// 岩石类型
- (IBAction)onYanShiLeiXing:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_Lava code:@"RockTypeCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:0].text = model.dictItemName;
                self.rocktypeModel = model;
            };
        }
    }];
}

/// 熔岩流时代
- (IBAction)onRongYanLiuShiDai:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_Lava code:@"AgeCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:1].text = model.dictItemName;
                self.ageModel = model;
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
                t.tableName = NSStringFromClass(YXLavaModel.class);
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
                    YXLavaModel *body = [self buildBody];
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
