//
//  GPOfflineForumListController.m
//  BDGuPiao
//
//  Created by admin on 2020/12/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPOfflineForumListController.h"
#import "GPTaskMapController.h"
#import "BDSelectionModel.h"
#import "GPProjectZhiPaiPicker.h"
#import "YXTrace.h"
#import "GPGuijiTraceMapController.h"
#import "GPTraceZhiPaiPicker.h"
#import "GPMultiForumUploader.h"
#import "GPMultiTracePointsUploader.h"

typedef enum {
    EditMode_Off = 0,
    EditMode_On
}EditMode;

typedef enum {
    DataType_Forum = 0,//表单
    DataType_Trace //轨迹采集
}DataType;

@interface GPOfflineForumListController ()
@property (nonatomic, strong) NSDictionary *typeDic;
@property (nonatomic, assign) NSInteger curType;
//
@property (nonatomic, strong) YXProject *projectModel;
@property (nonatomic, strong) YXTaskModel *taskModel;

@property (nonatomic, strong) NSMutableArray *selectedItems;
@property (nonatomic, assign) EditMode editMode;
@property (nonatomic, assign) DataType dataType;

//bottom tool bar
@property (nonatomic, strong) IBOutlet BDView *bottomForumToolBar;
@property (nonatomic, strong) IBOutlet BDView *bottomTraceToolBar; //轨迹追踪
@end

