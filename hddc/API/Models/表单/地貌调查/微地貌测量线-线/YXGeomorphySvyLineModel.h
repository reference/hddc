//
//  YXGeomorphySvyLineModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  微地貌测量线-线

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXGeomorphySvyLineModel : NSObject
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;
/**
 * 编号
 */
//@Column(name="object_code")
@property (nonatomic, strong) NSString *objectCode;
/**
 * 创建时间
 */
//@Column(name="create_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *createTime;
/**
 * 备选字段27
 */
//@Column(name="extends27")
@property (nonatomic, strong) NSString *extends27;
/**
 * 备选字段24
 */
//@Column(name="extends24")
@property (nonatomic, strong) NSString *extends24;
/**
 * 备选字段25
 */
//@Column(name="extends25")
@property (nonatomic, strong) NSString *extends25;
/**
 * 典型照片原始文件编号
 */
//@Column(name="photo_arwid")
@property (nonatomic, strong) NSString *photoArwid;
/**
 * 拍摄者
 */
//@Column(name="photographer")
@property (nonatomic, strong) NSString *photographer;
/**
 * 分区标识
 */
//@Column(name="partion_flag")
@property (nonatomic, strong) NSString *partionFlag;
/**
 * 备注
 */
//@Column(name="remark")
@property (nonatomic, strong) NSString *remark;
/**
 * 备选字段12
 */
//@Column(name="extends12")
@property (nonatomic, strong) NSString *extends12;
/**
 * 任务ID
 */
//@Column(name="task_id")
@property (nonatomic, strong) NSString *taskId;
/**
 * 照片镜向
 */
//@Column(name="photoviewingto")
@property (nonatomic, strong) NSString *photoviewingto;
@property (nonatomic, strong) NSString *photoviewingtoName;
/**
 * 典型照片文件编号
 */
//@Column(name="photo_aiid")
@property (nonatomic, strong) NSString *photoAiid;
/**
 * 备选字段4
 */
//@Column(name="extends4")
@property (nonatomic, strong) NSString *extends4;
/**
 * 修改时间
 */
//@Column(name="update_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *updateTime;
/**
 * 备选字段16
 */
//@Column(name="extends16")
@property (nonatomic, strong) NSString *extends16;
/**
 * 质检时间
 */
//@Column(name="qualityinspection_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *qualityinspectionDate;
/**
 * 剖面线分析结果图原始文件编号
 */
//@Column(name="profile_arwid")
@property (nonatomic, strong) NSString *profileArwid;
/**
 * 备选字段18
 */
//@Column(name="extends18")
@property (nonatomic, strong) NSString *extends18;
/**
 * 删除标识
 */
//@Column(name="is_valid")
@property (nonatomic, strong) NSString *isValid;
/**
 * 质检状态
 */
//@Column(name="qualityinspection_status")
@property (nonatomic, strong) NSString *qualityinspectionStatus;
/**
 * 任务名称
 */
//@Column(name="task_name")
@property (nonatomic, strong) NSString *taskName;
/**
 * 项目名称
 */
//@Column(name="project_name")
@property (nonatomic, strong) NSString *projectName;
/**
 * 备选字段7
 */
//@Column(name="extends7")
@property (nonatomic, strong) NSString *extends7;
/**
 * 备选字段21
 */
//@Column(name="extends21")
@property (nonatomic, strong) NSString *extends21;
/**
 * 区（县）
 */
//@Column(name="area")
@property (nonatomic, strong) NSString *area;
/**
 * 审核状态（保存）
 */
//@Column(name="review_status")
@property (nonatomic, strong) NSString *reviewStatus;
/**
 * 备选字段11
 */
//@Column(name="extends11")
@property (nonatomic, strong) NSString *extends11;
/**
 * 剖面线分析结果图图像文件编号
 */
//@Column(name="profile_aiid")
@property (nonatomic, strong) NSString *profileAiid;
/**
 * 备选字段10
 */
//@Column(name="extends10")
@property (nonatomic, strong) NSString *extends10;
/**
 * 乡
 */
//@Column(name="town")
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *type;
/**
 * 备选字段23
 */
//@Column(name="extends23")
@property (nonatomic, strong) NSString *extends23;
/**
 * 备选字段1
 */
//@Column(name="extends1")
@property (nonatomic, strong) NSString *extends1;
/**
 * 备选字段15
 */
