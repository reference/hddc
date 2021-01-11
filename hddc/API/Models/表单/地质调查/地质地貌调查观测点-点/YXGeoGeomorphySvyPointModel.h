//
//  YXGeoGeomorphySvyPointModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  地质地貌调查观测点-点
//  http://192.168.1.136:8087/hddc/hddcWyGeomorstations/4048dec50c244087be082b96c608411d

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXGeoGeomorphySvyPointModel : NSObject
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;

/**
 * 修改人
 */
//@Column(name="update_user")
@property (nonatomic, strong) NSString *updateUser;
/**
 * 备选字段12
 */
//@Column(name="extends12")
@property (nonatomic, strong) NSString *extends12;
/**
 * 备选字段10
 */
//@Column(name="extends10")
@property (nonatomic, strong) NSString *extends10;
/**
 * 垂直位移 [米]
 */
//@Column(name="verticaldisplacement")
@property (nonatomic, strong) NSString * verticaldisplacement;
/**
 * 性质
 */
//@Column(name="feature")
@property (nonatomic, strong) NSString *feature;
/**
 * 备选字段25
 */
//@Column(name="extends25")
@property (nonatomic, strong) NSString *extends25;
/**
 * 修改时间
 */
//@Column(name="update_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *updateTime;
/**
 * 备选字段6
 */
//@Column(name="extends6")
@property (nonatomic, strong) NSString *extends6;
/**
 * 典型照片原始文件编号
 */
//@Column(name="photo_arwid")
@property (nonatomic, strong) NSString *photoArwid;
/**
 * 市
 */
//@Column(name="city")
@property (nonatomic, strong) NSString *city;
/**
 * 备选字段23
 */
//@Column(name="extends23")
@property (nonatomic, strong) NSString *extends23;
/**
 * 地质调查观测点编号
 */
//@Column(name="geologicalsvypointid")
@property (nonatomic, strong) NSString *geologicalsvypointid;
/**
 * 备选字段5
 */
//@Column(name="extends5")
@property (nonatomic, strong) NSString *extends5;
/**
 * 质检人
 */
//@Column(name="qualityinspection_user")
@property (nonatomic, strong) NSString *qualityinspectionUser;
/**
 * 地震地表破裂类型
 */
//@Column(name="fracturetype")
@property (nonatomic, strong) NSString *fracturetype;
@property (nonatomic, strong) NSString *fracturetypeName;
/**
 * 备选字段1
 */
//@Column(name="extends1")
@property (nonatomic, strong) NSString *extends1;
/**
 * 水平//张缩位移 [米]
 */
//@Column(name="tensiondisplacement")
@property (nonatomic, strong) NSString * tensiondisplacement;
/**
 * 质检原因
 */
//@Column(name="qualityinspection_comments")
@property (nonatomic, strong) NSString *qualityinspectionComments;
/**
 * 项目ID
 */
//@Column(name="project_id")
@property (nonatomic, strong) NSString *projectId;
/**
 * 备注
 */
//@Column(name="remark")
@property (nonatomic, strong) NSString *remark;
/**
 * 典型照片文件编号
 */
//@Column(name="photo_aiid")
@property (nonatomic, strong) NSString *photoAiid;
/**
 * 审查人
 */
//@Column(name="examine_user")
@property (nonatomic, strong) NSString *examineUser;
/**
 * 地表破裂（断塞塘等）宽 [米]
 */
//@Column(name="width")
@property (nonatomic, strong) NSString * width;
/**
 * 照片镜向
 */
//@Column(name="photoviewingto")
@property (nonatomic, strong) NSString *photoviewingto;
@property (nonatomic, strong) NSString *photoviewingtoName;
/**
 * 符号或标注旋转角度
 */
//@Column(name="lastangle")
@property (nonatomic, strong) NSString * lastangle;
/**
 * 备选字段24
 */
//@Column(name="extends24")
@property (nonatomic, strong) NSString *extends24;
/**
 * 备选字段29
 */
//@Column(name="extends29")
@property (nonatomic, strong) NSString *extends29;
/**
 * 备选字段18
 */
//@Column(name="extends18")
@property (nonatomic, strong) NSString *extends18;
/**
 * 观测点野外编号
 */
//@Column(name="fieldid")
@property (nonatomic, strong) NSString *fieldid;
/**
 * 备选字段17
 */
//@Column(name="extends17")
@property (nonatomic, strong) NSString *extends17;
/**
 * 备选字段21
 */
//@Column(name="extends21")
@property (nonatomic, strong) NSString *extends21;
/**
 * 任务ID
 */
//@Column(name="task_id")
@property (nonatomic, strong) NSString *taskId;
/**
 * 分区标识
 */
//@Column(name="partion_flag")
@property (nonatomic, strong) NSString *partionFlag;
/**
 * 备选字段16
 */
//@Column(name="extends16")
@property (nonatomic, strong) NSString *extends16;
/**
 * 备选字段8
 */
//@Column(name="extends8")
@property (nonatomic, strong) NSString *extends8;
/**
 * 备选字段4
 */
//@Column(name="extends4")
@property (nonatomic, strong) NSString *extends4;
/**
 * 典型剖面图原始文件编号
 */
//@Column(name="typicalprofile_arwid")
@property (nonatomic, strong) NSString *typicalprofileArwid;
/**
 * 备选字段9
 */
//@Column(name="extends9")
@property (nonatomic, strong) NSString *extends9;
/**
 * 地表破裂（断塞塘等）高/深 [米]
 */
//@Column(name="height")
@property (nonatomic, strong) NSString * height;
/**
 * 审查意见
 */
//@Column(name="examine_comments")
@property (nonatomic, strong) NSString *examineComments;
/**
 * 描述
 */
