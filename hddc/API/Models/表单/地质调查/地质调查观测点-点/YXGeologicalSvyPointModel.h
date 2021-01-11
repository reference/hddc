//
//  YXGeologicalSvyPointModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  地质调查观测点-点

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXGeologicalSvyPointModel : NSObject
/**
 * 是否在图中显示
 *
@Column(name="isinmap")
*/
@property (nonatomic, strong) NSString *isinmap;
/**
 * 备选字段1
 *
@Column(name="extends1")*/
@property (nonatomic, strong) NSString *extends1;
/**
 * 备选字段14
 *
@Column(name="extends14")*/
@property (nonatomic, strong) NSString *extends14;
/**
 * 备选字段16
 *
@Column(name="extends16")*/
@property (nonatomic, strong) NSString *extends16;
/**
 * 观测方法
 *
@Column(name="svymethods")*/
@property (nonatomic, strong) NSString *svymethods;
/**
 * 省
 *
@Column(name="province")*/
@property (nonatomic, strong) NSString *province;
/**
 * 审核状态（保存）
 *
@Column(name="review_status")*/
@property (nonatomic, strong) NSString *reviewStatus;
/**
 * 编号
 *
@Column(name="object_code")*/
@property (nonatomic, strong) NSString *objectCode;
/**
 * 观测目的
 *
@Column(name="purpose")*/
@property (nonatomic, strong) NSString *purpose;
/**
 * 观测点描述
 *
@Column(name="spcomment_info")*/
@property (nonatomic, strong) NSString *spcommentInfo;
/**
 * 审查人
 *
@Column(name="examine_user")*/
@property (nonatomic, strong) NSString *examineUser;
/**
 * 备选字段8
 *
@Column(name="extends8")*/
@property (nonatomic, strong) NSString *extends8;
/**
 * 纬度
 *
@Column(name="lat")*/
@property (nonatomic, strong) NSString *lat;
/**
 * 备选字段28
 *
@Column(name="extends28")*/
@property (nonatomic, strong) NSString *extends28;
/**
 * 海拔高度 [米]
 *
@Column(name="elevation")*/
@property (nonatomic, strong) NSString *elevation;
/**
 * 分区标识
 *
@Column(name="partion_flag")*/
@property (nonatomic, strong) NSString *partionFlag;
/**
 * 观测点野外编号
 *
@Column(name="fieldid")*/
@property (nonatomic, strong) NSString *fieldid;
/**
 * 备注
 *
@Column(name="remark")*/
@property (nonatomic, strong) NSString *remark;
/**
 * 观测点编号
 *
@Id
@Column(name="id")*/
@property (nonatomic, strong) NSString *id;
/**
 * 典型照片原始文件编号
 *
@Column(name="photo_arwid")*/
@property (nonatomic, strong) NSString *photoArwid;
/**
 * 任务ID
 *
@Column(name="task_id")*/
@property (nonatomic, strong) NSString *taskId;
/**
 * 备选字段22
 *
@Column(name="extends22")*/
@property (nonatomic, strong) NSString *extends22;
/**
 * 是否地貌点
 *
@Column(name="isgeomorphpoint")*/
@property (nonatomic, strong) NSString *isgeomorphpoint;
/**
 * 备选字段18
 *
@Column(name="extends18")*/
@property (nonatomic, strong) NSString *extends18;
/**
 * 拍摄者
 *
@Column(name="photographer")*/
@property (nonatomic, strong) NSString *photographer;
/**
 * 修改时间
 *
@Column(name="update_time")
@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")*/
@property (nonatomic, strong) NSString *updateTime;
/**
 * 质检原因
 *
@Column(name="qualityinspection_comments")*/
@property (nonatomic, strong) NSString *qualityinspectionComments;
/**
 * 任务名称
 *
@Column(name="task_name")*/
@property (nonatomic, strong) NSString *taskName;
/**
 * 典型照片文件编号
 *
@Column(name="photo_aiid")*/
@property (nonatomic, strong) NSString *photoAiid;
/**
 * 备选字段19
 *
@Column(name="extends19")*/
@property (nonatomic, strong) NSString *extends19;
/**
 * 备选字段10
 *
@Column(name="extends10")*/
@property (nonatomic, strong) NSString *extends10;
/**
 * 备选字段20
 *
@Column(name="extends20")*/
@property (nonatomic, strong) NSString *extends20;
/**
 * 备选字段11
 *
@Column(name="extends11")*/
@property (nonatomic, strong) NSString *extends11;
/**
 * 地质剖面线编号
 *
@Column(name="profilesvylineid")*/
@property (nonatomic, strong) NSString *profilesvylineid;
/**
 * 是否断点
 *
@Column(name="isfaultpoint")*/
@property (nonatomic, strong) NSString *isfaultpoint;
/**
 * 备选字段27
 *
@Column(name="extends27")*/
@property (nonatomic, strong) NSString *extends27;
/**
 * 备选字段25
 *
@Column(name="extends25")*/
@property (nonatomic, strong) NSString *extends25;
/**
 * 备选字段12
 *
@Column(name="extends12")*/
@property (nonatomic, strong) NSString *extends12;
/**
 * 质检时间
 *
@Column(name="qualityinspection_date")
@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")*/
@property (nonatomic, strong) NSString *qualityinspectionDate;
/**
 * 区（县）
 *
@Column(name="area")*/
@property (nonatomic, strong) NSString *area;
/**
 * 照片镜向
 *
@Column(name="photoviewingto")*/
@property (nonatomic, strong) NSString *photoviewingto;
@property (nonatomic, strong) NSString *photoviewingtoName;
/**
 * 采集样品总数
 *
@Column(name="collectedsamplecount")*/
@property (nonatomic, strong) NSString *collectedsamplecount;
/**
 * 备注
 *
@Column(name="comment_info")*/
@property (nonatomic, strong) NSString *commentInfo;
/**
 * 备选字段5
 *
@Column(name="extends5")*/
@property (nonatomic, strong) NSString *extends5;
/**
 * 市
 *
@Column(name="city")*/
@property (nonatomic, strong) NSString *city;
/**
 * 备选字段4
 *
@Column(name="extends4")*/
@property (nonatomic, strong) NSString *extends4;
/**
 * 项目ID
 *
@Column(name="project_id")*/
@property (nonatomic, strong) NSString *projectId;
/**
 * 乡
 *
@Column(name="town")*/
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *type;
/**
 * 质检状态
 *
@Column(name="qualityinspection_status")*/
@property (nonatomic, strong) NSString *qualityinspectionStatus;
/**
 * 备选字段3
 *
@Column(name="extends3")*/
@property (nonatomic, strong) NSString *extends3;
/**
 * 创建时间
 *
@Column(name="create_time")
@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")*/
@property (nonatomic, strong) NSString *createTime;
/**
 * 审查意见
 *
@Column(name="examine_comments")*/
@property (nonatomic, strong) NSString *examineComments;
/**
 * 备选字段17
 *
@Column(name="extends17")*/
@property (nonatomic, strong) NSString *extends17;
/**
 * 备选字段21
 *
@Column(name="extends21")*/
@property (nonatomic, strong) NSString *extends21;
/**
 * 修改人
 *
@Column(name="update_user")*/
@property (nonatomic, strong) NSString *updateUser;
/**
 * 备选字段24
 *
@Column(name="extends24")*/
@property (nonatomic, strong) NSString *extends24;
/**
 * 获得测试结果样品数
 *
@Column(name="datingsamplecount")*/
@property (nonatomic, strong) NSString *datingsamplecount;
/**
 * 审查时间
 *
@Column(name="examine_date")
@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")*/
@property (nonatomic, strong) NSString *examineDate;
/**
 * 村
 *
@Column(name="village")*/
@property (nonatomic, strong) NSString *village;
/**
 * 备选字段23
 *
@Column(name="extends23")*/
@property (nonatomic, strong) NSString *extends23;
/**
 * 备选字段30
 *
@Column(name="extends30")*/
@property (nonatomic, strong) NSString *extends30;
/**
 * 备选字段6
 *
@Column(name="extends6")*/
@property (nonatomic, strong) NSString *extends6;
/**
 * 备选字段15
 *
@Column(name="extends15")*/
@property (nonatomic, strong) NSString *extends15;
/**
 * 备选字段29
 *
@Column(name="extends29")*/
@property (nonatomic, strong) NSString *extends29;
/**
 * 备选字段2
 *
@Column(name="extends2")*/
@property (nonatomic, strong) NSString *extends2;
/**
 * 观测点地名
 *
@Column(name="locationname")*/
@property (nonatomic, strong) NSString *locationname;
/**
 * 备选字段26
 *
@Column(name="extends26")*/
@property (nonatomic, strong) NSString *extends26;
/**
 * 质检人
 *
@Column(name="qualityinspection_user")*/
@property (nonatomic, strong) NSString *qualityinspectionUser;
/**
 * 工程编号
 *
@Column(name="projectid")*/
@property (nonatomic, strong) NSString *projectid;
/**
 * 备选字段9
 *
@Column(name="extends9")*/
@property (nonatomic, strong) NSString *extends9;
/**
 * 创建人
 *
@Column(name="create_user")*/
@property (nonatomic, strong) NSString *createUser;
/**
 * 备选字段7
 *
@Column(name="extends7")*/
@property (nonatomic, strong) NSString *extends7;
/**
 * 经度
 *
@Column(name="lon")*/
@property (nonatomic, strong) NSString *lon;
/**
 * 送样总数
 *
@Column(name="samplecount")*/
@property (nonatomic, strong) NSString *samplecount;
/**
 * 项目名称
 *
@Column(name="project_name")*/
@property (nonatomic, strong) NSString *projectName;
/**
 * 删除标识
 *
@Column(name="is_valid")*/
@property (nonatomic, strong) NSString *isValid;
/**
 * 观测日期
 *
@Column(name="svydate")*/
@property (nonatomic, strong) NSString *svydate;
/**
 * 备选字段13
 *
@Column(name="extends13")*/
@property (nonatomic, strong) NSString *extends13;
/**
 * 是否地层点
 *
@Column(name="isstratigraphypoint")*/
@property (nonatomic, strong) NSString *isstratigraphypoint;
@property (nonatomic, strong) NSString *userId;

/// 保存
/// @param body body
/// @param completion nil
+ (void)saveWithBody:(YXGeologicalSvyPointModel *)body completion:(void(^)(NSError *error))completion;

//查询详情
+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXGeologicalSvyPointModel *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
