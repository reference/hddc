//
//  YXTrenchModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  探槽-点
//  http://192.168.1.136:8087/hddc/hddcWyTrenchs/88999ee4276e4f97977f887b47b08ced

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXTrenchModel : NSObject
@property (nonatomic, strong) NSString *town; //详细地址
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *profile2photoArwid;
@property (nonatomic, strong) NSString *trenchsource;
@property (nonatomic, strong) NSString *trenchsourceName;
@property (nonatomic, strong) NSString *reviewStatus;
@property (nonatomic, strong) NSString *extends21;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *extends10;
@property (nonatomic, strong) NSString *locationname;
@property (nonatomic, strong) NSString *extends24;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *extends2;
@property (nonatomic, strong) NSString *eqeventcount;
@property (nonatomic, strong) NSString *geologysvyprojectid;
@property (nonatomic, strong) NSString *extends13;
@property (nonatomic, strong) NSString *extends5;
@property (nonatomic, strong) NSString *extends27;
@property (nonatomic, strong) NSString *profile2photoAiid;
@property (nonatomic, strong) NSString *extends8;
@property (nonatomic, strong) NSString *extends16;
@property (nonatomic, strong) NSString *targetfaultname;
@property (nonatomic, strong) NSString *objectCode;
@property (nonatomic, strong) NSString *profile1photoArwid;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *depth;
@property (nonatomic, strong) NSString *extends19;
@property (nonatomic, strong) NSString *profile2Arwid;
@property (nonatomic, strong) NSString *updateUser;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *collectedtrenchsource;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *extends20;
@property (nonatomic, strong) NSString *examineUser;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *extends23;
@property (nonatomic, strong) NSString *geomophenv;
@property (nonatomic, strong) NSString *latesteqperoidest;
@property (nonatomic, strong) NSString *extends3;
@property (nonatomic, strong) NSString *extends12;
@property (nonatomic, strong) NSString *extends26;
@property (nonatomic, strong) NSString *qualityinspectionUser;
@property (nonatomic, strong) NSString *targetfaultsource;
@property (nonatomic, strong) NSString *targetfaultsourceName;
@property (nonatomic, strong) NSString *photoArwid;
@property (nonatomic, strong) NSString *profile2commentArwid;
@property (nonatomic, strong) NSString *extends6;
@property (nonatomic, strong) NSString *createUser;
@property (nonatomic, strong) NSString *photoviewingto;
@property (nonatomic, strong) NSString *photoviewingtoName;
@property (nonatomic, strong) NSString *fieldid;
@property (nonatomic, strong) NSString *extends15;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *profile1Arwid;
@property (nonatomic, strong) NSString *extends9;
@property (nonatomic, strong) NSString *photoAiid;
@property (nonatomic, strong) NSString *extends29;
@property (nonatomic, strong) NSString *samplecount;
@property (nonatomic, strong) NSString *extends18;
@property (nonatomic, strong) NSString *elevation;
@property (nonatomic, strong) NSString *village;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *profile2commentArid;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *extends30;
@property (nonatomic, strong) NSString *exposedstratumcount;
@property (nonatomic, strong) NSString *profile1Aiid;
@property (nonatomic, strong) NSString *profile1commentArid;
@property (nonatomic, strong) NSString *collectedsamplecount;
@property (nonatomic, strong) NSString *lastangle;
@property (nonatomic, strong) NSString *profile1commentArwid;
@property (nonatomic, strong) NSString *datingsamplecount;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *extends22;
@property (nonatomic, strong) NSString *targetfaultid;
@property (nonatomic, strong) NSString *qualityinspectionDate;
@property (nonatomic, strong) NSString *extends1;
@property (nonatomic, strong) NSString *latesteqperoider;
@property (nonatomic, strong) NSString *extends11;
@property (nonatomic, strong) NSString *qualityinspectionStatus;
@property (nonatomic, strong) NSString *profile1photoAiid;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *qualityinspectionComments;
@property (nonatomic, strong) NSString *extends4;
@property (nonatomic, strong) NSString *extends25;
@property (nonatomic, strong) NSString *trenchdip;
@property (nonatomic, strong) NSString *examineDate;
@property (nonatomic, strong) NSString *extends14;
@property (nonatomic, strong) NSString *extends7;
@property (nonatomic, strong) NSString *extends28;
@property (nonatomic, strong) NSString *profile2Aiid;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *extends17;
@property (nonatomic, strong) NSString *commentInfo;
@property (nonatomic, strong) NSString *examineComments;
@property (nonatomic, strong) NSString *photographer;
@property (nonatomic, strong) NSString *partionFlag;
@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSString *userId;

/// 保存
/// @param body body
/// @param completion nil
+ (void)saveWithBody:(YXTrenchModel *)body completion:(void(^)(NSError *error))completion;

//查询详情
+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXTrenchModel *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
