//
//  GPForumListController.m
//  BDGuPiao
//
//  Created by admin on 2020/12/11.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPForumListController.h"
#import "GPTaskMapController.h"

//tasks form
#import "GPGeologicalSvyPlanningLine.h"
#import "GPGeologicalSvyPlanningPt.h"

#import "GPFaultSvyPoint.h"
#import "GPGeoGeomorphySvyPoint.h"
#import "GPGeologicalSvyLine.h"
#import "GPGeologicalSvyPoint.h"
#import "GPStratigraphySvyPoint.h"
#import "GPTrench.h"

#import "GPGeomorphySvyLine.h"
#import "GPGeomorphySvyPoint.h"
#import "GPGeomorphySvyRegion.h"
#import "GPGeomorphySvyReProf.h"
#import "GPGeomorphySvySamplePoint.h"
#import "GPGeomorStation.h"

#import "GPDrillHole.h"

#import "GPSamplePoint.h"

#import "GPGeophySvyLine.h"
#import "GPGeophySvyPoint.h"

#import "GPGeochemicalSvyLine.h"
#import "GPGeochemicalSvyPoint.h"

#import "GPCrater.h"
#import "GPLava.h"
#import "GPVolcanicSamplePoint.h"
#import "GPVolcanicSvyPoint.h"

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
            [self gotoDetailWithForumListModel:m type:self.curType interfaceStatus:InterfaceStatus_Show table:nil];
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
            
            [self gotoDetailWithForumListModel:model type:self.curType interfaceStatus:InterfaceStatus_Edit table:table];
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
#pragma mark - private

