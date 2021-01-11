//
//  YXProjectModel.h
//  BDGuPiao
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  项目
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXProject : NSObject
@property (nonatomic, strong) NSString *extends7;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSString *projectInfo;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *updateUser;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *extends4;
@property (nonatomic, strong) NSString *extends8;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *extends1;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *personIds;
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *extends5;
@property (nonatomic, strong) NSString *village;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *extends9;
@property (nonatomic, strong) NSString *extends10;
@property (nonatomic, strong) NSString *partionFlag;
@property (nonatomic, strong) NSString *extends2;
@property (nonatomic, strong) NSString *extends6;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *objectCode;
@property (nonatomic, strong) NSString *createUser;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *extends3;
@end

@interface YXProjectModel : NSObject
@property (nonatomic, strong) NSArray <YXProject *> *rows;
@property (nonatomic, assign) NSInteger total;

/// 根据人员ID获取所有项目
/// @param page 1
/// @param personId persion id
/// @param completion <#completion description#>
+ (void)requestProjectsWithPage:(NSInteger )page personId:(NSString *)personId completion:(void(^)(YXProjectModel *m,NSError *error))completion;
+ (void)requestAllProjectWithPersonId:(NSString *)personId completion:(void(^)(YXProjectModel *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
