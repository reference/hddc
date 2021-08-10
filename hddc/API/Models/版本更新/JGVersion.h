//
//  JGVersion.h
//  BuildingCollectSystem
//
//  Created by admin on 2021/5/28.
//  Copyright © 2021 Johnson. All rights reserved.
//
//  版本更新
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGVersion : NSObject
@property (nonatomic, strong) NSString *versionAppCode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *isForceUpdate;

+ (void)requestVersion:(void(^)(JGVersion *m,NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