@implementation GPOfflineForumListController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.selectedItems = [NSMutableArray array];
    //
    _editMode = 0;
    //
    _dataType = DataType_Forum;
    
    //
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dixingType" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:path];
    self.typeDic = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingAllowFragments
                                                      error:nil];
    //初始化
    self.curType = 1;
    [self.labels labelForTag:0].text = [self.typeDic allKeys].firstObject;
    NSString *key = [self.labels labelForTag:0].text;
    NSArray *arr = self.typeDic[key];
    [self.labels labelForTag:1].text = arr.firstObject[@"name"];
    
    //
    @weakify(self)
    [self.tableViews.firstObject setHeaderWithRefreshingBlock:^{
        @strongify(self)
        [self loadData:YES];
    }];
    
    //设置底部工具栏点击事件
    self.bottomForumToolBar.onClickedButtonsCallback = ^(UIButton *btn) {
        if (btn.tag == 0) {
            //关联任务
            GPProjectZhiPaiPicker *picker = [UINib viewForNib:NSStringFromClass(GPProjectZhiPaiPicker.class)];
            picker.onCancel = ^{
                [self.window dismissViewAnimated:YES completion:nil];
            };
            //判断是否有选项
            if (![self hasSelectedItem]) {
                [BDToastView showText:@"没有可关联的选项"];
                return;
            }
            
            //保存本地
            picker.onSaveLocal = ^(YXProject * _Nonnull project, YXTaskModel * _Nonnull task) {
                [self.window dismissViewAnimated:YES completion:^{
                    //批量修改
                    [BDToastView showActivity:@"保存中..."];
                    for (BDSelectionModel *m in self.dataArray) {
                        if (m.isSelected) {
                            YXTable *tb = m.data;
                            tb.projectId = project.projectId;
                            tb.taskId = task.taskId;
                            [tb bg_coverAsync:^(BOOL isSuccess) {
                                if (isSuccess) {
                                    NSLog(@"指派成功");
                                }
                            }];
                        }
                    }
                    //延时处理 避免数据库冲突
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        //show alert
                        [BDToastView showText:@"任务已关联完成"];
                        
                        //重新加载内容
                        [self.tableViews.firstObject.mj_header beginRefreshing];
                    });
                }];
            };
            
            //提交远程
            picker.onSubmit = ^(YXProject * _Nonnull project, YXTaskModel * _Nonnull task) {
                [self.window dismissViewAnimated:YES completion:^{
                    GPMultiForumUploader *uploader = [GPMultiForumUploader new];
                    uploader.task = task;
                    uploader.project = project;
                    //获得已选择的表单
                    NSMutableArray *tables = [NSMutableArray array];
                    for (BDSelectionModel *m in self.dataArray) {
                        if (m.isSelected) {
                            [tables addObject:m.data];
                        }
                    }
                    uploader.tables = tables;
                    //callback
                    uploader.didStart = ^{
                        [BDToastView showActivity:@"提交中，请稍等..."];
                    };
                    uploader.didSuccess = ^{
                        [BDToastView showText:@"提交成功"];
                        [self.tableViews.firstObject.mj_header beginRefreshing];
                    };
                    uploader.didError = ^(NSError * _Nonnull error) {
                        [BDToastView showText:error.localizedDescription];
                        [self.tableViews.firstObject.mj_header beginRefreshing];
                    };
                    [uploader startUpload];
                }];
            };
            [self popView:picker position:Position_Middle];
        }else{
            //批量删除
            
            //判断是否有选项
            if (![self hasSelectedItem]) {
                [BDToastView showText:@"没有可删除的选项"];
                return;
            }
            //
            [self alertText:@"删除后数据将无法恢复，您确定要删除么？" sureTitle:@"确定" sureAction:^{
                //批量修改
                [BDToastView showActivity:@"删除中..."];
                for (BDSelectionModel *m in self.dataArray) {
                    YXTable *tb = m.data;
                    if (m.isSelected) {
                        [YXTable deleteRowById:tb.rowid];
                    }
                }
                //延时处理 避免数据库冲突
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //show alert
                    [BDToastView showText:@"删除成功"];
                    
                    //重新加载内容
                    [self.tableViews.firstObject.mj_header beginRefreshing];
                });
            }];
        }
    };
    
    //设置轨迹追踪
    self.bottomTraceToolBar.onClickedButtonsCallback = ^(UIButton *btn) {
        if (btn.tag == 0) {
            //批量上传
            GPTraceZhiPaiPicker *picker = [UINib viewForNib:NSStringFromClass(GPTraceZhiPaiPicker.class)];
            picker.onCancel = ^{
                [self.window dismissViewAnimated:YES completion:nil];
            };
            //判断是否有选项
            if (![self hasSelectedItem]) {
                [BDToastView showText:@"没有可上传的选项"];
                return;
            }
            
            //提交远程
            picker.onSubmit = ^(YXProject * _Nonnull project, YXTaskModel * _Nonnull task) {
                [self.window dismissViewAnimated:YES completion:^{
                    GPMultiTracePointsUploader *uploader = [GPMultiTracePointsUploader new];
                    uploader.taskId = task.taskId;
                    //获得已选择的表单
                    NSMutableArray *traces = [NSMutableArray array];
                    for (BDSelectionModel *m in self.dataArray) {
                        if (m.isSelected) {
                            [traces addObject:m.data];
                        }
                    }
                    uploader.traces = traces;
                    //callback
                    uploader.didStart = ^{
                        [BDToastView showActivity:@"提交中，请稍等..."];
                    };
                    uploader.didSuccess = ^{
                        [BDToastView showText:@"提交成功"];
                        [self.tableViews.firstObject.mj_header beginRefreshing];
                    };
                    uploader.didError = ^(NSError * _Nonnull error) {
                        [BDToastView showText:error.localizedDescription];
                        [self.tableViews.firstObject.mj_header beginRefreshing];
                    };
                    [uploader startUpload];
                }];
            };
            [self popView:picker position:Position_Middle];
        }else{
            //批量删除
            
            //判断是否有选项
            if (![self hasSelectedItem]) {
                [BDToastView showText:@"没有可删除的选项"];
                return;
            }
            //
            [self alertText:@"删除后数据将无法恢复，您确定要删除么？" sureTitle:@"确定" sureAction:^{
                //批量修改
                [BDToastView showActivity:@"删除中..."];
                for (BDSelectionModel *m in self.dataArray) {
                    YXTrace *tb = m.data;
                    if (m.isSelected) {
                        [YXTrace deleteRowById:tb.rowid];
                    }
                }
                //延时处理 避免数据库冲突
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //show alert
                    [BDToastView showText:@"删除成功"];
                    
                    //重新加载内容
                    [self.tableViews.firstObject.mj_header beginRefreshing];
                });
            }];
        }
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButtonBlack];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tableViews.firstObject.mj_header beginRefreshing];
}

