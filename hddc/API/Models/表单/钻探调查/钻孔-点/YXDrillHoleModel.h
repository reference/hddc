//
//  YXDrillHoleModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  钻孔-点

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXDrillHoleModel : NSObject
/**
 * 钻探地点
 */
//@Column(name="locationname")
@property (nonatomic, strong) NSString *locationname;
/**
 * 钻探日期
 */
//@Column(name="drilldate")
@property (nonatomic, strong) NSString *drilldate;
/**
 * 备选字段25
 */
//@Column(name="extends25")
@property (nonatomic, strong) NSString *extends25;
/**
 * 钻孔孔深检查编号
 */
//@Column(name="depthcheck_aiid")
@property (nonatomic, strong) NSString *depthcheckAiid;
/**
 * 井斜测量结果登记表原始文件编号
 */
//@Column(name="wellclination_arwid")
@property (nonatomic, strong) NSString *wellclinationArwid;
/**
 * 封孔设计及封孔报告书原始文件编号
 */
//@Column(name="sealdesignreport_arwid")
@property (nonatomic, strong) NSString *sealdesignreportArwid;
/**
 * 备选字段8
 */
//@Column(name="extends8")
@property (nonatomic, strong) NSString *extends8;
/**
 * 钻孔柱状图图像文件编号
 */
//@Column(name="columnchart_aiid")
@property (nonatomic, strong) NSString *columnchartAiid;
/**
 * 野外编号
 */
//@Column(name="fieldid")
@property (nonatomic, strong) NSString *fieldid;
/**
 * 备选字段14
 */
//@Column(name="extends14")
@property (nonatomic, strong) NSString *extends14;
/**
 * 孔位经度
 */
//@Column(name="lon")
@property (nonatomic, strong) NSString *lon;
/**
 * 备选字段27
 */
//@Column(name="extends27")
@property (nonatomic, strong) NSString *extends27;
/**
 * 分区标识
 */
//@Column(name="partion_flag")
@property (nonatomic, strong) NSString *partionFlag;
/**
 * 备选字段17
 */
//@Column(name="extends17")
@property (nonatomic, strong) NSString *extends17;
/**
 * 备选字段7
 */
//@Column(name="extends7")
@property (nonatomic, strong) NSString *extends7;
/**
 * 钻孔班报原始文件编号
 */
//@Column(name="drillinglog_arwid")
@property (nonatomic, strong) NSString *drillinglogArwid;
/**
 * 是否开展地球物理测井
 */
//@Column(name="isgeophywell")
@property (nonatomic, strong) NSString *isgeophywell;
/**
 * 中更新统厚度 [米]
 */
//@Column(name="midpleithickness")
@property (nonatomic, strong) NSString *midpleithickness;
/**
 * 项目名称
 */
//@Column(name="project_name")
@property (nonatomic, strong) NSString *projectName;
/**
 * 钻孔编号
 */
//@Id
//@Column(name="id")
@property (nonatomic, strong) NSString *id;
/**
 * 备注
 */
//@Column(name="remark")
@property (nonatomic, strong) NSString *remark;
/**
 * 任务名称
 */
//@Column(name="task_name")
@property (nonatomic, strong) NSString *taskName;
/**
 * 孔深 [米]
 */
//@Column(name="depth")
@property (nonatomic, strong) NSString *depth;
/**
 * 备选字段6
 */
//@Column(name="extends6")
@property (nonatomic, strong) NSString *extends6;
/**
 * 备选字段5
 */
//@Column(name="extends5")
@property (nonatomic, strong) NSString *extends5;
/**
 * 质检时间
 */
//@Column(name="qualityinspection_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *qualityinspectionDate;
/**
 * 备选字段23
 */
//@Column(name="extends23")
@property (nonatomic, strong) NSString *extends23;
/**
 * 项目ID
 */
//@Column(name="project_code")
@property (nonatomic, strong) NSString *projectCode;
/**
 * 采样记录表编号
 */
//@Column(name="geologysmplrec_aiid")
@property (nonatomic, strong) NSString *geologysmplrecAiid;
/**
 * 质检人
 */
//@Column(name="qualityinspection_user")
@property (nonatomic, strong) NSString *qualityinspectionUser;
/**
 * 全新统厚度 [米]
 */
//@Column(name="holocenethickness")
@property (nonatomic, strong) NSString *holocenethickness;
/**
 * 钻孔质量验收报告原始文件编号
 */
