//
//  YXSlectionDictModel.h
//  BDGuPiao
//
//  Created by admin on 2020/12/3.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  下拉字典选项
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    FormType_None = 0,
    FormType_FaultSvyPoint, //断层观测点-点
    FormType_GeoGeomorphySvyPoint, //地质地貌调查观测点-点
    FormType_GeologicalSvyPoint, //地质调查观测点-点
    FormType_StratigraphySvyPoint, //地层观测点-点
    FormType_Trench,//探槽-点
    FormType_GeomorphySvyLine,//微地貌测量线-线
    FormType_DrillHole,//钻孔-点
    FormType_SamplePoint,//采样点-点
    FormType_GeophySvyLine,//地球物理测线-线
    FormType_GeophySvyPoint,//地球物理测点-点
    FormType_GeochemicalSvyLine,//地球化学探测测线-线
    FormType_GeochemicalSvyPoint,//地球化学探测测点-点
    FormType_Crater,//火山口-点
    FormType_Lava,//熔岩流-面
    FormType_VolcanicSamplePoint//火山采样点-点
}FormType;

@interface YXSlectionDictModel : NSObject
@property (nonatomic, strong) NSString *dictItemId;
@property (nonatomic, strong) NSString *dictId;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *createUser;
@property (nonatomic, strong) NSString *dictItemName;
@property (nonatomic, strong) NSString *isValid;
@property (nonatomic, strong) NSString *dictItemCode;
@property (nonatomic, strong) NSString *updateUser;
@property (nonatomic, strong) NSString *description;

/// 获得下拉列表的选项
/// @param type type
/// @param code code
/// @param completion nil
+ (void)requestDictWithType:(FormType)type code:(NSString *)code completion:(void(^)(NSArray <YXSlectionDictModel *> *ms,NSError *error))completion;

+ (void)requestLocalWithCode:(NSString *)code completion:(void(^)(NSArray <YXSlectionDictModel *> *ms,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
