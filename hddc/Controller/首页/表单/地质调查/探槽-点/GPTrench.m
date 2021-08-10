//
//  GPTrench.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPTrench.h"

@interface GPTrench ()
//探槽来源于类型
@property (nonatomic, strong) YXSlectionDictModel *trenchsourceModel;
//照片镜向
@property (nonatomic, strong) YXSlectionDictModel *photoviewingtoModel;
@property (nonatomic, strong) YXSlectionDictModel *photoviewingtoNameModel;
//目标断层来源
@property (nonatomic, strong) YXSlectionDictModel *targetfaultsourceModel;
@end

@implementation GPTrench

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 2085;

    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXTrenchModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXTrenchModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXTrenchModel *m = model;
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
    
    //野外编号
    [self.textFields textFieldForTag:3].text = m.fieldid;
    //目标断层名称
    [self.textFields textFieldForTag:4].text = m.targetfaultname;
    //探槽名称
    [self.textFields textFieldForTag:5].text = m.name;
    //探槽来源与类型
    [self.labels labelForTag:0].text = m.trenchsourceName;
    if (m.trenchsourceName.length) {
        self.trenchsourceModel = [YXSlectionDictModel new];
        self.trenchsourceModel.dictItemName = m.trenchsourceName;
        self.trenchsourceModel.dictItemCode = m.trenchsource;
    }
    //高程 [米]
    [self.textFields textFieldForTag:6].text = m.elevation;
    //探槽方向角度 [度]
    [self.textFields textFieldForTag:7].text = m.trenchdip;
    //参考位置
    [self.textFields textFieldForTag:8].text = m.locationname;
    //环境照片图像编号
    [self.textFields textFieldForTag:9].text = m.photoAiid;
    //照片镜向
    [self.labels labelForTag:1].text = m.photoviewingtoName;
    if (m.photoviewingtoName.length) {
        self.photoviewingtoModel = [YXSlectionDictModel new];
        self.photoviewingtoModel.dictItemName = m.photoviewingtoName;
        self.photoviewingtoModel.dictItemCode = m.photoviewingto;
    }
    //拍摄者
    [self.textFields textFieldForTag:10].text = m.photographer;
    //探槽长 [米]
    [self.textFields textFieldForTag:11].text = m.length;
    //探槽宽 [米]
    [self.textFields textFieldForTag:12].text = m.width;
    //探槽深 [米]
    [self.textFields textFieldForTag:13].text = m.depth;
    //揭露地层数
    [self.textFields textFieldForTag:14].text = m.exposedstratumcount;
    //古地震事件次数
    [self.textFields textFieldForTag:15].text = m.eqeventcount;
    //采集样品总数
    [self.textFields textFieldForTag:16].text = m.collectedsamplecount;
    //所属地质调查工程编号
    [self.textFields textFieldForTag:17].text = m.geologysvyprojectid;
    //目标断层编号
    [self.textFields textFieldForTag:18].text = m.targetfaultid;
    //目标断层来源
    [self.labels labelForTag:2].text = m.targetfaultsourceName;
    if (m.targetfaultsourceName.length) {
        self.targetfaultsourceModel = [YXSlectionDictModel new];
        self.targetfaultsourceModel.dictItemName = m.targetfaultsourceName;
        self.targetfaultsourceModel.dictItemCode = m.targetfaultsource;
    }
    //收集探槽来源补充说明
    [self.textFields textFieldForTag:19].text = m.collectedtrenchsource;
    //地貌环境
    [self.textFields textFieldForTag:20].text = m.geomophenv;
    //最晚古地震发震时代
    [self.textFields textFieldForTag:21].text = m.latesteqperoidest;
    //最晚古地震发震时代误差
    [self.textFields textFieldForTag:22].text = m.latesteqperoider;
    //送样总数
    [self.textFields textFieldForTag:23].text = m.samplecount;
    //获得结果的样品数
    [self.textFields textFieldForTag:24].text = m.datingsamplecount;
    //符号或标注旋转角度
    [self.textFields textFieldForTag:25].text = m.lastangle;
    //探槽描述
    [self.textFields textFieldForTag:26].text = m.commentInfo;
}

