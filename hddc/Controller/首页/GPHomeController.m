//
//  GPHomeController.m
//  BDGuPiao
//
//  Created by B-A-N on 2020/7/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "GPHomeController.h"
#import "GPHomeMeCenter.h"
#import "GPHomeProgramListController.h"
#import "GPArcGisMapController.h"
#import "TianDiTuLayerInfo.h"
#import "TianDiTuLayer.h"
#import "GPMapLayerPicker.h"
#import "GPDiXinTypePicker.h"
#import "GPHomeTraceCollectionOnlinePopView.h"
#import "GPHomeTraceCollectionOfflinePopView.h"
#import "GPOfflineForumListController.h"
#import "GPHomeOnlinePicker.h"
#import "GPForumJumper.h"
#import "GPHomeOfflinePicker.h"
#import "BDLocationTrace.h"
#import "YXTrace.h"
#import "GPHomeMapCalloutView.h"

#import "AGSGoogleMapLayer.h"

//离线模式还是在线模式
typedef enum {
    LineMode_off = 0,
    LineMode_on
}LineMode;

//编辑模式还是普通模式
typedef enum {
    EditMode_off = 0,
    EditMode_on
}EditMode;

@interface GPHomeController ()<AGSGeoViewTouchDelegate>
@property (nonatomic, strong) IBOutlet AGSMapView *mapView;
@property (nonatomic, strong) AGSMap *map;
@property (nonatomic, strong) AGSLocationDisplay *locationDisplay;
//当前选择的图层 0 2d平面图 1 卫星图 默认0
@property (nonatomic, assign) NSInteger mapLayerType;
//离线/在线模式
@property (nonatomic, assign) LineMode mode;
//编辑模式还是普通模式
@property (nonatomic, assign) EditMode editMode;
//
@property (nonatomic, strong) IBOutlet UIView *bottomToolbarHolder;
@property (nonatomic, strong) IBOutlet BDView *bottomOfflineToolbar;
@property (nonatomic, strong) IBOutlet BDView *bottomOnlineToolbar;

//轨迹采集
@property (nonatomic, strong) IBOutlet BDView *traceCollectView;

//test
@property (nonatomic, strong) AGSKMLLayer *kmlLayer;
@end

@implementation GPHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    self.window.touchedBackgroundBlock = ^{
        @strongify(self)
        [self.window dismissViewAnimated:YES completion:nil];
    };
    //map layer
    self.mapLayerType = 0;
    //map
    self.mapView.touchDelegate = self;
    //去除水印
    self.mapView.attributionTextVisible = NO;
    
    //map
    self.map = [[AGSMap alloc] init];
    self.mapView.map = self.map;
    //加载2d天地图
    [TianDiTuLayer load2DTianDiMapLayerInMap:self.map];
    
    //加载google map
//    [AGSGoogleMapLayer loadAGSGoogleMapLayer:self.map type:GoogleMap_TERRAIN];
    //
    //毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, self.bottomToolbarHolder.width, self.bottomToolbarHolder.height);
    [self.bottomToolbarHolder insertSubview:effectView atIndex:0];
    
    //在线/离线模式
    self.mode = LineMode_on;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //
    [self.navigationController setNavigationBarHidden:YES];
    
    //overlay
    [self.mapView.graphicsOverlays addObject:[BDArcGISUtil ins].graphicsOverlay];
    [[BDArcGISUtil ins] clearAllOverlaies];
    //显示用户当前位置
    [self onCurrentLocation:nil];
    
    //显示任务区域
//    NSArray *graphics = [BDArcGISGraphic decodeMapInfo:self.taskModel.mapInfos];
//    [[BDArcGISUtil ins] drawGraphics:[BDArcGISGraphic decodeMapInfo:self.taskModel.mapInfos]];
    
    
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
    
    // dissmiss any callout
    [self.mapView.callout dismiss];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ///加载所有的表单列表
    [self apiLoadAllForums];
}

