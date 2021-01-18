//
//  GPTaskMapController.m
//  BDGuPiao
//
//  Created by admin on 2020/12/11.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPTaskMapController.h"
#import "TianDiTuLayerInfo.h"
#import "TianDiTuLayer.h"
#import "GPMapLayerPicker.h"
#import "GPDiXinTypePicker.h"
#import <INTULocationManager/INTULocationManager.h>

@interface GPTaskMapController ()<AGSGeoViewTouchDelegate>
@property (nonatomic, strong) IBOutlet AGSMapView *mapView;
@property (nonatomic, strong) AGSMap *map;
@property (nonatomic, strong) AGSLocationDisplay *locationDisplay;
@property (nonatomic, assign) BOOL loaded;
@end

@implementation GPTaskMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    self.window.touchedBackgroundBlock = ^{
        @strongify(self)
        [self.window dismissViewAnimated:YES completion:nil];
    };
    //map
    self.mapView.touchDelegate = self;
    //去除水印
    self.mapView.attributionTextVisible = NO;
    
    //map
    self.map = [[AGSMap alloc] init];
    self.mapView.map = self.map;

    //加载2d天地图
    [TianDiTuLayer load2DTianDiMapLayerInMap:self.map];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButtonBlack];
    //overlay
    [self.mapView.graphicsOverlays addObject:[BDArcGISUtil ins].graphicsOverlay];
    [[BDArcGISUtil ins] clearAllOverlaies];
    //显示用户当前位置
    [self onCurrentLocation:nil];
    
    if (self.loaded == NO) {
        self.loaded = YES;
        //显示任务区域
    //    NSArray *graphics = [BDArcGISGraphic decodeMapInfo:self.taskModel.mapInfos];
        [[BDArcGISUtil ins] drawGraphics:[BDArcGISGraphic decodeMapInfo:self.taskModel.mapInfos]];
        
        //加载kml kmz shp
        NSArray *tbs = [YXTable findTablesByName:NSStringFromClass(GPKmlKmzShpEntity.class) taskId:self.taskModel.taskId userId:[YXUserModel currentUser].userId];
        for (YXTable *tb in tbs) {
            GPKmlKmzShpEntity *entity = [YXTable decodeDataInTable:tb];
            //查看是否文件存在 如果文件存在再显示
            NSString *filePath = [NSFileManager documentFile:entity.fileNameWithSuffix inDirectory:@"web"];
            BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (fileExist) {
                NSString *suffix = [entity.fileNameWithSuffix componentsSeparatedByString:@"."].lastObject;
                if ([[suffix lowercaseString] isEqualToString:@"kml"]) {
                    [[FuckAGSPlatform instance] addKMLFileWithName:entity.fileNameWithSuffix inMap:self.mapView];
                }else if ([[suffix lowercaseString] isEqualToString:@"kmz"]) {
                    [[FuckAGSPlatform instance] addKMZFileWithName:entity.fileNameWithSuffix inMap:self.mapView];
                }else if ([[suffix lowercaseString] isEqualToString:@"shp"]) {
                    [[FuckAGSPlatform instance] addSHPFileWithName:entity.fileNameWithSuffix inMap:self.mapView];
                }
                else if ([[suffix lowercaseString] isEqualToString:@"json"] || [[suffix lowercaseString] isEqualToString:@"geojson"]) {
                    NSString *filePath = [NSFileManager documentFile:entity.fileNameWithSuffix inDirectory:@"web"];
                    [BDArcGISGraphic loadGeoJsonFileAtPath:[NSURL URLWithString:filePath]];
                }
            }
        }
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //
    if (self.mapView.locationDisplay.started) {
        [self.mapView.locationDisplay stop];
    }
    //overlay
    [self.mapView.graphicsOverlays removeObject:[BDArcGISUtil ins].graphicsOverlay];
    
}

#pragma mark - api

#pragma mark Tap

- (void)geoView:(AGSGeoView *)geoView didTapAtScreenPoint:(CGPoint)screenPoint mapPoint:(AGSPoint *)mapPoint
{
    //
//    [[BDArcGISUtil ins] clearAllOverlaies];
    [[BDArcGISUtil ins] removePinAtByInfo:@{@"id":@"pin"}];
    [[BDArcGISUtil ins] pinAtPoint:mapPoint info:@{@"id":@"pin"} image:__IMG(@"icon-pin")];
    
    // 地址反查
    GPDiXinTypePicker *select = [GPDiXinTypePicker popUpInController:self];
    select.onCancel = ^{
        [self.window dismissViewAnimated:YES completion:nil];
    };
    select.onDone = ^(NSString *type) {
        [self.window dismissViewAnimated:YES completion:^{
            [BDToastView showActivity:@"位置信息获取中..."];
            [[BDArcGISUtil ins] reverseGeocodeInPoint:mapPoint completion:^(NSString *province,NSString *city,NSString *zone,NSString *address,NSError *error) {
                [BDToastView dismiss];
                
                [GPForumJumper jumpToForumWithType:type
                                fromViewController:self
                                         taskModel:self.taskModel
                                      projectModel:self.projectModel
                                             point:mapPoint
                                          province:province
                                              city:city
                                              zone:zone
                                           address:address
                                     isOffLineMode:NO
                                   interfaceStatus:InterfaceStatus_New
                                             forum:nil
                                             table:nil];
            }];
            
        }];
    };
}

#pragma mark - action

//获取当前位置 地图缩放回当前位置
- (IBAction)onCurrentLocation:(UIButton *)b
{
    if (self.mapView.locationDisplay.started) {
        [self.mapView.locationDisplay stop];
    }
    self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeRecenter;
    [self.mapView.locationDisplay startWithCompletion:nil];
}

@end
