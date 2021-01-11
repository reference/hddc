//
//  YXTracePointModel.h
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXTracePointModel : NSObject

/**
     * 开始时间
     */
    //@Column(name="start_time")
    //@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
    @property (nonatomic, strong) NSString *startTime;
    /**
     * 备注4
     */
    //@Column(name="remark4")
    @property (nonatomic, strong) NSString *remark4;
    /**
     * 点集合
     */
    //@Column(name="lonlat_array")
    @property (nonatomic, strong) NSString *lonlatArray;
    /**
     * 修改时间
     */
    //@Column(name="update_time")
    //@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
    @property (nonatomic, strong) NSString *updateTime;
    /**
     * 创建时间
     */
    //@Column(name="create_time")
    //@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
    @property (nonatomic, strong) NSString *createTime;
    /**
     * 结束时间
     */
    //@Column(name="end_time")
    //@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
    @property (nonatomic, strong) NSString *endTime;
    /**
     * 修改人
     */
    //@Column(name="update_user")
    @property (nonatomic, strong) NSString *updateUser;
    /**
     * 备注2
     */
    //@Column(name="remark2")
    @property (nonatomic, strong) NSString *remark2;
    /**
     * 任务Id
     */
    //@Column(name="task_id")
    @property (nonatomic, strong) NSString *taskId;
    /**
     * 备注
     */
    //@Column(name="remark")
    @property (nonatomic, strong) NSString *remark;
    /**
     * 主键
     */
    //@Column(name="uuid")
    @property (nonatomic, strong) NSString *uuid;
    /**
     * 用户Id
     */
    //@Column(name="user_id")
    @property (nonatomic, strong) NSString *userId;
    /**
     * 创建人
     */
    //@Column(name="create_user")
    @property (nonatomic, strong) NSString *createUser;
    /**
     * 备注3
     */
    //@Column(name="remark3")
    @property (nonatomic, strong) NSString *remark3;


/// 新增
/// @param body 必填参数 ：
/// @param completion nil
+ (void)saveWithBody:(YXTracePointModel *)body completion:(void(^)(NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
