//
//  GPAdministrativeDivisionsModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/25.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  获取行政区划
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPAdministrativeDivisionsModel : NSObject
//{
//divisionId: "cd726776c7de41e4a41dcdb3d90b2806",
//divisionCode: "110000",
//divisionName: "北京市",
//parentId: "root",
//allParentId: "root,cd726776c7de41e4a41dcdb3d90b2806",
//divisionLevel: "1",
//divisionType: "Municipality",
//region: "NC",
//isValid: "1",
//createUser: "c8f1ba6c7cf842409aba43206e9f7442",
//createTime: "2020-05-24 00:46:08",
//updateUser: null,
//updateTime: null
//}
@property (nonatomic, strong) NSString *divisionId;
@property (nonatomic, strong) NSString *divisionCode;
@property (nonatomic, strong) NSString *divisionName;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *allParentId;
@property (nonatomic, strong) NSString *divisionLevel;
@property (nonatomic, strong) NSString *divisionType;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, strong) NSString *createUser;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *updateUser;
@property (nonatomic, strong) NSString *updateTime;
//api
+ (void)requestADWithId:(NSString *)ids completion:(void(^)(NSArray <GPAdministrativeDivisionsModel *> *ms,NSError *error))completion;
//本地数据库查询
+ (void)requestWithParentId:(NSString *)parentId completion:(void(^)(NSArray <GPAdministrativeDivisionsModel *> *ms,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
