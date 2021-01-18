//
//  GPForumListController.m
//  BDGuPiao
//
//  Created by admin on 2020/12/11.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPForumListController.h"
#import "GPTaskMapController.h"

@interface GPForumListController ()
@property (nonatomic, strong) NSDictionary *typeDic;
@property (nonatomic, assign) NSInteger curType;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentControl;
@end

@implementation GPForumListController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButtonBlack];
    [self.tableViews.firstObject.mj_header beginRefreshing];
}

- (void)loadData:(BOOL)reload
{
    if (reload) {
        [self.dataArray removeAllObjects];
    }
    static NSInteger page = 1;
    page = reload ? 1 : page + 1;
    
    //远程 已提交
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [YXFormListModel requestProjectsWithPage:page
                                          userId:[YXUserModel currentUser].userId
                                          taskId:self.taskModel.taskId
                                       projectId:self.projectModel.projectId
                                            type:self.curType
                                      completion:^(NSArray<YXFormListModel *> * _Nonnull ms, NSError * _Nonnull error) {
            if (error) {
                [BDToastView showText:error.localizedDescription];
            }else{
                [self.dataArray addObjectsFromArray:ms];
            }
            [self.tableViews.firstObject reloadData];
            @weakify(self)
            [self.tableViews.firstObject setFooterWithRefreshingBlock:^{
                @strongify(self)
                [self loadData:NO];
            }];
            [self.tableViews.firstObject endRefreshing:ms.count < Standard_Page_Size_Default];
        }];
    }else{
        //本地数据
        //查询
        NSString *userId = [YXUserModel currentUser].userId;
        NSString *tableName = [YXTable tableNameOfType:self.curType];
        //从数据库中查找
        NSArray* tables = [YXTable findTablesByName:tableName taskId:self.taskModel.taskId projectId:self.projectModel.projectId type:self.curType userId:userId];
        
        for (YXTable *table in tables) {
            [self.dataArray addObject:table];
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
}

#pragma mark - action

- (IBAction)onButtons:(UIButton *)b
{
    //
    if (b.tag == 0) {
        //表单类型
        GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:[self.typeDic allKeys]];
        selector.onDone = ^(NSString * _Nonnull key) {
            [self.labels labelForTag:0].text = key;
            //
            NSArray *arr = self.typeDic[key];
            [self.labels labelForTag:1].text = arr.firstObject[@"name"];
            self.curType = [arr.firstObject[@"id"] intValue];
            
            //调接口
            [self.tableViews.firstObject.mj_header beginRefreshing];
        };
    }else{
        //表单
        NSArray *arr = self.typeDic[[self.labels labelForTag:0].text];
        GPNormalPicker *selector = [GPNormalPicker popUpInController:self dataArray:arr];
        selector.onDone = ^(NSDictionary * _Nonnull dic) {
            [self.labels labelForTag:1].text = dic[@"name"];
            self.curType = [dic[@"id"] intValue];
            //调接口
            [self.tableViews.firstObject.mj_header beginRefreshing];
        };
    }
}

- (IBAction)onNewTask:(UIButton *)b
{
    [self pushViewControllerClass:GPTaskMapController.class inStoryboard:@"GPTask" block:^(UIViewController *viewController) {
        GPTaskMapController *vc = (GPTaskMapController *)viewController;
        vc.projectModel = self.projectModel;
        vc.taskModel = self.taskModel;
    }];
}

- (IBAction)onSegment:(UISegmentedControl *)s
{
    [self.tableViews.firstObject.mj_header beginRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDTableViewCell *cell = nil;
    if (self.segmentControl.selectedSegmentIndex == 0) {
        //已提交
        cell = [tableView dequeueReusableCellWithIdentifier:@"remote"];
        YXFormListModel *m = self.dataArray[indexPath.row];
        cell.labels.firstObject.text = m.id;//[GPForumType nameOfType:self.curType];
        
        cell.onClickedButtons = ^(NSInteger tag) {
            //查看详情
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
                               interfaceStatus:InterfaceStatus_Show
                                         forum:m
                                         table:nil];
        };
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"local"];
        
        //table name
        NSString *tableName = [YXTable tableNameOfType:self.curType];
        //get table
        YXTable *table = self.dataArray[indexPath.row];
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
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
//    YXFormListModel *m = self.dataArray[indexPath.row];
//
//    int type = 1;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.segmentControl.selectedSegmentIndex == 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //本地移除
    if (self.segmentControl.selectedSegmentIndex == 1 && editingStyle == UITableViewCellEditingStyleDelete) {
        YXTable *t = self.dataArray[indexPath.row];
        BOOL suc = [YXTable deleteRowById:t.rowid];
        if (suc) {
            [BDToastView showText:@"数据已删除"];
            [self.dataArray removeObject:t];
            [tableView reloadData];
        }else{
            [BDToastView showText:@"数据库删除失败"];
        }
    }
}

@end
