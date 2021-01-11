//
//  GPHomeOnlinePicker.h
//  BDGuPiao
//
//  Created by admin on 2020/12/26.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  首页在线采集弹出框
#import <BDToolKit/BDToolKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPHomeOnlinePicker : BDView
@property (nonatomic, copy) void (^onCancel) (void);

///返回
@property (nonatomic, copy) void (^onDone) (YXProject *project,YXTaskModel *task,NSString *forumType);
@end

NS_ASSUME_NONNULL_END
