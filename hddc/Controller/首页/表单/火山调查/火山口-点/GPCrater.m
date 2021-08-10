//
//  GPCrater.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPCrater.h"

@interface GPCrater ()
//溢出口方向
@property (nonatomic, strong) YXSlectionDictModel *overfalldirectionModel;
@end

@implementation GPCrater

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 2018;
    [self setupTitleLabels];
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXCraterModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXCraterModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXCraterModel *m = model;
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
    
    //锥体名称
    [self.textFields textFieldForTag:3].text = m.conename;
    //锥体类型
    [self.textFields textFieldForTag:4].text = m.conetype;
    //锥体形态
    [self.textFields textFieldForTag:5].text = m.conemorphology;
    
    //锥体高度[米]
    [self.textFields textFieldForTag:6].text = m.coneheight;
    //火口深度[米]
    [self.textFields textFieldForTag:7].text = m.craterdepth;
    //内坡度
    [self.textFields textFieldForTag:8].text = m.insideslopeangle;
    //外坡度
    [self.textFields textFieldForTag:9].text = m.outsideslopeangle;
    //溢出口方向
    [self.labels labelForTag:0].text = m.overfalldirectionName;
    if (m.overfalldirectionName.length) {
        self.overfalldirectionModel = [YXSlectionDictModel new];
        self.overfalldirectionModel.dictItemName = m.overfalldirectionName;
        self.overfalldirectionModel.dictItemCode = m.overfalldirection;
    }
    //堆积物类型
    [self.textFields textFieldForTag:10].text = m.deposittype;
    //堆积物粒度
    [self.textFields textFieldForTag:11].text = m.depositgranularity;
    //塑性熔岩饼单体尺寸
    [self.textFields textFieldForTag:12].text = m.lavadribletsize;
    //岩石包体类型
    [self.textFields textFieldForTag:13].text = m.rockinclusiontype;
    //岩石包体数量
    [self.textFields textFieldForTag:14].text = m.rockinclusionnum;
    //岩石包体粒度
    [self.textFields textFieldForTag:15].text = m.rockinclusiongranularity;
    //岩石包体形状
    [self.textFields textFieldForTag:16].text = m.rockinclusionshape;
    //岩石包体产出状态
    [self.textFields textFieldForTag:17].text = m.rockinclusionoutputstate;
    //照片文件编号
    [self.textFields textFieldForTag:18].text = m.photoAiid;
    //照片集镜向及拍摄者说明文档
    [self.textFields textFieldForTag:19].text = m.photodescArwid;
    //拍摄者
    [self.textFields textFieldForTag:20].text = m.photographer;
    //commentInfo
    [self.textFields textFieldForTag:21].text = m.commentInfo;
    //锥体底部直径
    [self.textFields textFieldForTag:22].text = m.bottomdiameter;
    //火口垣直径
    [self.textFields textFieldForTag:23].text = m.craterwallsdiameter;
    //火口直径
    [self.textFields textFieldForTag:24].text = m.craterdiameter;
    //depositthickness
    [self.textFields textFieldForTag:25].text = m.depositthickness;
}

//填充数据
- (id)buildBody
{
    YXCraterModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXCraterModel new];
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
    //锥体名称
    body.conename = [[self.textFields textFieldForTag:3].text trim];
    //锥体类型
    body.conetype = [[self.textFields textFieldForTag:4].text trim];
    //锥体形态
    body.conemorphology = [[self.textFields textFieldForTag:5].text trim];
    
    //锥体高度[米]
    body.coneheight = [[self.textFields textFieldForTag:6].text trim];
    //火口深度[米]
    body.craterdepth = [[self.textFields textFieldForTag:7].text trim];
    //内坡度
    body.insideslopeangle = [[self.textFields textFieldForTag:8].text trim];
    //外坡度
    body.outsideslopeangle = [[self.textFields textFieldForTag:9].text trim];
    //溢出口方向
    body.overfalldirection = self.overfalldirectionModel.dictItemCode;
    body.overfalldirectionName = self.overfalldirectionModel.dictItemName;
    //堆积物类型
    body.deposittype = [[self.textFields textFieldForTag:10].text trim];
    //堆积物粒度
    body.depositgranularity = [[self.textFields textFieldForTag:11].text trim];
    //塑性熔岩饼单体尺寸
    body.lavadribletsize = [[self.textFields textFieldForTag:12].text trim];
    //岩石包体类型
    body.rockinclusiontype = [[self.textFields textFieldForTag:13].text trim];
    //岩石包体数量
    body.rockinclusionnum = [[self.textFields textFieldForTag:14].text trim];
    //岩石包体粒度
    body.rockinclusiongranularity = [[self.textFields textFieldForTag:15].text trim];
    //岩石包体形状
    body.rockinclusionshape = [[self.textFields textFieldForTag:16].text trim];
    //岩石包体产出状态
    body.rockinclusionoutputstate = [[self.textFields textFieldForTag:17].text trim];
    //照片文件编号
    body.photoAiid = [[self.textFields textFieldForTag:18].text trim];
    //照片集镜向及拍摄者说明文档
    body.photodescArwid = [[self.textFields textFieldForTag:19].text trim];
    //拍摄者
    body.photographer = [[self.textFields textFieldForTag:20].text trim];
    //commentInfo
    body.commentInfo = [[self.textFields textFieldForTag:21].text trim];
    //锥体底部直径
    body.bottomdiameter = [[self.textFields textFieldForTag:22].text trim];
    //火口垣直径
    body.craterwallsdiameter = [[self.textFields textFieldForTag:23].text trim];
    //火口直径
    body.craterdiameter = [[self.textFields textFieldForTag:24].text trim];
    //depositthickness
    body.depositthickness = [[self.textFields textFieldForTag:25].text trim];
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark 选择类

/// 溢出口方向
- (IBAction)onYiChuKouFangXiang:(UIButton *)b
{
    if (self.interfaceStatus == InterfaceStatus_Show) {
        return;
    }
    [BDToastView showActivity:nil];;
    [YXSlectionDictModel requestDictWithType:FormType_Crater code:@"CVD-16-Direction" completion:^(NSArray <YXSlectionDictModel *> * _Nonnull ms, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView dismiss];
            //
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:ms];
            selector.onDone = ^(YXSlectionDictModel * _Nonnull model) {
                [self.labels labelForTag:0].text = model.dictItemName;
                self.overfalldirectionModel = model;
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
                t.tableName = NSStringFromClass(YXCraterModel.class);
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
                    YXCraterModel *body = [self buildBody];
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
