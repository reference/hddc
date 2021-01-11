//
//  YXCraterModel.h
//  BDGuPiao
//
//  Created by admin on 2020/11/27.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  火山口-点

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXCraterModel : NSObject
/**
 * 项目名称
 */
//@Column(name="project_name")
@property (nonatomic, strong) NSString *projectName;
/**
 * 备选字段6
 */
//@Column(name="extends6")
@property (nonatomic, strong) NSString *extends6;
/**
 * 塑性熔岩饼单体尺寸
 */
//@Column(name="lavadribletsize")
@property (nonatomic, strong) NSString *lavadribletsize;
/**
 * 备选字段25
 */
//@Column(name="extends25")
@property (nonatomic, strong) NSString *extends25;
/**
 * 火口直径
 */
//@Column(name="craterdiameter")
@property (nonatomic, strong) NSString *craterdiameter;
/**
 * 质检状态
 */
//@Column(name="qualityinspection_status")
@property (nonatomic, strong) NSString *qualityinspectionStatus;
/**
 * 锥体结构组成剖面图原始文件
 */
//@Column(name="conestructureprofile_arwid")
@property (nonatomic, strong) NSString *conestructureprofileArwid;
/**
 * 锥体形态
 */
//@Column(name="conemorphology")
@property (nonatomic, strong) NSString *conemorphology;
/**
 * 备选字段7
 */
//@Column(name="extends7")
@property (nonatomic, strong) NSString *extends7;
/**
 * 乡
 */
//@Column(name="town")
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *type;

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
 * 删除标识
 */
//@Column(name="is_valid")
@property (nonatomic, strong) NSString *isValid;
/**
 * 溢出口方向
 */
//@Column(name="overfalldirection")
@property (nonatomic, strong) NSString *overfalldirection;
@property (nonatomic, strong) NSString *overfalldirectionName;
/**
 * 备选字段20
 */
//@Column(name="extends20")
@property (nonatomic, strong) NSString *extends20;
/**
 * 备选字段28
 */
//@Column(name="extends28")
@property (nonatomic, strong) NSString *extends28;
/**
 * 外坡度
 */
//@Column(name="outsideslopeangle")
@property (nonatomic, strong) NSString *outsideslopeangle;
/**
 * 锥体底部直径
 */
//@Column(name="bottomdiameter")
@property (nonatomic, strong) NSString *bottomdiameter;
/**
 * 备选字段19
 */
//@Column(name="extends19")
@property (nonatomic, strong) NSString *extends19;
/**
 * 备选字段9
 */
//@Column(name="extends9")
@property (nonatomic, strong) NSString *extends9;
/**
 * 创建时间
 */
//@Column(name="create_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *createTime;
/**
 * 备选字段26
 */
//@Column(name="extends26")
@property (nonatomic, strong) NSString *extends26;
/**
 * 质检时间
 */
//@Column(name="qualityinspection_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *qualityinspectionDate;
/**
 * 备选字段22
 */
//@Column(name="extends22")
@property (nonatomic, strong) NSString *extends22;
/**
 * 备注
 */
//@Column(name="remark")
@property (nonatomic, strong) NSString *remark;
/**
 * 修改人
 */
//@Column(name="update_user")
@property (nonatomic, strong) NSString *updateUser;
/**
 * 备选字段1
 */
//@Column(name="extends1")
@property (nonatomic, strong) NSString *extends1;
/**
 * 备注
 */
//@Column(name="comment_info")
@property (nonatomic, strong) NSString *commentInfo;
/**
 * 岩石包体粒度
 */
//@Column(name="rockinclusiongranularity")
@property (nonatomic, strong) NSString *rockinclusiongranularity;
/**
 * 区（县）
 */
//@Column(name="area")
@property (nonatomic, strong) NSString *area;
/**
 * 备选字段10
 */
//@Column(name="extends10")
@property (nonatomic, strong) NSString *extends10;
/**
 * 任务名称
 */
//@Column(name="task_name")
@property (nonatomic, strong) NSString *taskName;
/**
 * 创建人
 */
//@Column(name="create_user")
@property (nonatomic, strong) NSString *createUser;
/**
 * 备选字段24
 */
//@Column(name="extends24")
@property (nonatomic, strong) NSString *extends24;
/**
 * 岩石包体产出状态
 */
//@Column(name="rockinclusionoutputstate")
@property (nonatomic, strong) NSString *rockinclusionoutputstate;
/**
 * 堆积物类型
 */
//@Column(name="deposittype")
@property (nonatomic, strong) NSString *deposittype;
/**
 * 质检人
 */
//@Column(name="qualityinspection_user")
@property (nonatomic, strong) NSString *qualityinspectionUser;
/**
 * 素描图图像
 */
//@Column(name="sketch_aiid")
@property (nonatomic, strong) NSString *sketchAiid;
/**
 * 锥体名称
 */
//@Column(name="conename")
@property (nonatomic, strong) NSString *conename;
/**
 * 审核状态（保存）
 */
//@Column(name="review_status")
@property (nonatomic, strong) NSString *reviewStatus;
/**
 * 备选字段15
 */
//@Column(name="extends15")
@property (nonatomic, strong) NSString *extends15;
/**
 * 照片集镜向及拍摄者说明文档
 */
//@Column(name="photodesc_arwid")
@property (nonatomic, strong) NSString *photodescArwid;
/**
 * 岩石包体形状
 */
//@Column(name="rockinclusionshape")
@property (nonatomic, strong) NSString *rockinclusionshape;
/**
 * 备选字段4
 */
