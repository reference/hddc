//
//  GPArcGisMapController.h
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  arcgis地图
#import "KKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPArcGisMapController : KKBaseViewController
//set map info
@property (nonatomic, strong) NSString *mapInfo;
/// mapinfo
@property (nonatomic, copy) void (^selectedMapCallback) (NSString *mapInfo);
@end

NS_ASSUME_NONNULL_END