//去详情
- (void)gotoDetailWithForumListModel:(id)m type:(NSInteger)type interfaceStatus:(InterfaceStatus)interfaceStatus table:(YXTable *)table
{
    //表单详情
    switch (type) {
        case 1:
            //地质调查规划路线-线
        {
            [self pushViewControllerClass:GPGeologicalSvyPlanningLine.class inStoryboard:NSStringFromClass(GPGeologicalSvyPlanningLine.class) block:^(UIViewController *viewController) {
                GPGeologicalSvyPlanningLine *vc = (GPGeologicalSvyPlanningLine *)viewController;

                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 2:
            //地质调查规划点-点
        {
            [self pushViewControllerClass:GPGeologicalSvyPlanningPt.class inStoryboard:NSStringFromClass(GPGeologicalSvyPlanningPt.class) block:^(UIViewController *viewController) {
                GPGeologicalSvyPlanningPt *vc = (GPGeologicalSvyPlanningPt *)viewController;
                
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 3:
            //断层观测点-点
        {
            [self pushViewControllerClass:GPFaultSvyPoint.class inStoryboard:NSStringFromClass(GPFaultSvyPoint.class) block:^(UIViewController *viewController) {
                GPFaultSvyPoint *vc = (GPFaultSvyPoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 4:
            //地质地貌调查观测点-点
        {
            [self pushViewControllerClass:GPGeoGeomorphySvyPoint.class inStoryboard:NSStringFromClass(GPGeoGeomorphySvyPoint.class) block:^(UIViewController *viewController) {
                GPGeoGeomorphySvyPoint *vc = (GPGeoGeomorphySvyPoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 5:
            //GeologicalSvyLine-地质调查路线-线
        {
            [self pushViewControllerClass:GPGeologicalSvyLine.class inStoryboard:NSStringFromClass(GPGeologicalSvyLine.class) block:^(UIViewController *viewController) {
                GPGeologicalSvyLine *vc = (GPGeologicalSvyLine *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 6:
            //GeologicalSvyPoint-地质调查观测点-点
        {
            [self pushViewControllerClass:GPGeologicalSvyPoint.class inStoryboard:NSStringFromClass(GPGeologicalSvyPoint.class) block:^(UIViewController *viewController) {
                GPGeologicalSvyPoint *vc = (GPGeologicalSvyPoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 7:
            //StratigraphySvyPoint-地层观测点-点
        {
            [self pushViewControllerClass:GPStratigraphySvyPoint.class inStoryboard:NSStringFromClass(GPStratigraphySvyPoint.class) block:^(UIViewController *viewController) {
                GPStratigraphySvyPoint *vc = (GPStratigraphySvyPoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
            
        }
            break;
        case 8:
            //Trench-探槽-点
        {
            [self pushViewControllerClass:GPTrench.class inStoryboard:NSStringFromClass(GPTrench.class) block:^(UIViewController *viewController) {
                GPTrench *vc = (GPTrench *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 9:
            //GeomorphySvyLine-微地貌测量线-线
        {
            [self pushViewControllerClass:GPGeomorphySvyLine.class inStoryboard:NSStringFromClass(GPGeomorphySvyLine.class) block:^(UIViewController *viewController) {
                GPGeomorphySvyLine *vc = (GPGeomorphySvyLine *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 10:
            //GeomorphySvyPoint-微地貌测量点-点
        {
            [self pushViewControllerClass:GPGeomorphySvyPoint.class inStoryboard:NSStringFromClass(GPGeomorphySvyPoint.class) block:^(UIViewController *viewController) {
                GPGeomorphySvyPoint *vc = (GPGeomorphySvyPoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 11:
            //GeomorphySvyRegion-微地貌测量面-面
        {
            [self pushViewControllerClass:GPGeomorphySvyRegion.class inStoryboard:NSStringFromClass(GPGeomorphySvyRegion.class) block:^(UIViewController *viewController) {
                GPGeomorphySvyRegion *vc = (GPGeomorphySvyRegion *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 12:
            //GeomorphySvyReProf-微地貌面测量切线-线
        {
            [self pushViewControllerClass:GPGeomorphySvyReProf.class inStoryboard:NSStringFromClass(GPGeomorphySvyReProf.class) block:^(UIViewController *viewController) {
                GPGeomorphySvyReProf *vc = (GPGeomorphySvyReProf *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 13:
            //GeomorphySvySamplePoint-微地貌测量采样点-点
        {
            [self pushViewControllerClass:GPGeomorphySvySamplePoint.class inStoryboard:NSStringFromClass(GPGeomorphySvySamplePoint.class) block:^(UIViewController *viewController) {
                GPGeomorphySvySamplePoint *vc = (GPGeomorphySvySamplePoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 14:
            //GeomorStation-微地貌测量基站点-点
        {
            [self pushViewControllerClass:GPGeomorStation.class inStoryboard:NSStringFromClass(GPGeomorStation.class) block:^(UIViewController *viewController) {
                GPGeomorStation *vc = (GPGeomorStation *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 15:
            //DrillHole-钻孔-点
        {
            [self pushViewControllerClass:GPDrillHole.class inStoryboard:NSStringFromClass(GPDrillHole.class) block:^(UIViewController *viewController) {
                GPDrillHole *vc = (GPDrillHole *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 16:
            //SamplePoint-采样点-点
        {
            [self pushViewControllerClass:GPSamplePoint.class inStoryboard:NSStringFromClass(GPSamplePoint.class) block:^(UIViewController *viewController) {
                GPSamplePoint *vc = (GPSamplePoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 17:
            //GeophySvyLine-地球物理测线-线
        {
            [self pushViewControllerClass:GPGeophySvyLine.class inStoryboard:NSStringFromClass(GPGeophySvyLine.class) block:^(UIViewController *viewController) {
                GPGeophySvyLine *vc = (GPGeophySvyLine *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 18:
            //GeophySvyPoint-地球物理测点-点
        {
            [self pushViewControllerClass:GPGeophySvyPoint.class inStoryboard:NSStringFromClass(GPGeophySvyPoint.class) block:^(UIViewController *viewController) {
                GPGeophySvyPoint *vc = (GPGeophySvyPoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 19:
            //GeochemicalSvyLine-地球化学探测测线-线
        {
            [self pushViewControllerClass:GPGeochemicalSvyLine.class inStoryboard:NSStringFromClass(GPGeochemicalSvyLine.class) block:^(UIViewController *viewController) {
                GPGeochemicalSvyLine *vc = (GPGeochemicalSvyLine *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 20:
            //GeochemicalSvyPoint-地球化学探测测点-点
        {
            [self pushViewControllerClass:GPGeochemicalSvyPoint.class inStoryboard:NSStringFromClass(GPGeochemicalSvyPoint.class) block:^(UIViewController *viewController) {
                GPGeochemicalSvyPoint *vc = (GPGeochemicalSvyPoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 21:
            //Crater-火山口-点
        {
            [self pushViewControllerClass:GPCrater.class inStoryboard:NSStringFromClass(GPCrater.class) block:^(UIViewController *viewController) {
                GPCrater *vc = (GPCrater *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 22:
            //Lava-熔岩流-面
        {
            [self pushViewControllerClass:GPLava.class inStoryboard:NSStringFromClass(GPLava.class) block:^(UIViewController *viewController) {
                GPLava *vc = (GPLava *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 23:
            //VolcanicSamplePoint-火山采样点-点
        {
            [self pushViewControllerClass:GPVolcanicSamplePoint.class inStoryboard:NSStringFromClass(GPVolcanicSamplePoint.class) block:^(UIViewController *viewController) {
                GPVolcanicSamplePoint *vc = (GPVolcanicSamplePoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        case 24:
            //VolcanicSvyPoint-火山调查观测点-点
        {
            [self pushViewControllerClass:GPVolcanicSvyPoint.class inStoryboard:NSStringFromClass(GPVolcanicSvyPoint.class) block:^(UIViewController *viewController) {
                GPVolcanicSvyPoint *vc = (GPVolcanicSvyPoint *)viewController;
                            
                if ([m isKindOfClass:YXFormListModel.class]) {
                    vc.forumListModel = m;
                }else {
                    
                    vc.table = table;
                }
                vc.interfaceStatus = interfaceStatus;
                vc.projectModel = self.projectModel;
                vc.taskModel = self.taskModel;
                vc.type = [NSString stringWithFormat:@"%li",(long)self.curType];
            }];
        }
            break;
        default:
            break;
    }
}

@end
