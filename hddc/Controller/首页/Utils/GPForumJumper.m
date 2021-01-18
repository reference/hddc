//
//  GPForumJumper.m
//  BDGuPiao
//
//  Created by admin on 2020/12/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPForumJumper.h"
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

@implementation GPForumJumper

+ (void)jumpToForumWithType:(NSString *)type
         fromViewController:(KKBaseViewController *)vc
                  taskModel:(YXTaskModel *)taskModel
               projectModel:(YXProject *)projectModel
                      point:(AGSPoint *)mapPoint
                   province:(NSString *)province
                       city:(NSString *)city
                       zone:(NSString *)zone
                    address:(NSString *)address
              isOffLineMode:(BOOL)isOffLineMode
            interfaceStatus:(InterfaceStatus)interfaceStatus
                      forum:(YXFormListModel *)forum
                      table:(YXTable *)table
{
    switch ([type intValue]) {
        case 1:
            //地质调查规划路线-线
        {
            [vc pushViewControllerClass:GPGeologicalSvyPlanningLine.class inStoryboard:NSStringFromClass(GPGeologicalSvyPlanningLine.class) block:^(UIViewController *viewController) {
                GPGeologicalSvyPlanningLine *vc = (GPGeologicalSvyPlanningLine *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 2:
            //地质调查规划点-点
        {
            [vc pushViewControllerClass:GPGeologicalSvyPlanningPt.class inStoryboard:NSStringFromClass(GPGeologicalSvyPlanningPt.class) block:^(UIViewController *viewController) {
                GPGeologicalSvyPlanningPt *vc = (GPGeologicalSvyPlanningPt *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 3:
            //断层观测点-点
        {
            [vc pushViewControllerClass:GPFaultSvyPoint.class inStoryboard:NSStringFromClass(GPFaultSvyPoint.class) block:^(UIViewController *viewController) {
                GPFaultSvyPoint *vc = (GPFaultSvyPoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 4:
            //地质地貌调查观测点-点
        {
            [vc pushViewControllerClass:GPGeoGeomorphySvyPoint.class inStoryboard:NSStringFromClass(GPGeoGeomorphySvyPoint.class) block:^(UIViewController *viewController) {
                GPGeoGeomorphySvyPoint *vc = (GPGeoGeomorphySvyPoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 5:
            //GeologicalSvyLine-地质调查路线-线
        {
            [vc pushViewControllerClass:GPGeologicalSvyLine.class inStoryboard:NSStringFromClass(GPGeologicalSvyLine.class) block:^(UIViewController *viewController) {
                GPGeologicalSvyLine *vc = (GPGeologicalSvyLine *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 6:
            //GeologicalSvyPoint-地质调查观测点-点
        {
            [vc pushViewControllerClass:GPGeologicalSvyPoint.class inStoryboard:NSStringFromClass(GPGeologicalSvyPoint.class) block:^(UIViewController *viewController) {
                GPGeologicalSvyPoint *vc = (GPGeologicalSvyPoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 7:
            //StratigraphySvyPoint-地层观测点-点
        {
            [vc pushViewControllerClass:GPStratigraphySvyPoint.class inStoryboard:NSStringFromClass(GPStratigraphySvyPoint.class) block:^(UIViewController *viewController) {
                GPStratigraphySvyPoint *vc = (GPStratigraphySvyPoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
            
        }
            break;
        case 8:
            //Trench-探槽-点
        {
            [vc pushViewControllerClass:GPTrench.class inStoryboard:NSStringFromClass(GPTrench.class) block:^(UIViewController *viewController) {
                GPTrench *vc = (GPTrench *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 9:
            //GeomorphySvyLine-微地貌测量线-线
        {
            [vc pushViewControllerClass:GPGeomorphySvyLine.class inStoryboard:NSStringFromClass(GPGeomorphySvyLine.class) block:^(UIViewController *viewController) {
                GPGeomorphySvyLine *vc = (GPGeomorphySvyLine *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 10:
            //GeomorphySvyPoint-微地貌测量点-点
        {
            [vc pushViewControllerClass:GPGeomorphySvyPoint.class inStoryboard:NSStringFromClass(GPGeomorphySvyPoint.class) block:^(UIViewController *viewController) {
                GPGeomorphySvyPoint *vc = (GPGeomorphySvyPoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 11:
            //GeomorphySvyRegion-微地貌测量面-面
        {
            [vc pushViewControllerClass:GPGeomorphySvyRegion.class inStoryboard:NSStringFromClass(GPGeomorphySvyRegion.class) block:^(UIViewController *viewController) {
                GPGeomorphySvyRegion *vc = (GPGeomorphySvyRegion *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 12:
            //GeomorphySvyReProf-微地貌面测量切线-线
        {
            [vc pushViewControllerClass:GPGeomorphySvyReProf.class inStoryboard:NSStringFromClass(GPGeomorphySvyReProf.class) block:^(UIViewController *viewController) {
                GPGeomorphySvyReProf *vc = (GPGeomorphySvyReProf *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 13:
            //GeomorphySvySamplePoint-微地貌测量采样点-点
        {
            [vc pushViewControllerClass:GPGeomorphySvySamplePoint.class inStoryboard:NSStringFromClass(GPGeomorphySvySamplePoint.class) block:^(UIViewController *viewController) {
                GPGeomorphySvySamplePoint *vc = (GPGeomorphySvySamplePoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 14:
            //GeomorStation-微地貌测量基站点-点
        {
            [vc pushViewControllerClass:GPGeomorStation.class inStoryboard:NSStringFromClass(GPGeomorStation.class) block:^(UIViewController *viewController) {
                GPGeomorStation *vc = (GPGeomorStation *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 15:
            //DrillHole-钻孔-点
        {
            [vc pushViewControllerClass:GPDrillHole.class inStoryboard:NSStringFromClass(GPDrillHole.class) block:^(UIViewController *viewController) {
                GPDrillHole *vc = (GPDrillHole *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 16:
            //SamplePoint-采样点-点
        {
            [vc pushViewControllerClass:GPSamplePoint.class inStoryboard:NSStringFromClass(GPSamplePoint.class) block:^(UIViewController *viewController) {
                GPSamplePoint *vc = (GPSamplePoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 17:
            //GeophySvyLine-地球物理测线-线
        {
            [vc pushViewControllerClass:GPGeophySvyLine.class inStoryboard:NSStringFromClass(GPGeophySvyLine.class) block:^(UIViewController *viewController) {
                GPGeophySvyLine *vc = (GPGeophySvyLine *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 18:
            //GeophySvyPoint-地球物理测点-点
        {
            [vc pushViewControllerClass:GPGeophySvyPoint.class inStoryboard:NSStringFromClass(GPGeophySvyPoint.class) block:^(UIViewController *viewController) {
                GPGeophySvyPoint *vc = (GPGeophySvyPoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 19:
            //GeochemicalSvyLine-地球化学探测测线-线
        {
            [vc pushViewControllerClass:GPGeochemicalSvyLine.class inStoryboard:NSStringFromClass(GPGeochemicalSvyLine.class) block:^(UIViewController *viewController) {
                GPGeochemicalSvyLine *vc = (GPGeochemicalSvyLine *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 20:
            //GeochemicalSvyPoint-地球化学探测测点-点
        {
            [vc pushViewControllerClass:GPGeochemicalSvyPoint.class inStoryboard:NSStringFromClass(GPGeochemicalSvyPoint.class) block:^(UIViewController *viewController) {
                GPGeochemicalSvyPoint *vc = (GPGeochemicalSvyPoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 21:
            //Crater-火山口-点
        {
            [vc pushViewControllerClass:GPCrater.class inStoryboard:NSStringFromClass(GPCrater.class) block:^(UIViewController *viewController) {
                GPCrater *vc = (GPCrater *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 22:
            //Lava-熔岩流-面
        {
            [vc pushViewControllerClass:GPLava.class inStoryboard:NSStringFromClass(GPLava.class) block:^(UIViewController *viewController) {
                GPLava *vc = (GPLava *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 23:
            //VolcanicSamplePoint-火山采样点-点
        {
            [vc pushViewControllerClass:GPVolcanicSamplePoint.class inStoryboard:NSStringFromClass(GPVolcanicSamplePoint.class) block:^(UIViewController *viewController) {
                GPVolcanicSamplePoint *vc = (GPVolcanicSamplePoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        case 24:
            //VolcanicSvyPoint-火山调查观测点-点
        {
            [vc pushViewControllerClass:GPVolcanicSvyPoint.class inStoryboard:NSStringFromClass(GPVolcanicSvyPoint.class) block:^(UIViewController *viewController) {
                GPVolcanicSvyPoint *vc = (GPVolcanicSvyPoint *)viewController;
                vc.coordinate = [mapPoint toCLLocationCoordinate2D];
                vc.provinceStr = province;
                vc.cityStr = city;
                vc.zoneStr = zone;
                vc.address = address;
                vc.projectModel = projectModel;
                vc.interfaceStatus = interfaceStatus;
                vc.forumListModel = forum;
                vc.table = table;
                vc.type = type;
                vc.taskModel = taskModel;
                vc.isOffLineMode = isOffLineMode;
            }];
        }
            break;
        default:
            break;
    }
}

@end
