//
//  YXAppBannerModel.h
//  YunXiangAlive
//
//  Created by B-A-N on 2020/7/14.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  banner图接口

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface YXAppBanner : NSObject
@property (nonatomic, strong) NSNumber *blankType;
@property (nonatomic, strong) NSString *blankUrl;
@property (nonatomic, strong) NSString *client;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSNumber *isBlank;
@property (nonatomic, strong) NSNumber *isEnable;
@property (nonatomic, strong) NSNumber *positon;
@end

@interface YXAppBannerModel : NSObject
@property (nonatomic, strong) NSArray<YXAppBanner *> *records;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger current;
@property (nonatomic, assign) NSInteger searchCount;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger hitCount;
@property (nonatomic, assign) NSInteger optimizeCountSql;
@property (nonatomic, strong) NSArray *orders; //what's this?

/// banner图接口
/// @param pos position  1shi首页 2是商学院 3是优选
/// @param completion nil
+ (void)requestBannerWithPosition:(NSInteger)pos completion:(void(^)(YXAppBannerModel *m,NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
