//
//  GPGeoGeomorphySvyPoint.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPGeoGeomorphySvyPoint.h"

@interface GPGeoGeomorphySvyPoint ()
//形成时代
@property (nonatomic, strong) YXSlectionDictModel *createdateModel;
//地震地表破裂类型
@property (nonatomic, strong) YXSlectionDictModel *fracturetypeModel;
//照片镜像
@property (nonatomic, strong) YXSlectionDictModel *photoviewingtoModel;

@end

@implementation GPGeoGeomorphySvyPoint

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 1943;

    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXGeoGeomorphySvyPointModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXGeoGeomorphySvyPointModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXGeoGeomorphySvyPointModel *m = model;
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
    
    //地质调查观测点编号
    [self.textFields textFieldForTag:3].text = m.geologicalsvypointid;
    //观测点野外编号
    [self.textFields textFieldForTag:4].text = m.fieldid;
    //地貌代码
    [self.textFields textFieldForTag:5].text = m.geomorphycode;
    //地貌点名称
    [self.textFields textFieldForTag:6].text = m.geomorphyname;
    //地貌点类型
    [self.textFields textFieldForTag:7].text = m.geomorphytype;
    //垂直位移【米】
    [self.textFields textFieldForTag:8].text = m.verticaldisplacement;
    //走向水平位移 [米]
    [self.textFields textFieldForTag:9].text = m.horizenoffset;
    //地貌线走向（制图用）
    [self.textFields textFieldForTag:10].text = m.geomorphylndirection;
    //形成时代
    [self.labels labelForTag:0].text = m.createdate;
    //是否为已知地震的地表破裂
    [self.labels labelForTag:1].text = [m.issurfacerupturebelt boolValue] ? @"是" : @"否";
    //地震地表破裂类型
    [self.labels labelForTag:2].text = m.fracturetypeName;
    if (m.fracturetypeName.length) {
        self.fracturetypeModel = [YXSlectionDictModel new];
        self.fracturetypeModel.dictItemName = m.fracturetypeName;
        self.fracturetypeModel.dictItemCode = m.fracturetype;
    }
    //典型照片文件编号
    [self.textFields textFieldForTag:11].text = m.photoAiid;
    //照片镜像
    [self.labels labelForTag:3].text = m.photoviewingtoName;
    if (m.photoviewingtoName.length) {
        self.photoviewingtoModel = [YXSlectionDictModel new];
        self.photoviewingtoModel.dictItemName = m.photoviewingtoName;
        self.photoviewingtoModel.dictItemCode = m.photoviewingto;
    }
    //拍摄者
    [self.textFields textFieldForTag:12].text = m.photographer;
    //地表破裂（断塞塘等）长 [米]
    [self.textFields textFieldForTag:13].text = m.length;
    //地表破裂（断塞塘等）宽 [米]
    [self.textFields textFieldForTag:14].text = m.width;
    //地表破裂（断塞塘等）深 [米]
    [self.textFields textFieldForTag:15].text = m.height;
    //水平//张缩位移 [米]
    [self.textFields textFieldForTag:16].text = m.tensiondisplacement;
    //性质
    [self.textFields textFieldForTag:17].text = m.feature;
    //是否修改工作底图
    [self.labels labelForTag:4].text = [m.ismodifyworkmap boolValue] ? @"是" : @"否";
    //是否在图中显示
    [self.labels labelForTag:5].text = [m.isinmap boolValue] ? @"是" : @"否";
    //符号或标注旋转角度
    [self.textFields textFieldForTag:18].text = m.lastangle;
    //描述
    [self.textFields textFieldForTag:19].text = m.commentInfo;
}

