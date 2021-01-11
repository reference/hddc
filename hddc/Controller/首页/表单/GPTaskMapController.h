//
//  GPTaskMapController.h
//  BDGuPiao
//
//  Created by admin on 2020/12/11.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  选择任务地图范围
#import "KKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPTaskMapController : KKBaseViewController
@property (nonatomic, strong) YXProject *projectModel;
@property (nonatomic, strong) YXTaskModel *taskModel;
@end

NS_ASSUME_NONNULL_END
