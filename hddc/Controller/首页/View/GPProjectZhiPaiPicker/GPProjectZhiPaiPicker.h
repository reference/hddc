//
//  GPProjectZhiPaiPicker.h
//  BDGuPiao
//
//  Created by admin on 2020/12/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  给离线采集的表单指派项目和任务选择器
#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPProjectZhiPaiPicker : BDView

@property (nonatomic, copy) void (^onCancel) (void);
@property (nonatomic, copy) void (^onSaveLocal) (YXProject *project,YXTaskModel *task);
@property (nonatomic, copy) void (^onSubmit) (YXProject *project,YXTaskModel *task);

@end

NS_ASSUME_NONNULL_END