//@Column(name="sealcheck_arwid")
@property (nonatomic, strong) NSString *sealcheckArwid;
/**
 * 工程编号
 */
//@Column(name="projectid")
@property (nonatomic, strong) NSString *projectid;
/**
 * 采集环境与工程样品数
 */
//@Column(name="collectedenviromentsamplecount")
@property (nonatomic, strong) NSString *collectedenviromentsamplecount;
/**
 * 创建时间
 */
//@Column(name="create_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *createTime;
/**
 * 修改人
 */
//@Column(name="update_user")
@property (nonatomic, strong) NSString *updateUser;
/**
 * 村
 */
//@Column(name="village")
@property (nonatomic, strong) NSString *village;
/**
 * 编号
 */
//@Column(name="object_code")
@property (nonatomic, strong) NSString *objectCode;
/**
 * 质检状态
 */
//@Column(name="qualityinspection_status")
@property (nonatomic, strong) NSString *qualityinspectionStatus;
/**
 * 采集样品总数
 */
//@Column(name="collectedsamplecount")
@property (nonatomic, strong) NSString *collectedsamplecount;
/**
 * 前第四纪厚度 [米]
 */
//@Column(name="prepleithickness")
@property (nonatomic, strong) NSString *prepleithickness;
/**
 * 备选字段2
 */
//@Column(name="extends2")
@property (nonatomic, strong) NSString *extends2;
/**
 * 岩芯总长 [米]
 */
//@Column(name="coretotalthickness")
@property (nonatomic, strong) NSString *coretotalthickness;
/**
 * 审核状态（保存）
 */
//@Column(name="review_status")
@property (nonatomic, strong) NSString *reviewStatus;
/**
 * 原始岩芯编录表原始
 */
//@Column(name="corecatalog_arwid")
@property (nonatomic, strong) NSString *corecatalogArwid;
/**
 * 备选字段16
 */
//@Column(name="extends16")
@property (nonatomic, strong) NSString *extends16;
/**
 * 孔口标高 [米]
 */
//@Column(name="elevation")
@property (nonatomic, strong) NSString *elevation;
/**
 * 井斜测量结果登记表文件编号
 */
//@Column(name="wellclination_aiid")
@property (nonatomic, strong) NSString *wellclinationAiid;
/**
 * 获得结果样品总数
 */
//@Column(name="datingsamplecount")
@property (nonatomic, strong) NSString *datingsamplecount;
/**
 * 备选字段18
 */
//@Column(name="extends18")
@property (nonatomic, strong) NSString *extends18;
/**
 * 市
 */
//@Column(name="city")
@property (nonatomic, strong) NSString *city;
/**
 * 钻孔质量验收报告文件编号
 */
//@Column(name="sealcheck_arid")
@property (nonatomic, strong) NSString *sealcheckArid;
/**
 * 备选字段3
 */
//@Column(name="extends3")
@property (nonatomic, strong) NSString *extends3;
/**
 * 区（县）
 */
//@Column(name="area")
@property (nonatomic, strong) NSString *area;
/**
 * 环境与工程样品送样总数
 */
//@Column(name="enviromentsamplecount")
@property (nonatomic, strong) NSString *enviromentsamplecount;
/**
 * 备选字段22
 */
//@Column(name="extends22")
@property (nonatomic, strong) NSString *extends22;
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
 * 备选字段11
 */
//@Column(name="extends11")
@property (nonatomic, strong) NSString *extends11;
/**
 * 钻孔描述
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
 * 钻孔孔深检查原始文件编号
 */
//@Column(name="depthcheck_arwid")
@property (nonatomic, strong) NSString *depthcheckArwid;
/**
 * 孔位纬度
 */
//@Column(name="lat")
@property (nonatomic, strong) NSString *lat;
/**
 * 备选字段4
 */
//@Column(name="extends4")
@property (nonatomic, strong) NSString *extends4;
/**
 * 审查人
 */
//@Column(name="examine_user")
@property (nonatomic, strong) NSString *examineUser;
/**
 * 上更新统厚度 [米]
 */
//@Column(name="uppleithickness")
@property (nonatomic, strong) NSString *uppleithickness;
/**
 * 钻探目的
 */
//@Column(name="purpose")
@property (nonatomic, strong) NSString *purpose;
/**
 * 备选字段19
 */
//@Column(name="extends19")
@property (nonatomic, strong) NSString *extends19;
/**
 * 备选字段13
 */