- (void)loadData:(BOOL)reload
{
    if (reload) {
        [self.dataArray removeAllObjects];
    }
    static NSInteger page = 1;
    page = reload ? 1 : page + 1;
    
    //本地数据
    //查询
    NSString *userId = [YXUserModel currentUser].userId;
    //从数据库中查找
    NSArray* tables = nil;
    
    //get data from db
    if (_dataType == DataType_Forum) {
        tables = [YXTable findTablesWithoutBelongByUserId:userId forumType:self.curType];
        for (YXTable *table in tables) {
            BDSelectionModel *m = [BDSelectionModel new];
            m.data = table;
            m.isSelected = NO;
            [self.dataArray addObject:m];
        }
    }
    else{
        //from trace point
        tables = [YXTrace findTraceWithoutBelongByUserId:userId];
        for (YXTrace *table in tables) {
            BDSelectionModel *m = [BDSelectionModel new];
            m.data = table;
            m.isSelected = NO;
            [self.dataArray addObject:m];
        }
    }
    
    //
    [self.tableViews.firstObject reloadData];
    @weakify(self)
    [self.tableViews.firstObject setFooterWithRefreshingBlock:^{
        @strongify(self)
        [self loadData:NO];
    }];
    [self.tableViews.firstObject endRefreshing:YES];
}

- (void)setEditMode:(EditMode)editMode
{
    _editMode = editMode;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self->_editMode == EditMode_On) {
            //显示按钮
            self.tableViews.firstObject.bottomLayoutConstraint.constant = 0;
        }else{
            self.tableViews.firstObject.bottomLayoutConstraint.constant = -50;
        }
    }];
    //TODO:清除所有选择的项目
    
    //
    self.navigationItem.rightBarButtonItem.title = editMode == EditMode_On ? @"取消" : @"多选";
    [self.tableViews.firstObject reloadData];
}

- (void)setDataType:(DataType)dataType
{
    _dataType = dataType;
    
    //
    self.bottomTraceToolBar.hidden = dataType == DataType_Forum;
    self.bottomForumToolBar.hidden = dataType == DataType_Trace;
}

- (BOOL)hasSelectedItem
{
    BOOL has = NO;
    for (BDSelectionModel *m in self.dataArray) {
        if (m.isSelected) {
            has = YES;
            break;
        }
    }
    return has;
}
#pragma mark - action

- (IBAction)onButtons:(UIButton *)b
{
    //
    if (b.tag == 0) {
        //表单类型
        NSMutableArray *allKeys = [NSMutableArray arrayWithArray:[self.typeDic allKeys]];
        [allKeys addObject:@"轨迹采集"];
        GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:allKeys];
        selector.onDone = ^(NSString * _Nonnull key) {
            if ([key isEqualToString:@"轨迹采集"]) {
                [self.labels labelForTag:0].text = @"轨迹采集";
                [self.labels labelForTag:1].text = nil;

                //标记是否轨迹采集
                self.dataType = DataType_Trace;
                
                //reload
                [self.tableViews.firstObject.mj_header beginRefreshing];
            }
            else{
                //
                self.dataType = DataType_Forum;
                //
                [self.labels labelForTag:0].text = key;
                //
                NSArray *arr = self.typeDic[key];
                [self.labels labelForTag:1].text = arr.firstObject[@"name"];
                self.curType = [arr.firstObject[@"id"] intValue];
                
                //调接口
                [self.tableViews.firstObject.mj_header beginRefreshing];
            }
        };
    }else{
        //表单
        NSArray *arr = self.typeDic[[self.labels labelForTag:0].text];
        if (arr != nil) {
            //表单
            GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:arr];
            selector.onDone = ^(NSDictionary * _Nonnull dic) {
                [self.labels labelForTag:1].text = dic[@"name"];
                self.curType = [dic[@"id"] intValue];
                //调接口
                [self.tableViews.firstObject.mj_header beginRefreshing];
            };
        }
    }
}

