//
//  GPTaskQueue.h
//  BDGuPiao
//
//  Created by admin on 2020/11/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  任务队列
#import <Foundation/Foundation.h>
#import "GPTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPTaskQueue : BDModel

/// 是否有正在跑的任务
@property (nonatomic, assign) BOOL isRunningTask;

+ (GPTaskQueue *)instance;

- (void)addTask:(GPTask *)task;

- (void)removeTaskById:(NSString *)identifier;

- (void)start;

- (void)resume;

- (void)stop;
@end

NS_ASSUME_NONNULL_END