//@Column(name="comment_info")
@property (nonatomic, strong) NSString *commentInfo;
/**
 * 乡
 */
//@Column(name="town")
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *type;
/**
 * 村
 */
//@Column(name="village")
@property (nonatomic, strong) NSString *village;
/**
 * 备选字段13
 */
//@Column(name="extends13")
@property (nonatomic, strong) NSString *extends13;
/**
 * 备选字段27
 */
//@Column(name="extends27")
@property (nonatomic, strong) NSString *extends27;
/**
 * 编号
 */
//@Column(name="object_code")
@property (nonatomic, strong) NSString *objectCode;
/**
 * 地貌点类型
 */
//@Column(name="geomorphytype")
@property (nonatomic, strong) NSString *geomorphytype;
/**
 * 走向水平位移 [米]
 */
//@Column(name="horizenoffset")
@property (nonatomic, strong) NSString * horizenoffset;
/**
 * 备选字段3
 */
//@Column(name="extends3")
@property (nonatomic, strong) NSString *extends3;
/**
 * 创建人
 */
//@Column(name="create_user")
@property (nonatomic, strong) NSString *createUser;
/**
 * 拍摄者
 */
//@Column(name="photographer")
@property (nonatomic, strong) NSString *photographer;
/**
 * 备选字段20
 */
//@Column(name="extends20")
@property (nonatomic, strong) NSString *extends20;
/**
 * 任务名称
 */
//@Column(name="task_name")
@property (nonatomic, strong) NSString *taskName;
/**
 * 创建时间
 */
//@Column(name="create_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *createTime;
/**
 * 备选字段7
 */
//@Column(name="extends7")
@property (nonatomic, strong) NSString *extends7;
/**
 * 是否为已知地震的地表破裂
 */
//@Column(name="issurfacerupturebelt")
@property (nonatomic, strong) NSString *issurfacerupturebelt;
/**
 * 区（县）
 */
//@Column(name="area")
@property (nonatomic, strong) NSString *area;
/**
 * 备选字段19
 */
//@Column(name="extends19")
@property (nonatomic, strong) NSString *extends19;
/**
 * 备选字段14
 */
//@Column(name="extends14")
@property (nonatomic, strong) NSString *extends14;
/**
 * 审核状态（保存）
 */
//@Column(name="review_status")
@property (nonatomic, strong) NSString *reviewStatus;
/**
 * 项目名称
 */
//@Column(name="project_name")
@property (nonatomic, strong) NSString *projectName;
/**
 * 质检状态
 */
//@Column(name="qualityinspection_status")
@property (nonatomic, strong) NSString *qualityinspectionStatus;
/**
 * 地表破裂（断塞塘等）长 [米]
 */
//@Column(name="length")
@property (nonatomic, strong) NSString * length;
/**
 * 质检时间
 */
//@Column(name="qualityinspection_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *qualityinspectionDate;
/**
 * 地貌线走向（制图用）
 */
//@Column(name="geomorphylndirection")
@property (nonatomic, strong) NSString *geomorphylndirection;
/**
 * 备选字段28
 */
//@Column(name="extends28")
@property (nonatomic, strong) NSString *extends28;
/**
 * 审查时间
 */
//@Column(name="examine_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *examineDate;
/**
 * 编号
 */
//@Id
//@Column(name="id")
@property (nonatomic, strong) NSString *id;
/**
 * 平面图文件编号
 */
//@Column(name="sketch_aiid")
@property (nonatomic, strong) NSString *sketchAiid;
/**
 * 省
 */
//@Column(name="province")
@property (nonatomic, strong) NSString *province;
/**
 * 删除标识
 */
//@Column(name="is_valid")
@property (nonatomic, strong) NSString *isValid;
/**
 * 备选字段2
 */
//@Column(name="extends2")
@property (nonatomic, strong) NSString *extends2;
/**
 * 地貌点名称
 */
//@Column(name="geomorphyname")
@property (nonatomic, strong) NSString *geomorphyname;
/**
 * 备选字段11
 */
//@Column(name="extends11")
@property (nonatomic, strong) NSString *extends11;
/**
 * 备选字段26
 */
//@Column(name="extends26")
@property (nonatomic, strong) NSString *extends26;
/**
 * 地貌代码
 */
//@Column(name="geomorphycode")
@property (nonatomic, strong) NSString *geomorphycode;
/**
 * 是否在图中显示
 */
//@Column(name="isinmap")
@property (nonatomic, strong) NSString *isinmap;
/**
 * 备选字段22
 */
//@Column(name="extends22")
@property (nonatomic, strong) NSString *extends22;
/**
 * 是否修改工作底图
 */
//@Column(name="ismodifyworkmap")
@property (nonatomic, strong) NSString *ismodifyworkmap;
/**
 * 备选字段30
 */
//@Column(name="extends30")
@property (nonatomic, strong) NSString *extends30;
/**
 * 形成时代
 */
//@Column(name="createdate")
@property (nonatomic, strong) NSString *createdate;
@property (nonatomic, strong) NSString *createdateName;
/**
 * 典型剖面图图表文件编号
 */
//@Column(name="typicalprofile_aiid")
@property (nonatomic, strong) NSString *typicalprofileAiid;
/**
 * 备选字段15
 */
//@Column(name="extends15")
@property (nonatomic, strong) NSString *extends15;
/**
 * 平面图原始文件编号
 */
//@Column(name="sketch_arwid")
@property (nonatomic, strong) NSString *sketchArwid;
@property (nonatomic, strong) NSString *userId;

/// 保存
/// @param body body
/// @param completion nil
+ (void)saveWithBody:(YXGeoGeomorphySvyPointModel *)body completion:(void(^)(NSError *error))completion;
//查询详情
+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXGeoGeomorphySvyPointModel *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