//多选
- (IBAction)onMultiSelect:(UIButton *)b
{
    self.editMode = !self.editMode;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDTableViewCell *cell = nil;
    //get model entity
    BDSelectionModel *entity = self.dataArray[indexPath.row];
    
    //data type
    if (_dataType == DataType_Forum) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"forum"];
        
        //是否选择
        [cell.buttons buttonForTag:0].selected = entity.isSelected;
        
        //table name
        NSString *tableName = [YXTable tableNameOfType:self.curType];
        //get table
        YXTable *table = entity.data;
        //get class
        Class cls = NSClassFromString(tableName);
        //decode data
        NSDictionary *decodedData = [NSJSONSerialization JSONObjectWithData:[table.encodedData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];;
        //使用一个模型代替所有，每个模型都不会被强转
        YXGeologicalSvyPlanningLineModel *model = [cls yy_modelWithDictionary:decodedData];
        
        cell.labels.firstObject.text = model.id;
        cell.onClickedButtons = ^(NSInteger tag) {
            //编辑表单
            
            [GPForumJumper jumpToForumWithType:[NSString stringWithFormat:@"%li",self.curType]
                            fromViewController:self
                                     taskModel:self.taskModel
                                  projectModel:self.projectModel
                                         point:nil
                                      province:nil
                                          city:nil
                                          zone:nil
                                       address:nil
                                 isOffLineMode:NO
                               interfaceStatus:InterfaceStatus_Edit
                                         forum:model
                                         table:table];
        };
    }
    else {
        //trace points
        cell = [tableView dequeueReusableCellWithIdentifier:@"trace"];
        
        //是否选择
        [cell.buttons buttonForTag:0].selected = entity.isSelected;
        
        //get table
        YXTrace *table = entity.data;
        
        cell.labels.firstObject.text = [table.createDate dateTimeString];
        cell.onClickedButtons = ^(NSInteger tag) {
            //edit location or just see in the map
        };
    }
    
    //判断是否编辑模式 调整界面位置
    [cell.buttons buttonForTag:0].hidden = _editMode == EditMode_Off;
    [cell.labels labelForTag:0].leftLayoutConstraint.constant = _editMode == EditMode_On ? 56 : 20;
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    if (_editMode == EditMode_On) {
        //get model entity
        BDSelectionModel *entity = self.dataArray[indexPath.row];
        //set select
        entity.isSelected = !entity.isSelected;
        //reload cell
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else {
        //判断是否轨迹采集 如果是轨迹采集，进入地图
        if (_dataType == DataType_Trace) {
            //goto map
            [self pushViewControllerClass:GPGuijiTraceMapController.class inStoryboard:@"GPGuijiTrace" block:^(UIViewController *viewController) {
                GPGuijiTraceMapController *vc = (GPGuijiTraceMapController *)viewController;
                BDSelectionModel *entity = self.dataArray[indexPath.row];
                vc.traceModel = entity.data;
            }];
        }
        else{
            //表单
            
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //本地移除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (_dataType == DataType_Forum) {
            YXTable *t = self.dataArray[indexPath.row];
            BOOL suc = [YXTable deleteRowById:t.rowid];
            if (suc) {
                [BDToastView showText:@"数据已删除"];
                [self.dataArray removeObject:t];
                [tableView reloadData];
            }else{
                [BDToastView showText:@"数据库删除失败"];
            }
        }else{
            //trace points
            YXTrace *t = self.dataArray[indexPath.row];
            BOOL suc = [YXTrace deleteRowById:t.rowid];
            if (suc) {
                [BDToastView showText:@"数据已删除"];
                [self.dataArray removeObject:t];
                [tableView reloadData];
            }else{
                [BDToastView showText:@"数据库删除失败"];
            }
        }
    }
}

@end
