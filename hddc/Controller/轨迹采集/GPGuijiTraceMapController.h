//
//  GPGuijiTraceMapController.h
//  BDGuPiao
//
//  Created by admin on 2020/12/22.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  轨迹采集回显地图
#import "KKBaseViewController.h"
#import "YXTrace.h"
NS_ASSUME_NONNULL_BEGIN

@interface GPGuijiTraceMapController : KKBaseViewController
@property (nonatomic, strong) YXTrace *traceModel;

+ (void)showFromController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
