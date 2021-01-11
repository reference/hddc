//
//  YXFormListModel.h
//  BDGuPiao
//
//  Created by admin on 2020/12/12.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  根据类型查询表单列表
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXFormListModel : NSObject
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *extends11;
@property (nonatomic, strong) NSString *extends5;
@property (nonatomic, strong) NSString *extends6;
@property (nonatomic, strong) NSString *examineDate;
@property (nonatomic, strong) NSString *reviewStatus;
@property (nonatomic, strong) NSString *extends7;
@property (nonatomic, strong) NSString *extends12;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *extends13;
@property (nonatomic, strong) NSString *extends8;
@property (nonatomic, strong) NSString *extends20;
@property (nonatomic, strong) NSString *extends9;
@property (nonatomic, strong) NSString *partionFlag;
@property (nonatomic, strong) NSString *extends14;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *extends21;
@property (nonatomic, strong) NSString *extends15;
@property (nonatomic, strong) NSString *extends22;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *extends16;
@property (nonatomic, strong) NSString *extends23;
@property (nonatomic, strong) NSString *extends30;
@property (nonatomic, strong) NSString *qualityinspectionUser;
@property (nonatomic, strong) NSString *extends24;
@property (nonatomic, strong) NSString *extends17;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *updateUser;
@property (nonatomic, strong) NSString *svylinename;
@property (nonatomic, strong) NSString *extends18;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *extends25;
@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSString *extends19;
@property (nonatomic, strong) NSString *extends26;
@property (nonatomic, strong) NSString *extends27;
@property (nonatomic, strong) NSString *extends28;
@property (nonatomic, strong) NSString *createUser;
@property (nonatomic, strong) NSString *extends29;
@property (nonatomic, strong) NSString *qualityinspectionComments;
@property (nonatomic, strong) NSString *commentInfo;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *qualityinspectionStatus;
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
@property (nonatomic, strong) NSString *extends10;
@property (nonatomic, strong) NSString *extends3;
@property (nonatomic, strong) NSString *extends4;

/// 获取表单列表
/// @param page 1
/// @param userId <#userId description#>
/// @param tid <#tid description#>
/// @param pid <#pid description#>
/// @param type 1 - 24
/// @param completion <#completion description#>
+ (void)requestProjectsWithPage:(NSInteger )page
                         userId:(NSString *)userId
                         taskId:(NSString *)tid
                     projectId:(NSString *)pid
                           type:(NSInteger)type
                     completion:(void(^)(NSArray <YXFormListModel *> *ms,NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
