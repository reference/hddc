//
//  GPFormBaseController.h
//  BDGuPiao
//
//  Created by admin on 2020/11/28.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import "KKBaseViewController.h"
#import "GPAdministrativeDivisionsModel.h"
#import "GPTaskImagesCell.h"
#import "GPImageEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPFormBaseController : KKBaseViewController
//header view
@property (nonatomic, strong) IBOutlet UIView *tableHeaderView;
@property (nonatomic, strong) IBOutlet UILabel *provinceLabel;
@property (nonatomic, strong) IBOutlet UILabel *cityLabel;
@property (nonatomic, strong) IBOutlet UILabel *zoneLabel;

@property (nonatomic,strong) IBOutletCollection(UILabel) NSArray <UILabel *> *titleLabels;
//更多按钮
@property (nonatomic, strong) IBOutlet UIButton *moreButton;
@property (nonatomic, strong) GPAdministrativeDivisionsModel *province;
@property (nonatomic, strong) GPAdministrativeDivisionsModel *city;
@property (nonatomic, strong) GPAdministrativeDivisionsModel *zone;
// 10 个图片的实体
@property (nonatomic, strong) NSMutableArray <GPImageEntity *> *imageEntities;

@property (nonatomic, assign) double tableViewHeaderHeight;

//star
- (void)setupTitleLabels;

//location坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//项目
@property (nonatomic, strong) YXProject *projectModel;
//任务
@property (nonatomic, strong) YXTaskModel *taskModel;

/// 24个表单 type 从1到24 参考dixingType.json
@property (nonatomic, strong) NSString *type;

//页面的模式 默认新增
@property (nonatomic, assign) InterfaceStatus interfaceStatus;
//查询表单列表传过来的
@property (nonatomic, strong) YXFormListModel *forumListModel;

//本地表单 包含数据
@property (nonatomic, strong) YXTable *table;

/// 获得图片数组
/// @param url 用逗号分隔
+ (NSArray <GPImageEntity *>*)imageEntitiesWithUrl:(NSString *)url;
+ (NSString *)localPathsOfImageEntities:(NSArray <GPImageEntity *> *)entities;

/// 请求详情资料 这个方法需要子类重写
- (void)api_loadDetail;

/// 给页面赋值并展示，这个方法需要在子类重写
/// @param model 24个模型
- (void)setUpUIByModel:(id)model;

/// 判定基础数据 包括省市区、经纬度、详细地址、编号
/// @param completion nil
- (void)judgeBaseDataWhenFinished:(void(^)(BOOL pass))completion;
//没有id字段的校验
- (void)judgeBaseDataWithoutIdWhenFinished:(void(^)(BOOL pass))completion;
@end

NS_ASSUME_NONNULL_END
