//
//  GPArcGisMapController.m
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPArcGisMapController.h"
#import "TianDiTuLayerInfo.h"
#import "TianDiTuLayer.h"
#import "GPMapLayerPicker.h"

@interface GPArcGisMapController ()<AGSGeoViewTouchDelegate>
@property (nonatomic, strong) IBOutlet AGSMapView *mapView;
@property (nonatomic, strong) AGSMap *map;
@property (nonatomic, strong) AGSLocationDisplay *locationDisplay;

/// 功能
@property (nonatomic, strong) IBOutlet BDView *functionView;
@property (nonatomic, assign) GraphicType currGraphicType;

//
@property (nonatomic, strong) NSMutableArray <BDArcGISGraphic *> *graphics;
@property (nonatomic, strong) NSMutableArray <AGSPoint *> *points;

//用于占用
@property (nonatomic, strong) AGSGraphic *tempGraphic;

//是否处在地图的编辑模式中
@property (nonatomic, assign) BOOL isEditing;
//当前选择的图层 0 2d平面图 1 卫星图 默认0
@property (nonatomic, assign) NSInteger mapLayerType;
@end

@implementation GPArcGisMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    self.window.touchedBackgroundBlock = ^{
        @strongify(self)
        [self.window dismissViewAnimated:YES completion:nil];
    };
    //
    self.isEditing = NO;
    //mapLayerType
    self.mapLayerType = 0;
    //
    self.graphics = [NSMutableArray array];
    self.points = [NSMutableArray array];
    
    //初始化function
    self.currGraphicType = GraphicType_Polygon;
    self.functionView.onClickedButtonsCallback = ^(UIButton *btn) {
        @strongify(self)
        for (UIButton *b in self.functionView.buttons) {
            b.selected = btn == b;
        }
        //结束上一个采集
        [self geoView:nil didDoubleTapAtScreenPoint:CGPointZero mapPoint:nil completion:nil];
        
        switch (btn.tag) {
            case 0:
                self.currGraphicType = GraphicType_Polygon;
                break;
            case 1:
                self.currGraphicType = GraphicType_Line;
                break;
            default:
                break;
        }
    };
    //map
    self.mapView.touchDelegate = self;
    //去除水印
    self.mapView.attributionTextVisible = NO;
    //禁止包裹地图
//    self.mapView.wrapAroundMode = AGSWrapAroundModeDisabled;
    
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
    
    //初始化界面
    [self setupUI];
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

- (void)setupUI
{
    if (self.mapInfo) {
        //转换成坐标系
        NSArray *graphics = [BDArcGISGraphic decodeMapInfo:_mapInfo];
        [self.graphics setArray:graphics];
        [[BDArcGISUtil ins] drawGraphics:[BDArcGISGraphic decodeMapInfo:self.mapInfo]];
    }
}

#pragma mark - action

- (IBAction)onLayer:(UIButton *)b
{
    GPMapLayerPicker *picker = [UINib viewForNib:NSStringFromClass(GPMapLayerPicker.class)];
    picker.width = self.view.width;
    @weakify(self)
    picker.selectedCallback = ^(NSInteger index) {
        @strongify(self)
        self.mapLayerType = index;
        //TODO: 图层替换
        [self.window dismissViewAnimated:YES completion:^{
            if (self.mapLayerType == 0) {
                //加载2d天地图
                [TianDiTuLayer load2DTianDiMapLayerInMap:self.map];
            }else{
                [TianDiTuLayer loadSatelliteTianDiMapLayerInMap:self.map];
            }
        }];
    };
    picker.selectIndex = self.mapLayerType;
    [self popView:picker position:Position_Top];
}

- (IBAction)onSave:(UIButton *)b
{
    //编码坐标给服务器，参见YXTaskModel.h的mapinfo字段说明或者BDArcGISGraphic的-(NSString*)encode;说明
    NSString *curMapInfo = [BDArcGISGraphic multiEncodeByGraphics:self.graphics];
    if (self.selectedMapCallback) {
        self.selectedMapCallback(curMapInfo);
    }
    [self popViewControllerAnimated:YES];
}

#pragma mark Tap

- (void)geoView:(AGSGeoView *)geoView didTapAtScreenPoint:(CGPoint)screenPoint mapPoint:(AGSPoint *)mapPoint
{
    self.isEditing = YES;
    //先打一个点 让用户在界面上看到点了哪里
    static NSString *startPin = @"StartPin";
    if (self.points.count == 0) {
        [[BDArcGISUtil ins] pinAtPoint:mapPoint identifier:startPin];
    }else{
        //当用户点了第二个点以后，线就出来了，第一个点也可以不需要显示了
        [[BDArcGISUtil ins] removePinByIdentifier:startPin];
    }
    //
    [self.points addObject:mapPoint];
    switch (self.currGraphicType) {
        case GraphicType_Polygon:
        {
            //移除之前画的面，不然再画会重叠
            if (self.tempGraphic) {
                [[BDArcGISUtil ins] romovePolygonGraphic:self.tempGraphic];
            }
            AGSGraphic *polygonGraphic = [[BDArcGISUtil ins] drawPolygonWithPoints:self.points];
            self.tempGraphic = polygonGraphic;
        }
            break;
        case GraphicType_Line:
        {
            AGSGraphic *lineGraphic = [[BDArcGISUtil ins] drawMultiLinesByPoints:self.points];
            self.tempGraphic = lineGraphic;
        }
            break;
        default:
            break;
    }
    
}

#pragma mark Double Tap

-(void)geoView:(AGSGeoView*)geoView didDoubleTapAtScreenPoint:(CGPoint)screenPoint
      mapPoint:(AGSPoint *)mapPoint
    completion:(void(^)(BOOL willHandleDoubleTap))completion
{
    //如果不处于编辑模式下 双击不要处理
    if (self.isEditing) {
        //如果用户只点击了一个点就双击了，那不处理
        if (self.points.count == 1) {
            return;
        }
        //end of editing
        self.isEditing = NO;
        BDArcGISGraphic *graphic = [BDArcGISGraphic new];
        graphic.type = self.currGraphicType;
        graphic.graphic = self.tempGraphic;
        [self.graphics addObject:graphic];
        
        //clean
        [self.points removeAllObjects];
        //clean 只有清理了才能画出来新的面，否则会被清掉
        self.tempGraphic = nil;
    }else{
        //缩进
        
    }
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
