//
//  GPDrillHole.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPDrillHole.h"

@interface GPDrillHole ()
//钻探日期
@property (nonatomic, strong) NSString *drilldate;

//钻孔来源与类型
@property (nonatomic, strong) YXSlectionDictModel *drillsourceModel;

@end

@implementation GPDrillHole

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 2155;

    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXDrillHoleModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXDrillHoleModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXDrillHoleModel *m = model;
    //显示省
    self.provinceLabel.text = m.province;
    //显示市
    self.cityLabel.text = m.city;
    //显示区
    self.zoneLabel.text = m.area;
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
    //钻探目的
    [self.textFields textFieldForTag:4].text = m.purpose;
    //钻探日期
    [self.labels labelForTag:0].text = m.drilldate;
    //钻探地点
    [self.textFields textFieldForTag:5].text = m.locationname;
    //钻孔来源与类型
    [self.labels labelForTag:1].text = m.drillsourceName;
    if (m.drillsourceName.length) {
        self.drillsourceModel = [YXSlectionDictModel new];
        self.drillsourceModel.dictItemName = m.drillsourceName;
        self.drillsourceModel.dictItemCode = m.drillsource;
    }

    //孔口标高 [米]
    [self.textFields textFieldForTag:8].text = m.elevation;
    
    //孔深 [米]
    [self.textFields textFieldForTag:9].text = m.depth;
    //岩芯总长 [米]
    [self.textFields textFieldForTag:10].text = m.coretotalthickness;
    //采集样品总数
    [self.textFields textFieldForTag:11].text = m.collectedsamplecount;
    //工程编号
    [self.textFields textFieldForTag:12].text = m.projectid;
    //钻孔剖面编号
    [self.textFields textFieldForTag:13].text = m.profileid;
    //全新统厚度 [米]
    [self.textFields textFieldForTag:14].text = m.holocenethickness;
    //上更新统厚度 [米]
    [self.textFields textFieldForTag:15].text = m.uppleithickness;
    //中更新统厚度 [米]
    [self.textFields textFieldForTag:16].text = m.midpleithickness;
    //下更新统厚度 [米]
    [self.textFields textFieldForTag:17].text = m.lowpleithickness;
    //前第四纪厚度 [米]
    [self.textFields textFieldForTag:18].text = m.prepleithickness;
    //送样总数
    [self.textFields textFieldForTag:19].text = m.samplecount;
    //获得结果样品总数
    [self.textFields textFieldForTag:20].text = m.datingsamplecount;
    //是否开展地球物理测井
    [self.labels labelForTag:2].text = [m.isgeophywell boolValue] ? @"是" : @"否";

    //采集环境与工程样品数
    [self.textFields textFieldForTag:21].text = m.collectedenviromentsamplecount;
    //环境与工程样品送样总数
    [self.textFields textFieldForTag:22].text = m.enviromentsamplecount;
    //获得测试结果的环境与工程样品数
    [self.textFields textFieldForTag:23].text = m.testedenviromentsamplecount;
    //钻孔柱状图图像文件编号
    [self.textFields textFieldForTag:24].text = m.columnchartAiid;
    
    //钻孔柱状图原始档案编号
    [self.textFields textFieldForTag:25].text = m.columnchartArwid;
    //岩芯照片原始档案编号
    [self.textFields textFieldForTag:26].text = m.corephotoArwid;
    //备注
    [self.textFields textFieldForTag:27].text = m.remark;
}

//填充数据
- (id)buildBody
{
    YXDrillHoleModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXDrillHoleModel new];
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
    //钻探目的
    body.purpose = [[self.textFields textFieldForTag:4].text trim];
    //钻探日期
    body.drilldate = self.drilldate;
    //钻探地点
    body.locationname = [[self.textFields textFieldForTag:5].text trim];
    //钻孔来源与类型
    body.drillsource = self.drillsourceModel.dictItemCode;
    body.drillsourceName = self.drillsourceModel.dictItemName;
    //孔口标高 [米]
    body.elevation = [[self.textFields textFieldForTag:8].text trim];
    
    //孔深 [米]
    body.depth = [[self.textFields textFieldForTag:9].text trim];
    //岩芯总长 [米]
    body.coretotalthickness = [[self.textFields textFieldForTag:10].text trim];
    //采集样品总数
    body.collectedsamplecount = [[self.textFields textFieldForTag:11].text trim];
    //工程编号
    body.projectid = [[self.textFields textFieldForTag:12].text trim];
    //钻孔剖面编号
    body.profileid = [[self.textFields textFieldForTag:13].text trim];
    //全新统厚度 [米]
    body.holocenethickness = [[self.textFields textFieldForTag:14].text trim];
    //上更新统厚度 [米]
    body.uppleithickness = [[self.textFields textFieldForTag:15].text trim];
    //中更新统厚度 [米]
    body.midpleithickness = [[self.textFields textFieldForTag:16].text trim];
    //下更新统厚度 [米]
    body.lowpleithickness = [[self.textFields textFieldForTag:17].text trim];
    //前第四纪厚度 [米]
    body.prepleithickness = [[self.textFields textFieldForTag:18].text trim];
    //送样总数
    body.samplecount = [[self.textFields textFieldForTag:19].text trim];
    //获得结果样品总数
    body.datingsamplecount = [[self.textFields textFieldForTag:20].text trim];
    //是否开展地球物理测井
    body.isgeophywell = [[[self.labels labelForTag:2].text trim] isEqualToString:@"是"] ? @"1" : @"0";
    //采集环境与工程样品数
    body.collectedenviromentsamplecount = [[self.textFields textFieldForTag:21].text trim];
    //环境与工程样品送样总数
    body.enviromentsamplecount = [[self.textFields textFieldForTag:22].text trim];
    //获得测试结果的环境与工程样品数
    body.testedenviromentsamplecount = [[self.textFields textFieldForTag:23].text trim];
    //钻孔柱状图图像文件编号
    body.columnchartAiid = [[self.textFields textFieldForTag:24].text trim];
    
    //钻孔柱状图原始档案编号
    body.columnchartArwid = [[self.textFields textFieldForTag:25].text trim];
    //岩芯照片原始档案编号
    body.corephotoArwid = [[self.textFields textFieldForTag:26].text trim];
    //备注
    body.remark = [[self.textFields textFieldForTag:27].text trim];
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark 选择类
/// 钻探日期
- (IBAction)onZhuanTanRiQi:(UIButton *)b
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
            self.drilldate = [date dateString];
        }];
    };
}

/// 转孔来源与类型
- (IBAction)onZhuanKongLaiYuanYuLeiXing:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_DrillHole code:@"DrillTypeCVD" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:1].text = model.dictItemName;
                self.drillsourceModel = model;
            };
        }
    }];
}

/// 是否开展地球物理测井
- (IBAction)onShiFouKaiZhanDiQiuWuLiCeJing:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:@[@"是",@"否"]];
    selector.onDone = ^(NSString * _Nonnull data) {
        [self.labels labelForTag:2].text = data;
    };
}

#pragma mark - action

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
                t.tableName = NSStringFromClass(YXDrillHoleModel.class);
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
                    YXDrillHoleModel *body = [self buildBody];
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
