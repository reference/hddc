//
//  GPGuijiTraceMapController.m
//  BDGuPiao
//
//  Created by admin on 2020/12/22.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPGuijiTraceMapController.h"
#import "TianDiTuLayer.h"
#import "BDArcGISUtil.h"
#import "BDArcGISGraphic.h"
#import "BDLocationTrace.h"

@interface GPGuijiTraceMapController ()<AGSGeoViewTouchDelegate>
@property (nonatomic, strong) IBOutlet AGSMapView *mapView;
@property (nonatomic, strong) AGSMap *map;
@property (nonatomic, strong) AGSLocationDisplay *locationDisplay;

@end

@implementation GPGuijiTraceMapController

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setBackButtonBlack];
    
    //overlay
    [self.mapView.graphicsOverlays addObject:[BDArcGISUtil ins].graphicsOverlay];
    [[BDArcGISUtil ins] clearAllOverlaies];
    //显示用户当前位置
    [self onCurrentLocation:nil];
    
    //显示任务区域
//    NSArray *graphics = [BDArcGISGraphic decodeMapInfo:self.taskModel.mapInfos];
    NSArray *points = [self.traceModel toAGSPoints];
    AGSGraphic *graphic = [BDArcGISUtil buildMultiLinesByPoints:points];
    BDArcGISGraphic *bd_graphic = [BDArcGISGraphic new];
    bd_graphic.type = GraphicType_Line;
    bd_graphic.graphic = graphic;
    [[BDArcGISUtil ins] drawGraphics:@[bd_graphic]];
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

+ (void)showFromController:(UIViewController *)viewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"GPGuijiTrace" bundle:nil];
    ZXNavigationController *nv = [sb instantiateViewControllerWithIdentifier:@"GPGuijiTraceNaviController"];
    nv.modalPresentationStyle = UIModalPresentationFullScreen;
    [viewController presentViewController:nv animated:YES completion:nil];
}

#pragma mark - api

#pragma mark Tap

- (void)geoView:(AGSGeoView *)geoView didTapAtScreenPoint:(CGPoint)screenPoint mapPoint:(AGSPoint *)mapPoint
{
    
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
