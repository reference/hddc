//
//  GPMultiTracePointsUploader.h
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  轨迹采集上传
#import <Foundation/Foundation.h>
#import "YXTrace.h"
NS_ASSUME_NONNULL_BEGIN

@interface GPMultiTracePointsUploader : NSObject
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSArray <YXTrace *> *traces;
@property (nonatomic, copy) void (^didStart)(void);
@property (nonatomic, copy) void (^didError)(NSError *error);
@property (nonatomic, copy) void (^didSuccess)(void);

- (void)startUpload;
@end

NS_ASSUME_NONNULL_END
