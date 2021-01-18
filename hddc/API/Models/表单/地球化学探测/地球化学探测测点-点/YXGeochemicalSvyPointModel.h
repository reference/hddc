//
//  YXGeochemicalSvyPointModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  地球化学探测测点-点

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXGeochemicalSvyPointModel : NSObject
/**
 * 审核状态（保存）
 */
//@Column(name="review_status")
@property (nonatomic, strong) NSString *reviewStatus;
/**
 * 分区标识
 */
//@Column(name="partion_flag")
@property (nonatomic, strong) NSString *partionFlag;
/**
 * 备选字段4
 */
//@Column(name="extends4")
@property (nonatomic, strong) NSString *extends4;
/**
 * 质检状态
 */
//@Column(name="qualityinspection_status")
@property (nonatomic, strong) NSString *qualityinspectionStatus;
/**
 * 测点编号
 */
//@Id
//@Column(name="id")
@property (nonatomic, strong) NSString *id;
/**
 * 备选字段26
 */
//@Column(name="extends26")
@property (nonatomic, strong) NSString *extends26;
/**
 * 备选字段17
 */
//@Column(name="extends17")
@property (nonatomic, strong) NSString *extends17;
/**
 * 备选字段6
 */
//@Column(name="extends6")
@property (nonatomic, strong) NSString *extends6;
/**
 * 备注
 */
//@Column(name="remark")
@property (nonatomic, strong) NSString *remark;
/**
 * 备选字段29
 */
//@Column(name="extends29")
@property (nonatomic, strong) NSString *extends29;
/**
 * 备选字段21
 */
//@Column(name="extends21")
@property (nonatomic, strong) NSString *extends21;
/**
 * 备选字段1
 */
//@Column(name="extends1")
@property (nonatomic, strong) NSString *extends1;
/**
 * 备选字段19
 */
//@Column(name="extends19")
@property (nonatomic, strong) NSString *extends19;
/**
 * 备选字段7
 */
//@Column(name="extends7")
@property (nonatomic, strong) NSString *extends7;
/**
 * 审查时间
 */
//@Column(name="examine_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *examineDate;
/**
 * 质检人
 */
//@Column(name="qualityinspection_user")
@property (nonatomic, strong) NSString *qualityinspectionUser;
/**
 * 乡
 */
//@Column(name="town")
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *type;
/**
 * 质检原因
 */
//@Column(name="qualityinspection_comments")
@property (nonatomic, strong) NSString *qualityinspectionComments;
/**
 * 拐点标注名称
 */
//@Column(name="labelinfo")
@property (nonatomic, strong) NSString *labelinfo;
/**
 * 备选字段28
 */
//@Column(name="extends28")
@property (nonatomic, strong) NSString *extends28;
/**
 * 质检时间
 */
//@Column(name="qualityinspection_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *qualityinspectionDate;
/**
 * 测线编号
 */
//@Column(name="svylineid")
@property (nonatomic, strong) NSString *svylineid;
/**
 * 备选字段23
 */
//@Column(name="extends23")
@property (nonatomic, strong) NSString *extends23;
/**
 * 备选字段2
 */
//@Column(name="extends2")
@property (nonatomic, strong) NSString *extends2;
/**
 * 修改时间
 */
//@Column(name="update_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *updateTime;
/**
 * 删除标识
 */
//@Column(name="is_valid")
@property (nonatomic, strong) NSString *isValid;
/**
 * 备选字段27
 */
//@Column(name="extends27")
@property (nonatomic, strong) NSString *extends27;
/**
 * 备选字段16
 */
//@Column(name="extends16")
@property (nonatomic, strong) NSString *extends16;
/**
 * 备选字段25
 */
//@Column(name="extends25")
@property (nonatomic, strong) NSString *extends25;
/**
 * 备选字段14
 */
//@Column(name="extends14")
@property (nonatomic, strong) NSString *extends14;
/**
 * 备选字段24
 */
