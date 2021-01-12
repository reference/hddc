//
//  GPHomeSettingKMLListController.m
//  hddc
//
//  Created by admin on 2021/1/11.
//
#import "GPHomeSettingKMLListController.h"
#import "GPTaskMapController.h"
#import "BDSelectionModel.h"
#import "GPProjectZhiPaiPicker.h"
#import "YXTrace.h"
#import "GPFileZhiPaiPicker.h"
#import "GPMultiForumUploader.h"

typedef enum {
    EditMode_Off = 0,
    EditMode_On
}EditMode;

@interface GPHomeSettingKMLListController ()
@property (nonatomic, strong) NSDictionary *typeDic;
@property (nonatomic, assign) NSInteger curType;
//
@property (nonatomic, strong) YXProject *projectModel;
@property (nonatomic, strong) YXTaskModel *taskModel;

@property (nonatomic, strong) NSMutableArray *selectedItems;
@property (nonatomic, assign) EditMode editMode;

//bottom tool bar
@property (nonatomic, strong) IBOutlet BDView *bottomForumToolBar;
@end

@implementation GPHomeSettingKMLListController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.selectedItems = [NSMutableArray array];
    //
    _editMode = 0;
    
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
        @strongify(self)
        if (btn.tag == 0) {
            //关联任务
            GPFileZhiPaiPicker *picker = [UINib viewForNib:NSStringFromClass(GPFileZhiPaiPicker.class)];
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
                            YXTable *tb = [YXTable new];
                            GPKmlKmzShpEntity *entity = [GPKmlKmzShpEntity new];
                            entity.fileNameWithSuffix = m.data;
                            tb.encodedData = [entity yy_modelToJSONString];
                            tb.tableName = NSStringFromClass(GPKmlKmzShpEntity.class);
                            tb.userId = [YXUserModel currentUser].userId;
                            tb.projectId = project.projectId;
                            tb.taskId = task.taskId;
                            [tb bg_saveAsync:^(BOOL isSuccess) {
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
                    if (m.isSelected) {
                        NSString *file = m.data;
                        [[NSFileManager defaultManager] removeItemAtPath:[NSFileManager documentFile:file inDirectory:@"web"] error:nil];
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
    [self.dataArray removeAllObjects];
    
    //本地数据
    NSString *path = [NSFileManager documentDirectory:@"web"];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *file in files) {
        BDSelectionModel *m = [BDSelectionModel new];
        m.data = file;
        m.isSelected = NO;
        [self.dataArray addObject:m];
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
    BDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BDTableViewCell.class)];
    //get model entity
    BDSelectionModel *entity = self.dataArray[indexPath.row];
    //是否选择
    [cell.buttons buttonForTag:0].selected = entity.isSelected;
    //
    cell.labels.firstObject.text = entity.data;
    cell.onClickedButtons = ^(NSInteger tag) {
        //关联任务
        //关联任务
        GPFileZhiPaiPicker *picker = [UINib viewForNib:NSStringFromClass(GPFileZhiPaiPicker.class)];
        picker.onCancel = ^{
            [self.window dismissViewAnimated:YES completion:nil];
        };
        //保存本地
        picker.onSaveLocal = ^(YXProject * _Nonnull project, YXTaskModel * _Nonnull task) {
            [self.window dismissViewAnimated:YES completion:^{
                //批量修改
                [BDToastView showActivity:@"保存中..."];
                
                YXTable *tb = [YXTable new];
                GPKmlKmzShpEntity *entity = [GPKmlKmzShpEntity new];
                entity.fileNameWithSuffix = entity.data;
                tb.encodedData = [entity yy_modelToJSONString];
                tb.tableName = NSStringFromClass(GPKmlKmzShpEntity.class);
                tb.userId = [YXUserModel currentUser].userId;
                tb.projectId = project.projectId;
                tb.taskId = task.taskId;
                [tb bg_saveAsync:^(BOOL isSuccess) {
                    if (isSuccess) {
                        NSLog(@"指派成功");
                    }
                }];
                //延时处理 避免数据库冲突
                [BDToastView showText:@"任务已关联完成"];
            }];
        };
        
        [self popView:picker position:Position_Middle];
    };
    
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
        BDSelectionModel *entity = self.dataArray[indexPath.row];
        NSString *file = entity.data;
        BOOL suc = [[NSFileManager defaultManager] removeItemAtPath:[NSFileManager documentFile:file inDirectory:@"web"] error:nil];
        if (suc) {
            [BDToastView showText:@"文件已删除"];
            [self.dataArray removeObject:entity];
            [tableView reloadData];
        }else{
            [BDToastView showText:@"文件删除失败"];
        }
    }
}

@end