//@Column(name="extends4")
@property (nonatomic, strong) NSString *extends4;
/**
 * 备选字段13
 */
//@Column(name="extends13")
@property (nonatomic, strong) NSString *extends13;
/**
 * 备选字段8
 */
//@Column(name="extends8")
@property (nonatomic, strong) NSString *extends8;
/**
 * 锥体结构组成剖面图图片
 */
//@Column(name="conestructureprofile_aiid")
@property (nonatomic, strong) NSString *conestructureprofileAiid;
/**
 * 岩石包体数量
 */
//@Column(name="rockinclusionnum")
@property (nonatomic, strong) NSString *rockinclusionnum;
/**
 * 修改时间
 */
//@Column(name="update_time")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *updateTime;
/**
 * 锥体类型
 */
//@Column(name="conetype")
@property (nonatomic, strong) NSString *conetype;
/**
 * 备选字段17
 */
//@Column(name="extends17")
@property (nonatomic, strong) NSString *extends17;
/**
 * 备选字段11
 */
//@Column(name="extends11")
@property (nonatomic, strong) NSString *extends11;
/**
 * 照片文件编号
 */
//@Column(name="photo_aiid")
@property (nonatomic, strong) NSString *photoAiid;
/**
 * DepositThickness
 */
//@Column(name="depositthickness")
@property (nonatomic, strong) NSString *depositthickness;
/**
 * 照片原始文件编号
 */
//@Column(name="photo_arwid")
@property (nonatomic, strong) NSString *photoArwid;
/**
 * 备选字段18
 */
//@Column(name="extends18")
@property (nonatomic, strong) NSString *extends18;
/**
 * 项目ID
 */
//@Column(name="project_id")
@property (nonatomic, strong) NSString *projectId;
/**
 * 火口深度[米]
 */
//@Column(name="craterdepth")
@property (nonatomic, strong) NSString *craterdepth;
/**
 * 备选字段14
 */
//@Column(name="extends14")
@property (nonatomic, strong) NSString *extends14;
/**
 * 岩石包体类型
 */
//@Column(name="rockinclusiontype")
@property (nonatomic, strong) NSString *rockinclusiontype;
/**
 * 火口垣直径
 */
//@Column(name="craterwallsdiameter")
@property (nonatomic, strong) NSString *craterwallsdiameter;
/**
 * 审查时间
 */
//@Column(name="examine_date")
//@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
@property (nonatomic, strong) NSString *examineDate;
/**
 * 备选字段5
 */
//@Column(name="extends5")
@property (nonatomic, strong) NSString *extends5;
/**
 * 分区标识
 */
//@Column(name="partion_flag")
@property (nonatomic, strong) NSString *partionFlag;
/**
 * 备选字段3
 */
//@Column(name="extends3")
@property (nonatomic, strong) NSString *extends3;
/**
 * 拍摄者
 */
//@Column(name="photographer")
@property (nonatomic, strong) NSString *photographer;
/**
 * 备选字段2
 */
//@Column(name="extends2")
@property (nonatomic, strong) NSString *extends2;
/**
 * 村
 */
//@Column(name="village")
@property (nonatomic, strong) NSString *village;
/**
 * 备选字段30
 */
//@Column(name="extends30")
@property (nonatomic, strong) NSString *extends30;
/**
 * 素描图原始文件
 */
//@Column(name="sketch_arwid")
@property (nonatomic, strong) NSString *sketchArwid;
/**
 * 堆积物粒度
 */
//@Column(name="depositgranularity")
@property (nonatomic, strong) NSString *depositgranularity;
/**
 * 火山口编号
 */
//@Id
//@Column(name="id")
@property (nonatomic, strong) NSString *id;
/**
 * 备选字段29
 */
//@Column(name="extends29")
@property (nonatomic, strong) NSString *extends29;
/**
 * 审查人
 */
//@Column(name="examine_user")
@property (nonatomic, strong) NSString *examineUser;
/**
 * 质检原因
 */
//@Column(name="qualityinspection_comments")
@property (nonatomic, strong) NSString *qualityinspectionComments;
/**
 * 编号
 */
//@Column(name="object_code")
@property (nonatomic, strong) NSString *objectCode;
/**
 * 省
 */
//@Column(name="province")
@property (nonatomic, strong) NSString *province;
/**
 * 备选字段27
 */
//@Column(name="extends27")
@property (nonatomic, strong) NSString *extends27;
/**
 * 内坡度
 */
//@Column(name="insideslopeangle")
@property (nonatomic, strong) NSString *insideslopeangle;
/**
 * 备选字段12
 */
//@Column(name="extends12")
@property (nonatomic, strong) NSString *extends12;
/**
 * 备选字段21
 */
//@Column(name="extends21")
@property (nonatomic, strong) NSString *extends21;
/**
 * 备选字段16
 */
//@Column(name="extends16")
@property (nonatomic, strong) NSString *extends16;
/**
 * 锥体高度[米]
 */
//@Column(name="coneheight")
@property (nonatomic, strong) NSString *coneheight;
/**
 * 审查意见
 */
//@Column(name="examine_comments")
@property (nonatomic, strong) NSString *examineComments;
/**
 * 任务ID
 */
//@Column(name="task_id")
@property (nonatomic, strong) NSString *taskId;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *userId;

/// 保存
/// //////////@param body body
/// //////////@param completion nil
+ (void)saveWithBody:(YXCraterModel *)body completion:(void(^)(NSError *error))completion;

//查询详情
+ (void)requestDetailWithUUID:(NSString *)uuid completion:(void(^)(YXCraterModel *m,NSError *error))completion;
@end


NS_ASSUME_NONNULL_END
