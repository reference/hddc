//
//  GPGeomorphySvySamplePoint.m
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPGeomorphySvySamplePoint.h"

@interface GPGeomorphySvySamplePoint ()

@end

@implementation GPGeomorphySvySamplePoint

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeaderHeight = 755;

    [self setupTitleLabels];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.interfaceStatus == InterfaceStatus_Show) {
        //禁用所有输入狂
        for (UITextField *tf in self.textFields) {
            tf.enabled = NO;
        }
        //禁用所有按钮
        for (UIButton *b in self.buttons) {
            b.enabled = NO;
        }
        //禁用textView
        for (UITextView *tv in self.textViews) {
            tv.editable = NO;
        }
        //隐藏右上角菜单保存按钮
        self.navigationItem.rightBarButtonItem = nil;
        
        //查询
        [self api_loadDetail];
    }
}

#pragma mark - api

- (void)api_loadDetail
{
    [BDToastView showActivity:@"加载中..."];
    [YXGeomorphySvySamplePointModel requestDetailWithUUID:self.forumListModel.uuid completion:^(YXGeomorphySvySamplePointModel * _Nonnull m, NSError * _Nonnull error) {
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
    YXGeomorphySvySamplePointModel *m = model;
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
    
    //高程【米】
    [self.textFields textFieldForTag:3].text = m.elevation;
    //采集样品总数
    [self.textFields textFieldForTag:4].text = m.collectedsamplecount;
    //备注
    [self.textFields textFieldForTag:5].text = m.commentInfo;
    //微地貌测量工程编号
    [self.textFields textFieldForTag:6].text = m.geomorphysvyprjid;
    //送样总数
    [self.textFields textFieldForTag:7].text = m.samplecount;
    //获得结果样品总数
    [self.textFields textFieldForTag:8].text = m.datingsamplecount;
}

//填充数据
- (id)buildBody
{
    YXGeomorphySvySamplePointModel *body = nil;
    if (self.interfaceStatus == InterfaceStatus_Edit) {
        body = [YXTable decodeDataInTable:self.table];;
    }else if (self.interfaceStatus == InterfaceStatus_New) {
        body = [YXGeomorphySvySamplePointModel new];
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
    //高程【米】
    body.elevation = [[self.textFields textFieldForTag:3].text trim];
    //采集样品总数
    body.collectedsamplecount = [[self.textFields textFieldForTag:4].text trim];
    //备注
    body.commentInfo = [[self.textFields textFieldForTag:5].text trim];
    //微地貌测量工程编号
    body.geomorphysvyprjid = [[self.textFields textFieldForTag:6].text trim];
    //送样总数
    body.samplecount = [[self.textFields textFieldForTag:7].text trim];
    //获得结果样品总数
    body.datingsamplecount = [[self.textFields textFieldForTag:8].text trim];
    
    //图片
    body.extends7 = [GPFormBaseController localPathsOfImageEntities:self.imageEntities];
    return body;
}
#pragma mark - action

- (IBAction)onSave:(UIButton *)b
{
    [self judgeBaseDataWhenFinished:^(BOOL pass) {
        if (pass) {
            //高程【米】
            if ([[self.textFields textFieldForTag:3].text trim].length == 0) {
                [BDToastView showText:@"高程不能为空"];
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
                t.tableName = NSStringFromClass(YXGeomorphySvySamplePointModel.class);
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
            //高程【米】
            if ([[self.textFields textFieldForTag:3].text trim].length == 0) {
                [BDToastView showText:@"高程不能为空"];
                return;
            }
            
            [self alertText:@"数据提交成功后将不能修改，您是否确认提交？" sureTitle:@"提交" sureAction:^{
                [BDToastView showActivity:@"提交中..."];
                //submit
                void (^submitRequest)(NSString *imgUrls) = ^(NSString *imgUrls) {
                    YXGeomorphySvySamplePointModel *body = [self buildBody];
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
