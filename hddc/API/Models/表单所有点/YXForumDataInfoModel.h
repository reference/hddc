//
//  YXForumDataInfoModel.h
//  BDGuPiao
//
//  Created by admin on 2020/12/29.
//  Copyright © 2020 B-A-N. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXForumDataInfoModel : NSObject
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, assign) NSInteger type; //表单类型 1-24
@property (nonatomic, strong) NSString *uuid;

+ (void)requestUserId:(NSString *)uid completion:(void(^)(NSArray <YXForumDataInfoModel *> *ms,NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