//@Column(name="extends15")
@property (nonatomic, strong) NSString *extends15;
/**
 * 备选字段8
 */
//@Column(name="extends8")
@property (nonatomic, strong) NSString *extends8;
/**
 * 备选字段14
 */
//@Column(name="extends14")
@property (nonatomic, strong) NSString *extends14;
/**
 * 备选字段28
 */
//@Column(name="extends28")
@property (nonatomic, strong) NSString *extends28;
/**
 * 备选字段20
 */
//@Column(name="extends20")
@property (nonatomic, strong) NSString *extends20;
/**
 * 备选字段9
 */
//@Column(name="extends9")
@property (nonatomic, strong) NSString *extends9;
/**
 * 备选字段26
 */
//@Column(name="extends26")
@property (nonatomic, strong) NSString *extends26;
/**
 * 审查人
 */
//@Column(name="examine_user")
@property (nonatomic, strong) NSString *examineUser;
/**
 * 备选字段5
 */
//@Column(name="extends5")
@property (nonatomic, strong) NSString *extends5;
/**
 * 备选字段29
 */
//@Column(name="extends29")
@property (nonatomic, strong) NSString *extends29;
/**
 * 备选字段6
 */
//@Column(name="extends6")
@property (nonatomic, strong) NSString *extends6;
/**
 * 创建人
 */
//@Column(name="create_user")
@property (nonatomic, strong) NSString *createUser;
/**
 * 备选字段17
 */
//@Column(name="extends17")
@property (nonatomic, strong) NSString *extends17;
/**
 * 审查意见
 */
//@Column(name="examine_comments")
@property (nonatomic, strong) NSString *examineComments;
/**
 * 野外编号
 */
//@Column(name="fieldid")
@property (nonatomic, strong) NSString *fieldid;
/**
 * 市
 */
//@Column(name="city")
@property (nonatomic, strong) NSString *city;
/**
 * 备选字段2
 */
//@Column(name="extends2")
@property (nonatomic, strong) NSString *extends2;
/**
 * 备选字段19
 */
//@Column(name="extends19")
@property (nonatomic, strong) NSString *extends19;
/**
 * 审查时间
 */
//@Column(name="examine_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *examineDate;
/**
 * 测线名称
 */
//@Column(name="name")
@property (nonatomic, strong) NSString *name;
/**
 * 项目ID
 */
//@Column(name="project_id")
@property (nonatomic, strong) NSString *projectId;
/**
 * 修改人
 */
//@Column(name="update_user")
@property (nonatomic, strong) NSString *updateUser;
/**
 * 测线编号
 */
//@Id
//@Column(name="id")
@property (nonatomic, strong) NSString *id;
/**
 * 村
 */
//@Column(name="village")
@property (nonatomic, strong) NSString *village;
/**
 * 备选字段3
 */
//@Column(name="extends3")
@property (nonatomic, strong) NSString *extends3;
/**
 * 备选字段13
 */
//@Column(name="extends13")
@property (nonatomic, strong) NSString *extends13;
/**
 * 备选字段22
 */
//@Column(name="extends22")
@property (nonatomic, strong) NSString *extends22;
/**
 * 微地貌测量工程编号
 */
//@Column(name="geomorphysvyprjid")
@property (nonatomic, strong) NSString *geomorphysvyprjid;
/**
 * 质检原因
 */
//@Column(name="qualityinspection_comments")
@property (nonatomic, strong) NSString *qualityinspectionComments;
/**
 * 质检人
 */
//@Column(name="qualityinspection_user")
@property (nonatomic, strong) NSString *qualityinspectionUser;
/**
 * 备注-测量线描述及目的
 */
//@Column(name="comment_info")
@property (nonatomic, strong) NSString *commentInfo;
/**
 * 备选字段30
 */
//@Column(name="extends30")
@property (nonatomic, strong) NSString *extends30;
/**
 * 省
 */
//@Column(name="province")
@property (nonatomic, strong) NSString *province;

//@property (nonatomic, strong) NSString *lon;

//@property (nonatomic, strong) NSString *lat;

/// 保存
/// ////@param body body
/// ////@param completion nil
+ (void)saveWithBody:(YXGeomorphySvyLineModel *)body completion:(void(^)(NSError *error))completion;

//查询详情
+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXGeomorphySvyLineModel *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
