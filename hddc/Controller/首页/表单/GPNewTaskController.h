//
//  GPNewTaskController.h
//  BDGuPiao
//
//  Created by admin on 2020/11/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  新建任务
#import "KKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPNewTaskController : KKBaseViewController
@property (nonatomic, strong) YXProject *projectModel;

@property (nonatomic, assign) BOOL isModify; //是否修改任务
@property (nonatomic, strong) YXTaskModel *taskModel;

@end

NS_ASSUME_NONNULL_END
