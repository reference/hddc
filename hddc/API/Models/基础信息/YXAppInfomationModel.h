//
//  YXAppInfomationModel.h
//  BDGuPiao
//
//  Created by admin on 2020/12/12.
//  Copyright © 2020 B-A-N. All rights reserved.
//
//  test
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXAppInfomationModel : NSObject

/// 获取列表
/// @param uid <#uid description#>
/// @param tid <#tid description#>
/// @param pid <#pid description#>
/// @param type <#type description#>
/// @param completion <#completion description#>
+ (void)requestInfomationWithUserId:(NSString *)uid taskId:(NSString *)tid projectId:(NSString *)pid type:(NSInteger)type completion:(void(^)(NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