//填充数据
- (id)buildBody
{
    YXTrenchModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXTrenchModel new];
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
    
    //探槽编号
    body.id = [[self.textFields textFieldForTag:2].text trim];
    //野外编号
    body.fieldid = [[self.textFields textFieldForTag:3].text trim];
    //目标断层名称
    body.targetfaultname = [[self.textFields textFieldForTag:4].text trim];
    //探槽名称
    body.name = [[self.textFields textFieldForTag:5].text trim];
    //探槽来源与类型
    body.trenchsource = self.trenchsourceModel.dictItemCode;
    body.trenchsourceName = self.trenchsourceModel.dictItemName;
    //高程 [米]
    body.elevation = [[self.textFields textFieldForTag:6].text trim];
    //探槽方向角度 [度]
    body.trenchdip = [[self.textFields textFieldForTag:7].text trim];
    //参考位置
    body.locationname = [[self.textFields textFieldForTag:8].text trim];
    //环境照片图像编号
    body.photoAiid = [[self.textFields textFieldForTag:9].text trim];
    //照片镜向
    body.photoviewingto = self.photoviewingtoModel.dictItemCode;
    body.photoviewingtoName = self.photoviewingtoModel.dictItemName;

    //拍摄者
    body.photographer = [[self.textFields textFieldForTag:10].text trim];
    //探槽长 [米]
    body.length = [[self.textFields textFieldForTag:11].text trim];
    //探槽宽 [米]
    body.width = [[self.textFields textFieldForTag:12].text trim];
    //探槽深 [米]
    body.depth = [[self.textFields textFieldForTag:13].text trim];
    //揭露地层数
    body.exposedstratumcount = [[self.textFields textFieldForTag:14].text trim];
    //古地震事件次数
    body.eqeventcount = [[self.textFields textFieldForTag:15].text trim];
    //采集样品总数
    body.collectedsamplecount = [[self.textFields textFieldForTag:16].text trim];
    //所属地质调查工程编号
    body.geologysvyprojectid = [[self.textFields textFieldForTag:17].text trim];
    //目标断层编号
    body.targetfaultid = [[self.textFields textFieldForTag:18].text trim];
    //目标断层来源
    body.targetfaultsource = self.targetfaultsourceModel.dictItemCode;
    body.targetfaultsourceName = self.targetfaultsourceModel.dictItemName;
    //收集探槽来源补充说明
    body.collectedtrenchsource = [[self.textFields textFieldForTag:19].text trim];
    //地貌环境
    body.geomophenv = [[self.textFields textFieldForTag:20].text trim];
    //最晚古地震发震时代
    body.latesteqperoidest = [[self.textFields textFieldForTag:21].text trim];
    //最晚古地震发震时代误差
    body.latesteqperoider = [[self.textFields textFieldForTag:22].text trim];
    //送样总数
    body.samplecount = [[self.textFields textFieldForTag:23].text trim];
    //获得结果的样品数
    body.datingsamplecount = [[self.textFields textFieldForTag:24].text trim];
    //符号或标注旋转角度
    body.lastangle = [[self.textFields textFieldForTag:25].text trim];
    //探槽描述
    body.commentInfo = [[self.textFields textFieldForTag:26].text trim];
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark 疑问类

/// 探槽方向角度 [度]
- (IBAction)onTanCaoFangXiangJiaoDu:(UIButton *)b
{
    BDView *v = [UINib viewForNib:@"GPInfoView"];
    v.textViews.firstObject.text = @"最小值：0\n最大值：359";
    [self popView:v position:Position_Middle];
    v.onClickedButtonsCallback = ^(UIButton *btn) {
        [self.window dismissViewAnimated:YES completion:nil];
    };
}

#pragma mark 选择类

/// 探槽来源与类型
- (IBAction)onTanCaoLaiYuanYuLeiXing:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_Trench code:@"TrenchTypeCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:0].text = model.dictItemName;
                self.trenchsourceModel = model;
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
    [YXSlectionDictModel requestDictWithType:FormType_Trench code:@"CVD-16-Direction" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:1].text = model.dictItemName;
                self.photoviewingtoModel = model;
            };
        }
    }];
}

/// 目标断层来源
- (IBAction)onMuBiaoDuanCengLaiYuan:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_Trench code:@"FaultSourceCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:2].text = model.dictItemName;
                self.targetfaultsourceModel = model;
            };
        }
    }];
}

- (IBAction)onSave:(UIButton *)b
{
    [self judgeBaseDataWhenFinished:^(BOOL pass) {
        if (pass) {
            //探槽名称
            if ([[self.textFields textFieldForTag:5].text trim].length == 0) {
                [BDToastView showText:@"探槽名称不能为空"];
                return;
            }
            //高程 米
            if ([[self.textFields textFieldForTag:6].text trim].length == 0) {
                [BDToastView showText:@"高程不能为空"];
                return;
            }
            //探槽方向角度
            if ([[self.textFields textFieldForTag:7].text trim].length == 0) {
                [BDToastView showText:@"探槽方向角度不能为空"];
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
                t.tableName = NSStringFromClass(YXTrenchModel.class);
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
            //探槽名称
            if ([[self.textFields textFieldForTag:5].text trim].length == 0) {
                [BDToastView showText:@"探槽名称不能为空"];
                return;
            }
            //高程 米
            if ([[self.textFields textFieldForTag:6].text trim].length == 0) {
                [BDToastView showText:@"高程不能为空"];
                return;
            }
            //探槽方向角度
            if ([[self.textFields textFieldForTag:7].text trim].length == 0) {
                [BDToastView showText:@"探槽方向角度不能为空"];
                return;
            }
            
            [self alertText:@"数据提交成功后将不能修改，您是否确认提交？" sureTitle:@"提交" sureAction:^{
                [BDToastView showActivity:@"提交中..."];
                //submit
                void (^submitRequest)(NSString *imgUrls) = ^(NSString *imgUrls) {
                    YXTrenchModel *body = [self buildBody];
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