//填充数据
- (id)buildBody
{
    YXGeoGeomorphySvyPointModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXGeoGeomorphySvyPointModel new];
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
    //地质调查观测点编号
    body.geologicalsvypointid = [[self.textFields textFieldForTag:3].text trim];
    //观测点野外编号
    body.fieldid = [[self.textFields textFieldForTag:4].text trim];
    //地貌代码
    body.geomorphycode = [[self.textFields textFieldForTag:5].text trim];
    //地貌点名称
    body.geomorphyname = [[self.textFields textFieldForTag:6].text trim];
    //地貌点类型
    body.geomorphytype = [[self.textFields textFieldForTag:7].text trim];
    //垂直位移【米】
    body.verticaldisplacement = [[self.textFields textFieldForTag:8].text trim];
    //走向水平位移 [米]
    body.horizenoffset = [[self.textFields textFieldForTag:9].text trim];
    //地貌线走向（制图用）
    body.geomorphylndirection = [[self.textFields textFieldForTag:10].text trim];
    //形成时代
    body.createdate = self.createdateModel.dictItemCode;
    body.createdateName = self.createdateModel.dictItemName;
    //是否为已知地震的地表破裂
    body.issurfacerupturebelt = [[self.labels labelForTag:1].text isEqualToString:@"是"] ? @"1" : @"0";
    //地震地表破裂类型
    body.fracturetype = self.fracturetypeModel.dictItemCode;
    body.fracturetypeName = self.fracturetypeModel.dictItemName;
    //典型照片文件编号
    body.photoAiid = [[self.textFields textFieldForTag:11].text trim];
    //照片镜像
    body.photoviewingto = self.photoviewingtoModel.dictItemCode;
    body.photoviewingtoName = self.photoviewingtoModel.dictItemName;
    //拍摄者
    body.photographer = [[self.textFields textFieldForTag:12].text trim];
    //地表破裂（断塞塘等）长 [米]
    body.length = [[self.textFields textFieldForTag:13].text trim];
    //地表破裂（断塞塘等）宽 [米]
    body.width = [[self.textFields textFieldForTag:14].text trim];
    //地表破裂（断塞塘等）深 [米]
    body.height = [[self.textFields textFieldForTag:15].text trim];
    //水平//张缩位移 [米]
    body.tensiondisplacement = [[self.textFields textFieldForTag:16].text trim];
    //性质
    body.feature = [[self.textFields textFieldForTag:17].text trim];
    //是否修改工作底图
    body.ismodifyworkmap = [[[self.labels labelForTag:4].text trim] isEqualToString:@"修改"] ? @"1" : @"0";
    //是否在图中显示
    body.isinmap = [[[self.labels labelForTag:5].text trim] isEqualToString:@"显示"] ? @"1" : @"0";
    //符号或标注旋转角度
    body.lastangle = [[self.textFields textFieldForTag:18].text trim];
    //描述
    body.commentInfo = [[self.textFields textFieldForTag:19].text trim];
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}

#pragma mark 疑问类

/// 地貌线走向（制图用）
- (IBAction)onDiMaoZouXiang:(UIButton *)b
{
    BDView *v = [UINib viewForNib:@"GPInfoView"];
    v.textViews.firstObject.text = @"最小值：0\n最大值：359";
    [self popView:v position:Position_Middle];
    v.onClickedButtonsCallback = ^(UIButton *btn) {
        [self.window dismissViewAnimated:YES completion:nil];
    };
}

#pragma mark 选择类

/// 形成时代
- (IBAction)onXingChengTime:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];
    [YXSlectionDictModel requestDictWithType:FormType_GeoGeomorphySvyPoint code:@"AgeCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:0].text = model.dictItemName;
                self.createdateModel = model;
            };
        }
    }];
}

/// 是否为已知地震的地表破裂
- (IBAction)onShiFouYiZhiDiZhenDiBiaoPoLie:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        //是否为已知地震的地表破裂
        [self.labels labelForTag:1].text = data;
    };
}

/// 地震地表破裂类型
- (IBAction)onDiZhenDiBiaoPoLieLeiXin:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_GeoGeomorphySvyPoint code:@"FracPtTypeCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:2].text = model.dictItemName;
                self.fracturetypeModel = model;
            };
        }
    }];
}


/// 镜头镜像
- (IBAction)onJingTouMirror:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_GeoGeomorphySvyPoint code:@"CVD-16-Direction" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:3].text = model.dictItemName;
                self.photoviewingtoModel = model;
            };
        }
    }];
}

/// 是否修改工作底图
- (IBAction)onModifyWorkDiTu:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"修改",@"不修改"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        //是否修改工作底图
        [self.labels labelForTag:4].text = data;
    };
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

- (IBAction)onSave:(UIButton *)b
{
    [self judgeBaseDataWhenFinished:^(BOOL pass) {
        if (pass) {
            //观测点野外编号
            if ([[self.textFields textFieldForTag:4].text trim].length == 0) {
                [BDToastView showText:@"观测点野外编号不能为空"];
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
                t.tableName = NSStringFromClass(YXGeoGeomorphySvyPointModel.class);
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
            //观测点野外编号
            if ([[self.textFields textFieldForTag:4].text trim].length == 0) {
                [BDToastView showText:@"观测点野外编号不能为空"];
                return;
            }
            
            [self alertText:@"数据提交成功后将不能修改，您是否确认提交？" sureTitle:@"提交" sureAction:^{
                [BDToastView showActivity:@"提交中..."];
                
                //submit
                void (^submitRequest)(NSString *imgUrls) = ^(NSString *imgUrls) {
                    YXGeoGeomorphySvyPointModel *body = [self buildBody];
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
