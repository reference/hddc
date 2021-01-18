//
//  YXTaskModel.h
//  BDGuPiao
//
//  Created by admin on 2020/12/8.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  任务
#import <Foundation/Foundation.h>
/**
只要在自己的类中导入了BGFMDB.h这个头文件,本类就具有了存储功能.
*/
#import <BGFMDB/BGFMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXTaskModel : NSObject
/**
 * 修改人
 */
//@Column(name="update_user")
@property (nonatomic, strong) NSString *updateUser;
/**
 * 创建时间
 */
//@Column(name="create_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *createTime;
/**
 * 人员信息
 */
//@Column(name="person_ids")
@property (nonatomic, strong) NSString *personIds;
/**
 * 任务ID
 */
//@Column(name="task_id")
@property (nonatomic, strong) NSString *taskId;
/**
 * 创建人
 */
//@Column(name="create_user")
@property (nonatomic, strong) NSString *createUser;
/**
 * 地图范围
 * 规则参考BDArcGISGraphic.h - (NSString *)encode;
 */
//@Column(name="map_infos")
@property (nonatomic, strong) NSString *mapInfos;
/**
 * 任务名称
 */
//@Column(name="task_name")
@property (nonatomic, strong) NSString *taskName;
/**
 * 备选字段9
 */
//@Column(name="extends9")
@property (nonatomic, strong) NSString *extends9;
/**
 * 市
 */
//@Column(name="city")
@property (nonatomic, strong) NSString *city;
/**
 * 所属项目ID
 */
//@Column(name="belong_project_id")
@property (nonatomic, strong) NSString *belongProjectID;
/**
 * 所属项目
 */
//@Column(name="belong_project")
@property (nonatomic, strong) NSString *belongProject;
/**
 * 修改时间
 */
//@Column(name="update_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *updateTime;
/**
 * 区（县）
 */
//@Column(name="area")
@property (nonatomic, strong) NSString *area;
/**
 * 备注
 */
//@Column(name="remark")
@property (nonatomic, strong) NSString *remark;
/**
 * 省
 */
//@Column(name="province")
@property (nonatomic, strong) NSString *province;
/**
 * 备选字段3
 */
//@Column(name="extends3")
@property (nonatomic, strong) NSString *extends3;
/**
 * 删除标识
 */
//@Column(name="is_valid")
@property (nonatomic, strong) NSString *isValid;
/**
 * 备选字段4
 */
//@Column(name="extends4")
@property (nonatomic, strong) NSString *extends4;
/**
 * 分区标识
 */
//@Column(name="partion_flag")
@property (nonatomic, strong) NSString *partionFlag;
/**
 * 备选字段2
 */
//@Column(name="extends2")
@property (nonatomic, strong) NSString *extends2;
/**
 * 备选字段7
 */
//@Column(name="extends7")
@property (nonatomic, strong) NSString *extends7;
/**
 * 备选字段5
 */
//@Column(name="extends5")
@property (nonatomic, strong) NSString *extends5;
/**
 * 备选字段10
 */
//@Column(name="extends10")
@property (nonatomic, strong) NSString *extends10;
/**
 * 备选字段1
 */
//@Column(name="extends1")
@property (nonatomic, strong) NSString *extends1;
/**
 * 备选字段6
 */
//@Column(name="extends6")
@property (nonatomic, strong) NSString *extends6;
/**
 * 编号
 */
//@Id
//@Column(name="ID")
@property (nonatomic, strong) NSString *id;
/**
 * 编号
 */
//@Column(name="object_code")
@property (nonatomic, strong) NSString *objectCode;
/**
 * 备选字段8
 */
//@Column(name="extends8")
@property (nonatomic, strong) NSString *extends8;
/**
 * 村
 */
//@Column(name="village")
@property (nonatomic, strong) NSString *village;
/**
 * 乡
 */
//@Column(name="town")
@property (nonatomic, strong) NSString *town;

/// 创建新任务
/// @param body task
/// @param completion nil
+ (void)newTaskWithBody:(YXTaskModel *)body completion:(void(^)(NSError *error))completion;

/// 更新任务修改任务
/// @param body body
/// @param completion nil
+ (void)updateTaskWithBody:(YXTaskModel *)body completion:(void(^)(NSError *error))completion;
@end

@interface YXTaskApiModel : NSObject

@property (nonatomic, strong) NSArray <YXTaskModel *> *rows;
/// 获得任务列表
/// @param page start from 1
/// @param projectId 项目ID
/// @param completion nil
+ (void)requestTasksWithPage:(NSInteger )page projectId:(NSString *)projectId completion:(void(^)(YXTaskApiModel *m,NSError *error))completion;
//请求所有的
+ (void)requestAllTasksWithProjectId:(NSString *)projectId completion:(void(^)(YXTaskApiModel *m,NSError *error))completion;

/// 获取任务id
/// @param pid projectid
+ (void)requestTaskCodeByProjectId:(NSString *)pid completion:(void(^)(NSString *code,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
