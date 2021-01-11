//
//  YXGeologicalSvyPlanningPtModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  地质调查规划点-点
//  http://192.168.1.136:8087/hddc/hddcWyGeologicalsvyplanningpts/7ef8ca316def452a987d2910a94f976a
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXGeologicalSvyPlanningPtModel : NSObject
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *extends11;
@property (nonatomic, strong) NSString *extends5;
@property (nonatomic, strong) NSString *extends6;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *examineDate;
@property (nonatomic, strong) NSString *extends7;
@property (nonatomic, strong) NSString *extends12;
@property (nonatomic, strong) NSString *reviewStatus;
@property (nonatomic, strong) NSString *extends8;
@property (nonatomic, strong) NSString *extends13;
@property (nonatomic, strong) NSString *partionFlag;
@property (nonatomic, strong) NSString *extends20;
@property (nonatomic, strong) NSString *extends9;
@property (nonatomic, strong) NSString *extends14;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *extends21;
@property (nonatomic, strong) NSString *extends15;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *extends22;
@property (nonatomic, strong) NSString *extends23;
@property (nonatomic, strong) NSString *extends30;
@property (nonatomic, strong) NSString *extends16;
@property (nonatomic, strong) NSString *qualityinspectionUser;
@property (nonatomic, strong) NSString *svylineid;
@property (nonatomic, strong) NSString *extends17;
@property (nonatomic, strong) NSString *updateUser;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *extends24;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *extends25;
@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSString *extends18;
@property (nonatomic, strong) NSString *extends26;
@property (nonatomic, strong) NSString *extends19;
@property (nonatomic, strong) NSString *extends27;
@property (nonatomic, strong) NSString *extends28;
@property (nonatomic, strong) NSString *createUser;
@property (nonatomic, strong) NSString *extends29;
@property (nonatomic, strong) NSString *qualityinspectionComments;
@property (nonatomic, strong) NSString *qualityinspectionStatus;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, strong) NSString *purpose;
@property (nonatomic, strong) NSString *examineComments;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSString *village;
@property (nonatomic, strong) NSString *svymethods;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *examineUser;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *extends1;
@property (nonatomic, strong) NSString *extends2;
@property (nonatomic, strong) NSString *objectCode;
@property (nonatomic, strong) NSString *qualityinspectionDate;
@property (nonatomic, strong) NSString *extends3;
@property (nonatomic, strong) NSString *extends10;
@property (nonatomic, strong) NSString *extends4;

/// 保存
/// @param body body
/// @param completion nil
+ (void)saveWithBody:(YXGeologicalSvyPlanningPtModel *)body completion:(void(^)(NSError *error))completion;
//查询详情
+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXGeologicalSvyPlanningPtModel *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