#pragma mark - api

- (void)apiLoadAllForums
{
    if ([YXUserModel isLogin]) {
        [YXForumDataInfoModel requestUserId:[YXUserModel currentUser].userId completion:^(NSArray<YXForumDataInfoModel *> * _Nonnull ms, NSError * _Nonnull error) {
            if (error) {
                
            }else{
                for (YXForumDataInfoModel *m in ms) {
                    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(m.lat,m.lon);
                    [[BDArcGISUtil ins] pinAtPoint:[AGSPoint pointWithCLLocationCoordinate2D:coords]
                                              info:[m yy_modelToJSONObject]];
                }
            }
        }];
    }
}

- (void)setMode:(LineMode)mode
{
    _mode = mode;
    
    if (mode == LineMode_off) {
        //加载离线地图
        
        //
        self.bottomOnlineToolbar.hidden = YES;
        self.bottomOfflineToolbar.hidden = NO;
    }else{
        //加载在线地图
        
        //
        self.bottomOnlineToolbar.hidden = NO;
        self.bottomOfflineToolbar.hidden = YES;
    }
}

- (void)setEditMode:(EditMode)editMode
{
    _editMode = editMode;
    
    //设置采集状态UI
    
    [[self.bottomOnlineToolbar.buttons buttonForTag:1] setTitle:_editMode == EditMode_off ? @"开始采集" : @"结束采集" forState:UIControlStateNormal];
    [[self.bottomOfflineToolbar.buttons buttonForTag:1] setTitle:_editMode == EditMode_off ? @"开始采集" : @"结束采集" forState:UIControlStateNormal];

}

#pragma mark - api

- (void)loadAllForumPoints
{
    
}

//轨迹采集
- (void)apiSubmitTracePoints
{
    //获取最后一条
    YXTracePointModel *body = [YXTracePointModel new];
    [YXTracePointModel saveWithBody:body completion:^(NSError * _Nonnull error) {
        if (error) {
            [BDToastView showText:error.localizedDescription];
        }else{
            [BDToastView showText:@"轨迹采集已保存"];
        }
    }];
}

#pragma mark Tap