//@Column(name="extends13")
@property (nonatomic, strong) NSString *extends13;
/**
 * 修改时间
 */
//@Column(name="update_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *updateTime;
/**
 * 备选字段9
 */
//@Column(name="extends9")
@property (nonatomic, strong) NSString *extends9;
/**
 * 钻孔剖面编号
 */
//@Column(name="profileid")
@property (nonatomic, strong) NSString *profileid;
/**
 * 备选字段28
 */
//@Column(name="extends28")
@property (nonatomic, strong) NSString *extends28;
/**
 * 钻孔班报编号
 */
//@Column(name="drillinglog_aiid")
@property (nonatomic, strong) NSString *drillinglogAiid;
/**
 * 质检原因
 */
//@Column(name="qualityinspection_comments")
@property (nonatomic, strong) NSString *qualityinspectionComments;
/**
 * 下更新统厚度 [米]
 */
//@Column(name="lowpleithickness")
@property (nonatomic, strong) NSString *lowpleithickness;
/**
 * 简易水文观测记录表原始
 */
//@Column(name="hydrorecord_arwid")
@property (nonatomic, strong) NSString *hydrorecordArwid;
/**
 * 原始岩芯编录表图像文件编号
 */
//@Column(name="corecatalog_aiid")
@property (nonatomic, strong) NSString *corecatalogAiid;
/**
 * 省
 */
//@Column(name="province")
@property (nonatomic, strong) NSString *province;
/**
 * 钻孔柱状图原始档案编号
 */
//@Column(name="columnchart_arwid")
@property (nonatomic, strong) NSString *columnchartArwid;
/**
 * 封孔设计及封孔报告书文件编号
 */
//@Column(name="sealdesignreport_arid")
@property (nonatomic, strong) NSString *sealdesignreportArid;
/**
 * 岩芯照片图像档案编号
 */
//@Column(name="corephoto_aiid")
@property (nonatomic, strong) NSString *corephotoAiid;
/**
 * 删除标识
 */
//@Column(name="is_valid")
@property (nonatomic, strong) NSString *isValid;
/**
 * 备选字段21
 */
//@Column(name="extends21")
@property (nonatomic, strong) NSString *extends21;
/**
 * 备选字段20
 */
//@Column(name="extends20")
@property (nonatomic, strong) NSString *extends20;
/**
 * 钻孔来源与类型
 */
//@Column(name="drillsource")
@property (nonatomic, strong) NSString *drillsource;
@property (nonatomic, strong) NSString *drillsourceName;
/**
 * 备选字段26
 */
//@Column(name="extends26")
@property (nonatomic, strong) NSString *extends26;
/**
 * 任务ID
 */
//@Column(name="task_id")
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *projectId;

/**
 * 备选字段15
 */
//@Column(name="extends15")
@property (nonatomic, strong) NSString *extends15;
/**
 * 备选字段12
 */
//@Column(name="extends12")
@property (nonatomic, strong) NSString *extends12;
/**
 * 采样记录表原始文件编号
 */
//@Column(name="geologysmplrec_arwid")
@property (nonatomic, strong) NSString *geologysmplrecArwid;
/**
 * 简易水文观测记录表
 */
//@Column(name="hydrorecord_aiid")
@property (nonatomic, strong) NSString *hydrorecordAiid;
/**
 * 备选字段1
 */
//@Column(name="extends1")
@property (nonatomic, strong) NSString *extends1;
/**
 * 获得测试结果的环境与工程样品数
 */
//@Column(name="testedenviromentsamplecount")
@property (nonatomic, strong) NSString *testedenviromentsamplecount;
/**
 * 备选字段10
 */
//@Column(name="extends10")
@property (nonatomic, strong) NSString *extends10;
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
 * 审查时间
 */
//@Column(name="examine_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *examineDate;
/**
 * 送样总数
 */
//@Column(name="samplecount")
@property (nonatomic, strong) NSString *samplecount;
/**
 * 岩芯照片原始档案编号
 */
//@Column(name="corephoto_arwid")
@property (nonatomic, strong) NSString *corephotoArwid;
/**
 * 审查意见
 */
//@Column(name="examine_comments")
@property (nonatomic, strong) NSString *examineComments;
@property (nonatomic, strong) NSString *userId;

/// 保存
/// //////@param body body
/// //////@param completion nil
+ (void)saveWithBody:(YXDrillHoleModel *)body completion:(void(^)(NSError *error))completion;

//查询详情
+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXDrillHoleModel *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