//@Column(name="extends24")
@property (nonatomic, strong) NSString *extends24;
/**
 * 创建人
 */
//@Column(name="create_user")
@property (nonatomic, strong) NSString *createUser;
/**
 * 备选字段30
 */
//@Column(name="extends30")
@property (nonatomic, strong) NSString *extends30;
/**
 * 野外编号
 */
//@Column(name="fieldid")
@property (nonatomic, strong) NSString *fieldid;
/**
 * 修改人
 */
//@Column(name="update_user")
@property (nonatomic, strong) NSString *updateUser;
/**
 * 审查意见
 */
//@Column(name="examine_comments")
@property (nonatomic, strong) NSString *examineComments;
/**
 * 备选字段13
 */
//@Column(name="extends13")
@property (nonatomic, strong) NSString *extends13;
/**
 * 备选字段3
 */
//@Column(name="extends3")
@property (nonatomic, strong) NSString *extends3;
/**
 * 编号
 */
//@Column(name="object_code")
@property (nonatomic, strong) NSString *objectCode;
/**
 * 备选字段20
 */
//@Column(name="extends20")
@property (nonatomic, strong) NSString *extends20;
/**
 * 区（县）
 */
//@Column(name="area")
@property (nonatomic, strong) NSString *area;
/**
 * 市
 */
//@Column(name="city")
@property (nonatomic, strong) NSString *city;
/**
 * 村
 */
//@Column(name="village")
@property (nonatomic, strong) NSString *village;
/**
 * 创建时间
 */
//@Column(name="create_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *createTime;
/**
 * 备选字段15
 */
//@Column(name="extends15")
@property (nonatomic, strong) NSString *extends15;
/**
 * 备选字段9
 */
//@Column(name="extends9")
@property (nonatomic, strong) NSString *extends9;
/**
 * 备选字段5
 */
//@Column(name="extends5")
@property (nonatomic, strong) NSString *extends5;
/**
 * 备注
 */
//@Column(name="comment_info")
@property (nonatomic, strong) NSString *commentInfo;
/**
 * 任务名称
 */
//@Column(name="task_name")
@property (nonatomic, strong) NSString *taskName;
/**
 * 备选字段22
 */
//@Column(name="extends22")
@property (nonatomic, strong) NSString *extends22;
/**
 * 审查人
 */
//@Column(name="examine_user")
@property (nonatomic, strong) NSString *examineUser;
/**
 * 备选字段8
 */
//@Column(name="extends8")
@property (nonatomic, strong) NSString *extends8;
/**
 * 任务ID
 */
//@Column(name="task_id")
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *projectcode;
/**
 * 项目ID
 */
//@Column(name="project_id")
@property (nonatomic, strong) NSString *projectId;
/**
 * 备选字段10
 */
//@Column(name="extends10")
@property (nonatomic, strong) NSString *extends10;
/**
 * 探测方法
 */
//@Column(name="svymethod")
@property (nonatomic, strong) NSString *svymethod;
@property (nonatomic, strong) NSString *svymethodName;
/**
 * 省
 */
//@Column(name="province")
@property (nonatomic, strong) NSString *province;
/**
 * 备选字段18
 */
//@Column(name="extends18")
@property (nonatomic, strong) NSString *extends18;
/**
 * 备选字段11
 */
//@Column(name="extends11")
@property (nonatomic, strong) NSString *extends11;
/**
 * 备选字段12
 */
//@Column(name="extends12")
@property (nonatomic, strong) NSString *extends12;
/**
 * 项目名称
 */
//@Column(name="project_name")
@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *userId;

/// 保存
/// ////////////@param body body
/// ////////////@param completion nil
+ (void)saveWithBody:(YXGeochemicalSvyPointModel *)body completion:(void(^)(NSError *error))completion;

//查询详情
+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXGeochemicalSvyPointModel *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
