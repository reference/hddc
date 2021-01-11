//
//  YXTrace.h
//  BDGuPiao
//
//  Created by admin on 2020/12/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  轨迹追踪模型
#import "BGFMDB.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXTrace : NSObject

/// rowid
@property (nonatomic, strong) NSString *rowid;

/// 所属的用户
@property (nonatomic, strong) NSString *userId;

/// task id
@property (nonatomic, strong) NSString *taskId;

/// project id
@property (nonatomic, strong) NSString *projectId;

/// type 从1到24 表单类型
@property (nonatomic, assign) NSInteger type;

/// 创建日期
@property (nonatomic, strong) NSDate *createDate;

/// 线条颜色
@property (nonatomic, strong) NSString *color;

/// 修改日期
@property (nonatomic, strong) NSDate *updateDate;

/// YXTracePointModel 对象
@property (nonatomic, strong) NSString *pointsData;


/// 获得最新创建的记录
+ (id)lastestRecord;

+ (NSArray <YXTrace *> *)findTraceWithoutBelongByUserId:(NSString *)uId;

/// 根据row id删除
/// @param rowId rowid
+ (BOOL)deleteRowById:(NSString *)rowId;

/// 解码
/// @param tb trace
+ (YXTracePointModel *)decodeDataInTrace:(YXTrace *)tb;

/// 转换成AGSPoint数组
- (NSArray <AGSPoint *> *)toAGSPoints;
@end

NS_ASSUME_NONNULL_END