- (void)geoView:(AGSGeoView *)geoView didTapAtScreenPoint:(CGPoint)screenPoint mapPoint:(AGSPoint *)mapPoint
{
    // add new pint
    void (^addNewForum)(AGSPoint *point) = ^(AGSPoint *point) {
        // dismiss callout view
        [self.mapView.callout dismiss];
        
        //已经进入编辑模式
        if (self->_mode == LineMode_on) {
            //在线模式
            GPHomeOnlinePicker *picker = [UINib viewForNib:NSStringFromClass(GPHomeOnlinePicker.class)];
            picker.onCancel = ^{
                [self.window dismissViewAnimated:YES completion:nil];
            };
            picker.onDone = ^(YXProject * _Nonnull project, YXTaskModel * _Nonnull task, NSString * forumType) {
                [self.window dismissViewAnimated:YES completion:^{
                    //表单采集
                    [GPForumJumper jumpToForumWithType:forumType fromViewController:self taskModel:task projectModel:project point:point interfaceStatus:InterfaceStatus_New forum:nil table:nil];
                }];
            };
            [self popView:picker position:Position_Middle];
        }
        else {
            //离线模式
            GPHomeOfflinePicker *picker = [UINib viewForNib:NSStringFromClass(GPHomeOfflinePicker.class)];
            picker.onCancel = ^{
                [self.window dismissViewAnimated:YES completion:nil];
            };
            picker.onDone = ^(NSString * forumType) {
                [self.window dismissViewAnimated:YES completion:^{
                    //表单采集
                    [GPForumJumper jumpToForumWithType:forumType fromViewController:self taskModel:nil projectModel:nil point:point interfaceStatus:InterfaceStatus_New forum:nil table:nil];
                }];
            };
            [self popView:picker position:Position_Middle];
        }
    };
    
    //forum
    if (_editMode == EditMode_on) {
        addNewForum(mapPoint);
    }
    else {
        [geoView identifyGraphicsOverlay:geoView.graphicsOverlays.firstObject screenPoint:screenPoint tolerance:12 returnPopupsOnly:NO maximumResults:1000 completion:^(AGSIdentifyGraphicsOverlayResult * _Nonnull identifyResult) {
            if (identifyResult.error) {
                NSLog(@"error %@",identifyResult.error.localizedDescription);
            }else{
                NSMutableArray *forumDataInfoModels = [NSMutableArray array];
                //获得锚点的信息
                for (AGSGraphic *graphic in identifyResult.graphics) {
                    NSLog(@"info %@",graphic.attributes);
                    YXForumDataInfoModel *m = [YXForumDataInfoModel yy_modelWithJSON:[graphic.attributes yy_modelToJSONObject]];
                    [forumDataInfoModels addObject:m];
                }
                
                // if info is exsit 弹出框
                if (forumDataInfoModels.count) {
                    //callout
                    GPHomeMapCalloutView *customView = [UINib viewForNib:NSStringFromClass(GPHomeMapCalloutView.class)];
                    //set data
                    customView.forumDataInfoModels = forumDataInfoModels;
                    // add new
                    customView.didAddNew = ^(AGSPoint * _Nonnull point) {
                        addNewForum(point);
                    };
                    //did select item
                    customView.didSelectForum = ^(YXForumDataInfoModel * _Nonnull forumInfoModel) {
                        // dismiss callout
                        [geoView.callout dismiss];
                        // build a forum list model
                        YXFormListModel *flm = [YXFormListModel new];
                        flm.uuid = forumInfoModel.uuid;
                        //goto forum detail
                        [GPForumJumper jumpToForumWithType:[NSString stringWithFormat:@"%li",forumInfoModel.type] fromViewController:self taskModel:nil projectModel:nil point:mapPoint interfaceStatus:InterfaceStatus_Show forum:flm table:nil];
                    };
                    //add customer view
                    self.mapView.callout.customView = customView;
                    //show callout
                    [self.mapView.callout showCalloutAt:mapPoint screenOffset:CGPointZero rotateOffsetWithMap:YES animated:YES];
                }
                else{
                    [geoView.callout dismiss];
                }
            }
        }];
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

//个人中心
- (IBAction)onMeCenter:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    [self pushViewControllerClass:GPHomeMeCenter.class inStoryboard:@"GPHome"];
}

//改变图层
- (IBAction)onMapLayers:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    // picker
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

//轨迹采集
- (IBAction)onTraceCollect:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    //picker
    BDLocationTrace *trace = [BDLocationTrace instance];
    //判断是否已开始轨迹采集 如果已开始 则结束
    if (trace.state == PointState_InUse) {
        [self alertText:@"您确定要结束当前轨迹采集任务么？" sureTitle:@"确定" sureAction:^{
            [trace stop];
            //改变按钮文字
            self.traceCollectView.labels.firstObject.text = @"轨迹\n采集";
            
            // 如果是在线模式，则需要当时后台立即上传
            if (self->_mode == LineMode_on) {
                // 寻找最新一条数据
                YXTrace *trace = [YXTrace lastestRecord];
                
                //判断是否有taskid 如果没有 说明一开始就是离线模式的 存入数据库 不理会
                if (trace.userId.length == 0) {
                    [BDToastView showText:@"轨迹采集已结束"];
                    return;
                }
                //解析成tracemodel
                YXTracePointModel *model = [YXTrace decodeDataInTrace:trace];
                
                [BDToastView showActivity:@"您的采集数据正在提交中，请稍等..."];
                // 调用轨迹采集提交接口
                [YXTracePointModel saveWithBody:model completion:^(NSError * _Nonnull error) {
                    if (error) {
                        [BDToastView showText:@"提交失败，数据已转存离线轨迹采集列表中，请检查网络重新提交"];
//                        [BDToastView dismiss];
//                        [self alertText:@"提交失败，数据已转存离线轨迹采集列表中，请检查网络重新提交"];
                    }else{
                        //删除本地数据
                        [YXTrace deleteRowById:trace.rowid];
                        
                        [BDToastView showText:@"提交完成"];
                    }
                }];
            }else{
                [BDToastView showText:@"轨迹采集已结束"];
            }
        }];
        return;
    }
    else {
        if (_mode == LineMode_off) {
            //离线模式
            GPHomeTraceCollectionOfflinePopView *picker = [UINib viewForNib:NSStringFromClass(GPHomeTraceCollectionOfflinePopView.class)];
            picker.onCancel = ^{
                [self.window dismissViewAnimated:YES completion:nil];
            };
            picker.onStartCollection = ^(NSString * _Nonnull time, NSString * _Nonnull color) {
                [self.window dismissViewAnimated:YES completion:^{
                    //设置轨迹采集的时间间隔
                    trace.intervalTime = [time integerValue];
                    trace.userId = [YXUserModel currentUser].userId;
                    trace.color = color;
                    //开始轨迹采集
                    [trace start];
                    //提示
                    [BDToastView showText:@"轨迹采集已开始"];
                    //改变按钮文字
                    self.traceCollectView.labels.firstObject.text = @"结束\n采集";
                }];
            };
            [self popView:picker position:Position_Middle];
        }else{
            //在线模式
            GPHomeTraceCollectionOnlinePopView *picker = [UINib viewForNib:NSStringFromClass(GPHomeTraceCollectionOnlinePopView.class)];
            picker.onCancel = ^{
                [self.window dismissViewAnimated:YES completion:nil];
            };
            picker.onStartCollection = ^(YXProject * _Nonnull project, YXTaskModel * _Nonnull task, NSString * _Nonnull time, NSString * _Nonnull color) {
                [self.window dismissViewAnimated:YES completion:^{
                    //设置轨迹采集的时间间隔
                    trace.intervalTime = [time integerValue];
                    trace.userId = [YXUserModel currentUser].userId;
                    trace.taskId = task.taskId;
                    trace.projectId = project.projectId;
                    trace.color = color;
                    //开始轨迹采集
                    [trace start];
                    //提示
                    [BDToastView showText:@"轨迹采集已开始"];
                    //改变按钮文字
                    self.traceCollectView.labels.firstObject.text = @"结束\n采集";
                }];
            };
            [self popView:picker position:Position_Middle];
        }
    }
}

