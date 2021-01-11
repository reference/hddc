//
//  GPHomeProgramListController.m
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeProgramListController.h"
#import "GPTaskListController.h"

@interface GPHomeProgramListController ()

@end

@implementation GPHomeProgramListController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    [self.tableViews.firstObject setHeaderWithRefreshingBlock:^{
        @strongify(self)
        [self loadData:YES];
    }];
    [self.tableViews.firstObject.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [self setBackButtonBlack];
}

- (void)loadData:(BOOL)reload
{
    if (reload) {
        [self.dataArray removeAllObjects];
    }
    static NSInteger page = 1;
    page = reload ? 1 : page + 1;
    [YXProjectModel requestProjectsWithPage:page personId:[YXUserModel currentUser].userId completion:^(YXProjectModel *m, NSError * _Nonnull error) {
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(BDTableViewCell.class)];
    
    YXProject *m = self.dataArray[indexPath.row];
    cell.labels.firstObject.text = m.projectName;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewControllerClass:GPTaskListController.class inStoryboard:@"GPTask" block:^(UIViewController *viewController) {
        GPTaskListController *vc = (GPTaskListController *)viewController;
        vc.projectModel = self.dataArray[indexPath.row];
    }];
}
@end
