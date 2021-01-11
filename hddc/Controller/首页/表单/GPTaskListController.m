//
//  GPTaskListController.m
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPTaskListController.h"
#import "GPNewTaskController.h"
#import "GPTaskMapController.h"
#import "GPForumListController.h"

@interface GPTaskListController ()

@end

@implementation GPTaskListController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [YXTaskApiModel requestTasksWithPage:page projectId:self.projectModel.projectId completion:^(YXTaskApiModel * _Nonnull m, NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [self.dataArray addObjectsFromArray:m.rows];
        }
        [self.tableViews.firstObject reloadData];
        @weakify(self)
        [self.tableViews.firstObject setFooterWithRefreshingBlock:^{
            @strongify(self)
            [self loadData:NO];
        }];
        [self.tableViews.firstObject endRefreshing:m.rows.count < Standard_Page_Size_Default];
    }];
}

#pragma mark - action

- (IBAction)onNewTask:(UIButton *)b
{
    [self pushViewControllerClass:GPNewTaskController.class inStoryboard:@"GPTask" block:^(UIViewController *viewController) {
        GPNewTaskController *vc = (GPNewTaskController *)viewController;
        vc.projectModel = self.projectModel;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BDTableViewCell.class)];
    YXTaskModel *m = self.dataArray[indexPath.row];
    cell.labels.firstObject.text = m.taskName;
    
    cell.onClickedButtons = ^(NSInteger tag) {
        switch (tag) {
            case 0:
            {
                //修改任务
                [self pushViewControllerClass:GPNewTaskController.class inStoryboard:@"GPTask" block:^(UIViewController *viewController) {
                    GPNewTaskController *vc = (GPNewTaskController *)viewController;
                    vc.isModify = YES;
                    vc.title = @"修改任务";
                    vc.projectModel = self.projectModel;
                    vc.taskModel = m;
                }];
            }
                break;
            case 1:
            {
                //执行任务
                [self pushViewControllerClass:GPTaskMapController.class inStoryboard:@"GPTask" block:^(UIViewController *viewController) {
                    GPTaskMapController *vc = (GPTaskMapController *)viewController;
                    vc.projectModel = self.projectModel;
                    vc.taskModel = self.dataArray[indexPath.row];
                }];
            }
                break;
            case 2:
            {
                //查看表单列表
                [self pushViewControllerClass:GPForumListController.class inStoryboard:@"GPTask" block:^(UIViewController *viewController) {
                    GPForumListController *vc = (GPForumListController *)viewController;
                    vc.projectModel = self.projectModel;
                    vc.taskModel = self.dataArray[indexPath.row];
                }];
            }
                break;
            default:
                break;
        }
    };
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self pushViewControllerClass:GPTaskMapController.class inStoryboard:@"GPTask" block:^(UIViewController *viewController) {
//        GPTaskMapController *vc = (GPTaskMapController *)viewController;
//        vc.projectModel = self.projectModel;
//        vc.taskModel = self.dataArray[indexPath.row];
//    }];
}

@end