#pragma mark - 在线模式

//在线项目列表
- (IBAction)onOnlineProgramList:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    //
    [self pushViewControllerClass:GPHomeProgramListController.class inStoryboard:@"GPHome"];
}

//开始采集
- (IBAction)onOnlineStartCollection:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    // change edit mode
    self.editMode = !self.editMode;
    
    //清除浮层点
//    [[BDArcGISUtil ins] clearAllOverlaies];
}

//进入离线模式
- (IBAction)onEnterOffline:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    //清除浮层点
//    [[BDArcGISUtil ins] clearAllOverlaies];
    
    self.editMode = EditMode_off;
    self.mode = LineMode_off;
}


#pragma mark - 离线采集

//离线表单列表
- (IBAction)onOfflineForumList:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    [self pushViewControllerClass:GPOfflineForumListController.class inStoryboard:@"GPHome"];
}

//开始采集
- (IBAction)onOfflineStartCollection:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    self.editMode = !self.editMode;
    
    //清除浮层点
//    [[BDArcGISUtil ins] clearAllOverlaies];
}

//退出离线模式
- (IBAction)onQuitOffline:(UIButton *)b
{
    // dissmiss any callout
    [self.mapView.callout dismiss];
    
    //清除浮层点
//    [[BDArcGISUtil ins] clearAllOverlaies];
    
    self.editMode = EditMode_off;
    self.mode = LineMode_on;
}

@end
